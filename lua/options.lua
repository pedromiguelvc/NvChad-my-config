local opt = vim.opt
local g = vim.g
local wo = vim.wo

-------------------------------------- options ------------------------------------------
opt.laststatus = 3 -- global statusline
opt.showmode = false
opt.cmdheight = 0

opt.wrap = true
opt.linebreak = true
opt.breakindent = true

opt.cursorline = true
opt.guicursor = "n-v-c:block," .. "i:ver25-blinkon100," .. "r-cr:hor20," .. "o:hor50"

-- Indenting
opt.expandtab = true
opt.shiftwidth = 4
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
g.health = { style = "float" }

-- folding
wo.foldmethod = "expr"
wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
wo.foldlevel = 99 -- Keep folders open in start
wo.foldenable = true
