local options = {
  signs = {
    add = { text = "│" },
    change = { text = "│" },
    delete = { text = "󰍵" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
    untracked = { text = "│" },
  },
  current_line_blame = true,
  current_line_blame_opts = {
    delay = 0,
    virt_text_pos = "eol", -- end of line
  },
}

return options
