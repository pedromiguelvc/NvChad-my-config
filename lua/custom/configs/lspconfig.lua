local lsp = require("plugins.configs.lspconfig").lsp

local modules = {
  "custom.configs.lsp.python",
  "custom.configs.lsp.clangd",
  "custom.configs.lsp.typescript",
  "custom.configs.lsp.java",
  "custom.configs.lsp.go",
  "custom.configs.lsp.haskell",
  "custom.configs.lsp.nix",
}

for _, mod in ipairs(modules) do
  local ok, servers = pcall(require, mod)

  if ok then
    for server, cfg in pairs(servers) do
      lsp.config(server, cfg)
      lsp.enable(server)
    end
  end
end
