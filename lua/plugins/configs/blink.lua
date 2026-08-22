-- blink.cmp config, migrated from the old nvim-cmp setup (see git history
-- for the previous lua/plugins/configs/cmp.lua if you need to compare).

dofile(vim.g.base46_cache .. "cmp")

local cmp_ui = require("nvconfig").ui.cmp
local cmp_style = cmp_ui.style

local function border(hl_name)
  return {
    { "╭", hl_name },
    { "─", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╯", hl_name },
    { "─", hl_name },
    { "╰", hl_name },
    { "│", hl_name },
  }
end

local menu_border = (cmp_style == "atom" or cmp_style == "atom_colored") and "none" or border "CmpBorder"

return {
  keymap = {
    preset = "none",

    ["<C-u>"] = { "scroll_documentation_up" },
    ["<C-d>"] = { "scroll_documentation_down" },
    ["<CR>"] = { "select_and_accept", "fallback" },

    ["<C-space>"] = { "show", "fallback" },
    ["<C-g>"] = { "show_documentation", "hide_documentation" },

    -- Tab: cycle completion items if the menu is open, else jump to the
    -- next LuaSnip placeholder if one is active, else insert a real tab.
    ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
    ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
  },

  -- Use LuaSnip (via lua/plugins/configs/snip.lua) as the snippet engine,
  -- instead of blink's own built-in vim.snippet-based engine.
  snippets = { preset = "luasnip" },

  sources = {
    default = { "lsp", "buffer", "snippets", "path" },
    providers = {
      lsp = { max_items = 10 },
      buffer = { max_items = 10 },
      snippets = { max_items = 5 },
      path = { max_items = 5 },
    },
  },

  completion = {
    accept = {
      auto_brackets = { enabled = true },
    },
    list = {
      selection = { preselect = false },
    },

    menu = {
      border = menu_border,
      winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
      scrollbar = false,
      draw = {
        padding = 1,
        gap = 1,
        columns = {
          { "kind_icon" },
          { "label", "label_description", gap = 1 },
          { "kind" },
        },
      },
    },
    ghost_text = {
      enabled = true,
      show_without_selection = false, -- only when something is actually selected
    },

    documentation = {
      auto_show = false,
      auto_show_delay_ms = 250,
      treesitter_highlighting = true,

      window = {
        border = border "CmpDocBorder",
        winhighlight = "Normal:CmpDoc",
      },
    },
  },

  signature = {
    enabled = true,
    window = {
      border = border "CmpDocBorder",
      winhighlight = "Normal:CmpDoc",
    },
  },
}
