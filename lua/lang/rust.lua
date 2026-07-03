-- Rust: treesitter parser + rust-analyzer, the official LSP. It comes with a
-- rustup install (`rustup component add rust-analyzer`) or as a standalone
-- binary on $PATH.
require("nvim-treesitter").install({ "rust" })

-- Cargo.toml marks the crate root and Cargo.lock the workspace; .git is the
-- safety net. `settings` go under the "rust-analyzer" key and are optional:
-- here we run clippy on save (richer diagnostics than the default cargo check)
-- and enable all workspace features.
vim.lsp.config("rust_analyzer", {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", "Cargo.lock", ".git" },
  settings = {
    ["rust-analyzer"] = {
      cargo = { allFeatures = true },
      checkOnSave = true,
      check = { command = "clippy" },
    },
  },
})

vim.lsp.enable("rust_analyzer")
