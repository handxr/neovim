-- clangd serves both C and C++, so both languages live in this one file.
require("nvim-treesitter").install({ "c", "cpp" })

vim.lsp.config("clangd", {
  cmd = { "clangd" },
  filetypes = { "c", "cpp" },
  root_markers = { "compile_commands.json", "CMakeLists.txt", ".clangd", ".git" },
})

vim.lsp.enable("clangd")
