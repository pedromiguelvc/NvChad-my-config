require("conform").setup {
  formatters_by_ft = {
    python = { "ruff_format", "ruff_fix", "ruff_organize_imports" },
    lua = { "stylua" },
    nix = { "nixfmt" },
    c = { "clang_format" },
    cpp = { "clang_format" },
    go = { "gofmt" },
    javascript = { "eslint" },
    typescript = { "eslint" },
    haskell = { "ormolu" },
    java = { "google_java_format" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
  formatters = {
    clang_format = {
      prepend_args = {
        "--style={IndentWidth: 4, TabWidth: 4, UseTab: Never}",
      },
    },
  },
}
