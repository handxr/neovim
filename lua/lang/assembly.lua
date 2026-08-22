require("nvim-treesitter").install({ "asm" })

vim.lsp.config("asm_lsp", {
  cmd = { "asm-lsp" },
  filetypes = { "asm", "vmasm" },
  root_markers = { ".asm-lsp.toml", ".git" },
})

vim.lsp.enable("asm_lsp")
