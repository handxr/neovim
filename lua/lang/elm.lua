require("nvim-treesitter").install({ "elm" })

vim.lsp.config("elmls", {
  cmd = { "elm-language-server" },
  filetypes = { "elm" },
  root_markers = { "elm.json" },
})

vim.lsp.enable("elmls")
