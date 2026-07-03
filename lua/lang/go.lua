-- Go: treesitter parsers (gomod covers go.mod) + gopls, the official Go LSP.
-- Install the binary with `go install golang.org/x/tools/gopls@latest` (it lands
-- in $GOPATH/bin — make sure that is on $PATH).
require("nvim-treesitter").install({ "go", "gomod" })

-- go.mod marks the module root and go.work a multi-module workspace; .git is
-- the safety net. `settings` go under the "gopls" key: we enable unused-param
-- and shadow analysis, plus staticcheck for richer diagnostics than vet.
vim.lsp.config("gopls", {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { "go.work", "go.mod", ".git" },
  settings = {
    gopls = {
      analyses = { unusedparams = true, shadow = true },
      staticcheck = true,
    },
  },
})

vim.lsp.enable("gopls")
