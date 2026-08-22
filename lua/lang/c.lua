-- C: treesitter parser + clangd, provided by Xcode Command Line Tools on macOS
-- or the system package manager on Linux. Compilation databases and .clangd
-- identify configured projects; .git is the fallback.
require("nvim-treesitter").install({ "c" })

vim.lsp.config("clangd", {
  cmd = { "clangd" },
  filetypes = { "c" },
  root_markers = { "compile_commands.json", ".clangd", ".git" },
})

vim.lsp.enable("clangd")
