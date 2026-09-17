---@type ChadrcConfig
local c = require "custom.colors"
local M = {}

M.base46 = {
  theme = "tokyodark",
  transparency = true,

  hl_override = {
    CursorLine = { bg = c.bg_alt },
    LineNr = { fg = c.fg_muted },
    CursorLineNr = { fg = c.primary, bold = true },

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
}

M.ui = {
  tabufline = { enabled = false },
}

M.nvdash = {
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
    { txt = "Recent Files", keys = "fo", cmd = "Telescope oldfiles" },
    { txt = "File Browser", keys = "fe", cmd = "Telescope file_browser" },
    { txt = "Find File", keys = "ff", cmd = "Telescope find_files" },
    { txt = "Find All", keys = "fa", cmd = "Telescope find_files follow=true no_ignore=true hidden=true" },
    { txt = "Find Word", keys = "fw", cmd = "Telescope live_grep" },
    { txt = "Lazy", keys = "_", cmd = "Lazy" },
    { txt = "Quit", keys = "_", cmd = "qall" },
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
  M.base46.hl_override[group] = { italic = true }
end

return M
