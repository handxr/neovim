-- These servers require snippet support to return completions.
local lsp = require("lsp")

require("nvim-treesitter").install({ "html", "css", "json" })

vim.lsp.config("html", {
  cmd = { "vscode-html-language-server", "--stdio" },
  filetypes = { "html" },
  capabilities = lsp.capabilities,
  root_markers = { "package.json", ".git" },
})

vim.lsp.config("cssls", {
  cmd = { "vscode-css-language-server", "--stdio" },
  filetypes = { "css", "scss", "less" },
  capabilities = lsp.capabilities,
  root_markers = { "package.json", ".git" },
})

vim.lsp.config("jsonls", {
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json", "jsonc" },
  capabilities = lsp.capabilities,
  root_markers = { "package.json", ".git" },
})

vim.lsp.enable({ "html", "cssls", "jsonls" })
