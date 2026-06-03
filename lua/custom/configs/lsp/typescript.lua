return {
  ts_ls = {
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    cmd = { "typescript-language-server", "--stdio" },
    settings = {
      typescript = {
        format = { enable = true },
      },
      javascript = {
        format = { enable = true },
      },
    },
  },
}
