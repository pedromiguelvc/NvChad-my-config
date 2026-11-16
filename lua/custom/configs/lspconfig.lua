local lsp = require("plugins.configs.lspconfig").lsp
local config_dir = vim.fn.stdpath "config" .. "/lua/custom/configs/lsp"

for _, file in ipairs(vim.fn.glob(config_dir .. "/*.lua", false, true)) do
  local name = vim.fn.fnamemodify(file, ":t:r")
  local mod = "custom.configs.lsp." .. name

  local ok, servers = pcall(require, mod)

  if ok then
    for server, cfg in pairs(servers) do
      lsp.config(server, cfg)
      lsp.enable(server)
    end
  else
    vim.notify("Failed to load LSP config: " .. mod, vim.log.levels.ERROR)
  end
end
