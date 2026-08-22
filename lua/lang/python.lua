-- Python: treesitter parser + Pyright language server.
-- Install Pyright with `npm i -g pyright`; pyproject.toml and setup.py identify
-- project environments, while .git is a fallback for unconfigured projects.
require("nvim-treesitter").install({ "python" })

vim.lsp.config("pyright", {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "setup.py", ".git" },
})

vim.lsp.enable("pyright")
