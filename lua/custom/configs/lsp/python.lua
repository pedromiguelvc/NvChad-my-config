return {
  ruff = { filetypes = { "python" } },
  basedpyright = {
    basedpyright = {
      filetypes = { "python" },
      settgins = {
        basedpyright = { disableOrganizeImports = true },
        analysis = { ignore = { "*" } },
      },
    },
  },
}
