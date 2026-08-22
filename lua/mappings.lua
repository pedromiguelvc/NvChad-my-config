-- General, non-LSP keymaps. LSP keymaps live in
-- lua/plugins/configs/lspconfig.lua's on_attach (buffer-scoped).

local map = vim.keymap.set

-------------------------------------- general -------------------------------------------

-- navigate within insert mode
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "clear highlights" })

-- adding blank lines
map("n", "zj", "o<Esc>k", { desc = "add blank line below" })
map("n", "zk", "O<Esc>j", { desc = "add blank line above" })

-- better navigation scroll
map("n", "<Up>", "3<C-y>", { desc = "scroll window up" })
map("n", "<Down>", "3<C-e>", { desc = "scroll window down" })

-- move lines
map("n", "<A-j>", "<cmd>m .+1<CR>==", { desc = "move line down" })
map("n", "<A-k>", "<cmd>m .-2<CR>==", { desc = "move line up" })

-- break the line
map("n", "gj", "i<CR><Esc>", { desc = "split line at cursor" })

-- switch between windows
map("n", "<C-h>", "<C-w>h", { desc = "window left" })
map("n", "<C-l>", "<C-w>l", { desc = "window right" })
map("n", "<C-j>", "<C-w>j", { desc = "window down" })
map("n", "<C-k>", "<C-w>k", { desc = "window up" })

-- resize windows
map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "decrease vertical window size" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "increase vertical window size" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "increase horizontal window size" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "decrease horizontal window size" })

-- copy
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "copy whole file" })
map("n", "<C-y>", '"+yy', { desc = "copy line" })

-- navigation
map("n", "<C-d>", "<C-d>zz", { desc = "scroll down half screen" })
map("n", "<C-u>", "<C-u>zz", { desc = "scroll up half screen" })

-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>.
-- Don't use g[j|k] in operator-pending mode so it doesn't alter d, y, c.
local wrap_expr = { expr = true }
map("n", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', vim.tbl_extend("force", wrap_expr, { desc = "move down" }))
map("n", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', vim.tbl_extend("force", wrap_expr, { desc = "move up" }))
map("x", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', vim.tbl_extend("force", wrap_expr, { desc = "move down" }))
map("x", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', vim.tbl_extend("force", wrap_expr, { desc = "move up" }))
map("v", "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', vim.tbl_extend("force", wrap_expr, { desc = "move up" }))
map("v", "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', vim.tbl_extend("force", wrap_expr, { desc = "move down" }))

-- manage buffers
map("n", "<leader>x", "<cmd>bdelete<CR>", { desc = "close current buffer" })
map("n", "<Tab>", "<cmd>bnext<CR>", { desc = "go to next buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "go to previous buffer" })

map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "mapping cheatsheet" })

-- folding
map("n", "<leader>fc", function()
  vim.wo.foldcolumn = (vim.wo.foldcolumn == "0") and "1" or "0"
end, { desc = "toggle fold column" })

-- visual mode
map("v", "<", "<gv", { desc = "indent line" })
map("v", ">", ">gv", { desc = "indent line" })
map("v", "<C-y>", '"+y', { desc = "copy to clipboard register" })

-- Don't copy the replaced text after pasting in visual mode
-- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
map("x", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', { desc = "dont copy replaced text", silent = true })

-------------------------------------- comment --------------------------------------------

map("n", "<leader>/", function()
  require("Comment.api").toggle.linewise.current()
end, { desc = "toggle comment" })

map("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { desc = "toggle comment" })

-------------------------------------- treesj ----------------------------------------------

map("n", "<leader>tj", "<cmd>TSJToggle<CR>", { desc = "toggle TJS" })

-------------------------------------- telescope -------------------------------------------

-- find
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "find files" })
map("n", "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>", { desc = "find all" })
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "help page" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "find oldfiles" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "find in current buffer" })
map("n", "<leader>fe", "<cmd>Telescope file_browser<CR>", { desc = "open file browser" })
map("n", "<leader>fq", "<cmd>Telescope quickfix<CR>", { desc = "telescope quickfix" })
map("n", "<leader>fn", "<cmd>Telescope noice<CR>", { desc = "noice history" })
map("n", "<leader>fl", "<cmd>Telescope resume<CR>", { desc = "telescope last search" })

-- git
map("n", "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "git status" })

-- ui
map("n", "<leader>th", "<cmd>Telescope themes<CR>", { desc = "nvchad themes" })

-- lsp
map("n", "<leader>ci", "<cmd>Telescope lsp_incoming_calls<CR>", { desc = "telescope incoming calls" })
map("n", "<leader>co", "<cmd>Telescope lsp_outgoing_calls<CR>", { desc = "telescope outgoing calls" })
map("n", "<leader>di", "<cmd>Telescope diagnostics<CR>", { desc = "telescope diagnostics" })
map("n", "<leader>fr", "<cmd>Telescope lsp_references<CR>", { desc = "telescope references" })
map("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "find symbols" })
map("n", "<leader>ws", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", { desc = "workspace symbols" })

-- vim marks, registers and jumplist
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope bookmarks" })
map("n", "<leader>rg", "<cmd>Telescope registers<CR>", { desc = "telescope registers" })
map("n", "<leader>jl", "<cmd>Telescope jumplist<CR>", { desc = "telescope jumplist" })

-------------------------------------- which-key -------------------------------------------

map("n", "<leader>wk", "<cmd>WhichKey<CR>", { desc = "whichkey maps" })

-------------------------------------- lazygit ---------------------------------------------

map("n", "<leader>lg", "<cmd>LazyGit<CR>", { desc = "open lazygit" })

-------------------------------------- gitsigns --------------------------------------------

map("n", "]c", function()
  if vim.wo.diff then
    return "]c"
  end
  vim.schedule(function()
    require("gitsigns").next_hunk()
  end)
  return "<Ignore>"
end, { expr = true, desc = "jump to next hunk" })

map("n", "[c", function()
  if vim.wo.diff then
    return "[c"
  end
  vim.schedule(function()
    require("gitsigns").prev_hunk()
  end)
  return "<Ignore>"
end, { expr = true, desc = "jump to prev hunk" })

map("n", "<leader>rh", function()
  require("gitsigns").reset_hunk()
end, { desc = "reset hunk" })

map("n", "<leader>ph", function()
  require("gitsigns").preview_hunk()
end, { desc = "preview hunk" })

map("n", "<leader>sh", function()
  require("gitsigns").stage_hunk()
end, { desc = "toggle stage hunk" })

map("n", "<leader>gb", function()
  package.loaded.gitsigns.blame_line()
end, { desc = "blame line" })

map("n", "<leader>td", function()
  require("gitsigns").toggle_deleted()
end, { desc = "toggle deleted" })

-------------------------------------- leap ------------------------------------------------

map({ "n", "o" }, "s", "<Plug>(leap-anywhere)", { desc = "leap forward" })

-------------------------------------- inc-rename ------------------------------------------

map("n", "<leader>rn", function()
  return ":IncRename " .. vim.fn.expand "<cword>"
end, { expr = true, desc = "incremental rename" })

map("v", "<leader>rn", function()
  return ":IncRename " .. vim.fn.expand "<cword>"
end, { desc = "LSP rename" })
