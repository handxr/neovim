-- TypeScript / JavaScript: treesitter parsers + ts_ls language server.
require("nvim-treesitter").install({
  "javascript", "typescript", "tsx", -- tsx covers the typescriptreact filetype
})

vim.lsp.config("ts_ls", {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = {
    "javascript", "javascriptreact", "javascript.jsx",
    "typescript", "typescriptreact", "typescript.tsx",
  },
  root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
})

vim.lsp.enable("ts_ls")
