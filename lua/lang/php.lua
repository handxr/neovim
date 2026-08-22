require("nvim-treesitter").install({ "php", "phpdoc" })
vim.lsp.config("intelephense", {
  cmd = { "intelephense", "--stdio" },
  filetypes = { "php" },
  root_markers = { "composer.json", ".git" },
})

vim.lsp.enable("intelephense")
