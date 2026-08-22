local M = {}

-- Parsers to make sure are installed. The old `ensure_installed` option
-- inside `require("nvim-treesitter.config").setup()` no longer does
-- anything on the rewritten main branch -- installation is a separate
-- explicit call now (see M.ensure_parsers_installed below).
M.ensure_installed = {
  -- Main Languages
  "c",
  "cpp",
  "python",
  "go",

  -- Config Languages
  "lua",
  "nix",

  -- Auxiliar Languages
  "markdown",
  "markdown_inline",
  "vim",
  "regex",
  "bash",
}

-- Highlighting and indent are no longer configured through the plugin's
-- setup() call -- they're native Neovim features you turn on yourself.
M.setup_highlight_indent = function()
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("TreesitterHighlightIndent", { clear = true }),
    callback = function(ev)
      local ok = pcall(vim.treesitter.start, ev.buf)
      if not ok then
        return -- no parser for this filetype, fall back to regex syntax
      end

      vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })
end

M.ensure_parsers_installed = function()
  local installed = require("nvim-treesitter.config").get_installed "parsers"
  local missing = vim.tbl_filter(function(lang)
    return not vim.tbl_contains(installed, lang)
  end, M.ensure_installed)

  if #missing > 0 then
    require("nvim-treesitter").install(missing)
  end
end

-- nvim-treesitter-textobjects (main branch): `select` still takes a config
-- table, but `move` and `swap` are now wired via plain vim.keymap.set calls
-- instead of a declarative keymaps table -- see the plugin's config()
-- function in lua/plugins/init.lua.
M.textobjects_select = {
  lookahead = true,
  selection_modes = {
    ["@parameter.outer"] = "v",
    ["@function.outer"] = "V",
    ["@class.outer"] = "V",
  },
}

return M
