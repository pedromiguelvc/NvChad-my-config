--@type ChadrcConfig
local c = require "custom.colors"
local M = {}

M.ui = {
  theme = "tokyodark",
  transparency = true,

  hl_override = {
    CursorLine = { bg = c.bg_alt },
    LineNr = { fg = c.fg_muted },
    CursorLineNr = { fg = c.primary, bold = true },

    -- Override that works here
    Boolean = { italic = true },
    Conditional = { italic = true },
    Include = { italic = true },
  },

  hl_add = {
    -- Git
    GitSignsCurrentLineBlame = { fg = c.git_blame, italic = true },

    -- Indent guides
    IblIndent = { fg = c.bg_subtle },
    IblScope = { fg = c.border },

    -- UI chrome
    WinSeparator = { fg = c.border },
    -- Search
    Search = { fg = c.fg, bg = c.search },
    IncSearch = { fg = c.bg, bg = c.primary },
    CurSearch = { fg = c.bg, bg = c.secondary },

    -- Diagnostics
    DiagnosticVirtualTextError = { fg = c.error, bg = "#2a1f2e", italic = true },
    DiagnosticVirtualTextWarn = { fg = c.warn, bg = "#2a2518", italic = true },
    DiagnosticVirtualTextInfo = { fg = c.info, bg = c.bg, italic = true },
    DiagnosticVirtualTextHint = { fg = c.hint, bg = c.bg, italic = true },

    TelescopePromptCounter = { bg = c.telescope_prompt, fg = c.fg_dim },
    TelescopeBorder = { bg = c.telescope_bg, fg = c.telescope_border },
    TelescopeSelection = { bg = c.telescope_selected, fg = c.fg },
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
      { "󰈭 Find Word", "Spc f w", "Telescope live_grep" },
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
  "@keyword.exception",
  "@keyword.import",
  "@storageclass",
  "@type.definition",
}

for _, group in ipairs(keyword_groups_to_italicize) do
  M.ui.hl_override[group] = { italic = true }
end

return M
