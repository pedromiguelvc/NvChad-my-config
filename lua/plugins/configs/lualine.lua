local lualine = require "lualine"
local noice_mode = require("noice").api.statusline.mode
local fn = vim.fn

lualine.setup {
  options = {
    icons_enabled = true,
    theme = "horizon",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
      refresh_time = 16, -- ~60fps
      events = {
        "WinEnter",
        "BufEnter",
        "BufWritePost",
        "SessionLoadPost",
        "FileChangedShellPost",
        "VimResized",
        "Filetype",
        "CursorMoved",
        "CursorMovedI",
        "ModeChanged",
      },
    },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = {
      {
        "buffers",
        show_filename_only = true,
        show_modified_status = true,
        mode = 0,
        symbols = {
          modified = " ●",
          alternate_file = "",
          directory = "",
        },
        use_mode_colors = false,
        buffers_color = {
          active = "lualine_a_normal",
          inactive = "lualine_c_normal",
        },
      },
    },
    lualine_x = {
      {
        noice_mode.get,
        cond = noice_mode.has,
        color = { fg = "#ff9e64" },
      },
    },
    lualine_y = { "progress" },
    lualine_z = {
      function()
        local cur = fn.line "."
        local total = fn.line "$"
        local col = fn.col "."
        return string.format("%d/%d : %d", cur, total, col)
      end,
    },
  },
  inactive_sections = {
    lualine_a = { "mode" },
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {},
}

return lualine
