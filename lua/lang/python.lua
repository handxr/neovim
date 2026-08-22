require("nvim-treesitter").install({ "python" })

vim.lsp.config("pyright", {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "setup.py", ".git" },
})

vim.lsp.enable("pyright")
