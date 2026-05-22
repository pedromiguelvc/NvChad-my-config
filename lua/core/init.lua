local opt = vim.opt
local g = vim.g
local wo = vim.wo
local api = vim.api
local alias = api.nvim_command
local autocmd = api.nvim_create_autocmd

local config = require("core.utils").load_config()

-------------------------------------- globals -----------------------------------------
g.nvchad_theme = config.ui.theme
g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
g.toggle_theme_icon = "   "
g.transparency = config.ui.transparency
g.health = { style = "float" }

-------------------------------------- options ------------------------------------------
opt.laststatus = 3 -- global statusline
opt.showmode = false
opt.cmdheight = 0

opt.wrap = true

opt.cursorline = true
opt.guicursor = "n-v-c:block," .. "i:ver25-blinkon100," .. "r-cr:hor20," .. "o:hor50"

-- Indenting
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2
opt.autoindent = true

opt.fillchars = {
  eob = "¬",
  vert = "│",
  fold = " ",
  diff = "╱",
}
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"
opt.autoread = true

-- Numbers
opt.number = true
opt.numberwidth = 2
opt.ruler = false
opt.relativenumber = true

-- disable nvim intro
opt.shortmess:append "sI"

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 400
opt.undofile = true
opt.inccommand = "split"
opt.scrolloff = 8
opt.sidescrolloff = 8

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"

g.mapleader = " " -- Space key

-- folding
wo.foldmethod = "expr"
wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
wo.foldlevel = 99 -- Keep folders open in start
wo.foldenable = true

-- disable some default providers
for _, provider in ipairs { "node", "perl", "python3", "ruby" } do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end

-- add binaries installed by mason.nvim to path
vim.env.PATH = vim.fn.stdpath "data" .. "/mason/bin" .. ":" .. vim.env.PATH

-------------------------------------- aliases  ------------------------------------------

alias "command! HighlightAll normal! ggVG"
alias "command! Lsr LspRestart"
alias "command! Qa wa | qa"
alias "command! Msq mks! | wa | qa"

-------------------------------------- autocmds ------------------------------------------

autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.hl.on_yank { timeout = 100 }
  end,
  desc = "Highlight yanked text",
})

autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    vim.cmd [[%s/\s\+$//e]]
  end,
  desc = "Trim trailing whitespace on save",
})

autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  pattern = "*",
  callback = function()
    vim.cmd "checktime"
  end,
  desc = "Reload file if changed on disk",
})

autocmd("VimEnter", {
  callback = function(data)
    local directory = vim.fn.isdirectory(data.file) == 1

    if directory then
      vim.cmd.cd(data.file)
      vim.cmd "Telescope file_browser"
    end
  end,
  desc = "Open Telescope file browser when in a directory",
})

autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local line = vim.fn.line
    if line "'\"" > 0 and line "'\"" <= line "$" then
      vim.cmd 'normal! g`"'
    end
  end,
  desc = "Open file at last cursor position",
})

autocmd("FileType", {
  pattern = { "py", "js", "java" },
  callback = function()
    vim.bo.shiftwidth = 4
  end,
  desc = "Set shiftwidth to 4 in the type of files listed above",
})

autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      return
    end
    if client.name == "ruff" then
      -- Disable hover in favor of Pyright
      client.server_capabilities.hoverProvider = false
    end
  end,
  desc = "LSP: Disable hover capability from Ruff",
})

autocmd("BufReadPost", {
  pattern = { "*.py" },
  callback = function()
    local path = vim.fn.expand "%:p"
    if path:match ".venv" or path:match "site%-packges" then
      vim.bo.readonly = true
      vim.bo.modifiable = false
    end
  end,
  desc = "Avoid modify python packges files",
})

autocmd("InsertLeave", {
  callback = function()
    if
      require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
      and not require("luasnip").session.jump_active
    then
      require("luasnip").unlink_current()
    end
  end,
  desc = "Snip autocmd",
})

autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
  end,
  desc = "Dont list quickfix buffers",
})

autocmd("BufWritePost", {
  pattern = vim.tbl_map(function(path)
    return vim.fs.normalize(vim.loop.fs_realpath(path))
  end, vim.fn.glob(vim.fn.stdpath "config" .. "/lua/custom/**/*.lua", true, true, true)),
  group = api.nvim_create_augroup("ReloadNvChad", {}),

  callback = function(opts)
    local fp = vim.fn.fnamemodify(vim.fs.normalize(api.nvim_buf_get_name(opts.buf)), ":r") --[[@as string]]
    local app_name = vim.env.NVIM_APPNAME and vim.env.NVIM_APPNAME or "nvim"
    local module = string.gsub(fp, "^.*/" .. app_name .. "/lua/", ""):gsub("/", ".")

    require("plenary.reload").reload_module "base46"
    require("plenary.reload").reload_module(module)
    require("plenary.reload").reload_module "custom.chadrc"

    config = require("core.utils").load_config()

    g.nvchad_theme = config.ui.theme
    g.transparency = config.ui.transparency

    -- statusline
    if config.ui.statusline.enabled then
      require("plenary.reload").reload_module("nvchad.statusline." .. config.ui.statusline.theme)
      opt.statusline = "%!v:lua.require('nvchad.statusline." .. config.ui.statusline.theme .. "').run()"
    end

    -- tabufline
    if config.ui.tabufline.enabled then
      require("plenary.reload").reload_module "nvchad.tabufline.modules"
      opt.tabline = "%!v:lua.require('nvchad.tabufline.modules').run()"
    end

    require("base46").load_all_highlights()
    -- vim.cmd("redraw!")
  end,
  desc = "Reload some chadrc options on-save",
})

-------------------------------------- commands ------------------------------------------
local new_cmd = api.nvim_create_user_command

new_cmd("NvChadUpdate", function()
  require "nvchad.updater"()
end, {})
