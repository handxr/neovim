require("nvim-treesitter").install({ "c" })

vim.lsp.config("clangd", {
  cmd = { "clangd" },
  filetypes = { "c" },
  root_markers = { "compile_commands.json", ".clangd", ".git" },
})

vim.lsp.enable("clangd")
