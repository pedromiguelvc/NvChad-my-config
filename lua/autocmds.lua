local autocmd = vim.api.nvim_create_autocmd

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
  pattern = { "lua" },
  callback = function()
    vim.bo.shiftwidth = 2
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
