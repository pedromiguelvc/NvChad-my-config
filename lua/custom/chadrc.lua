--@type ChadrcConfig
local M = {}

M.ui = {
  theme = "tokyodark",
  transparency = true,
  hl_override = {
    CursorLine = { bg = "#252640" },
    LineNr = { fg = "#4a4f6e" },
    CursorLineNr = { fg = "#7aa2f7", bold = true },
    Comment = { fg = "#565f89", italic = true },
  },

  cmp = {
    style = "flat_dark", -- default/flat_light/flat_dark/atom/atom_colored
    selected_item_bg = "simple", -- colored / simple
  },

  tabufline = {
    enabled = false,
  },

  telescope = { style = "borderless" }, -- borderless / bordered

  nvdash = {
    load_on_startup = true,
    header = {
      "   ▄▄         ▄ ▄▄▄▄▄▄▄ ",
      " ▄▀███▄     ▄██ █████▀  ",
      " ██▄▀███▄   ███         ",
      " ███  ▀███▄ ███         ",
      " ███    ▀██ ███         ",
      " ███      ▀ ███         ",
      " ▀██ █████▄▀█▀▄██████▄  ",
      "   ▀ ▀▀▀▀▀▀▀ ▀▀▀▀▀▀▀▀▀▀ ",
    },
    buttons = {
      { " File Browser", "Spc f t", "Telescope file_browser" },
      { "󰈚 Recent Files", "Spc f o", "Telescope oldfiles" },
      { " Find File", "Spc f f", "Telescope find_files" },
      { " Find All", "Spc f a", "Telescope find_files follow=true no_ignore=true hidden=true" },
      { " Lazy Git", "Spc l g", "LazyGit" },
      { "󰈭 Find Word", "Spc f w", "Telescope live_grep_args" },
      { " Session", "Cmd Line", "source Session.vim" },
      { "󰒲 Lazy", "Cmd Line", "Lazy" },
      { "󰣪 Mason", "Cmd Line", "Mason" },
      { "󰿅 Exit", "Cmd Line", "Q" },
    },
  },
}

local keyword_groups_to_italicize = {
  "@comment",
  "@keyword",
  "@keyword.function",
  "@keyword.return",
  "@keyword.operator",
  "@keyword.conditional",
  "@keyword.repeat",
  "@keyword.exception",
  "@keyword.import",
  "@storageclass",
  "@type.definition",
}

for _, group in ipairs(keyword_groups_to_italicize) do
  M.ui.hl_override[group] = { italic = true }
end

return M
