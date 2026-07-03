-- HTML / CSS / JSON: configured together because all three servers ship in the
-- same npm package, `vscode-langservers-extracted` (the servers VSCode uses
-- internally). Install with:  npm i -g vscode-langservers-extracted
--
-- Gotcha: these three only return completions if the client advertises snippet
-- support (suggestions arrive as placeholder templates, e.g. `<div>$0</div>`).
-- We reuse the shared capabilities from lua/lsp/init.lua, which already turn
-- snippetSupport on.
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
