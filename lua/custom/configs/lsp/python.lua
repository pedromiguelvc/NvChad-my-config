return {
  ruff = { filetypes = { "python" } },
  basedpyright = {
    filetypes = { "python" },
    settgins = {
      basedpyright = { disableOrganizeImports = true },
      analysis = { ignore = { "*" } },
    },
  },
}
