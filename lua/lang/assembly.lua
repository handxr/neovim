-- Assembly: generic treesitter parser + asm-lsp, which supports multiple
-- assemblers and instruction sets configured per project in .asm-lsp.toml.
require("nvim-treesitter").install({ "asm" })

vim.lsp.config("asm_lsp", {
  cmd = { "asm-lsp" },
  filetypes = { "asm", "vmasm" },
  root_markers = { ".asm-lsp.toml", ".git" },
})

vim.lsp.enable("asm_lsp")
