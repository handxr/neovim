-- PHP: treesitter parsers + intelephense, the de-facto PHP language server.
-- The `php` parser handles files that mix HTML and PHP (the normal case);
-- `phpdoc` highlights the `/** @param ... */` docblocks. Install the binary
-- with `npm i -g intelephense` (it lands in your npm global bin, already on
-- $PATH). It speaks LSP over stdio, no extra config needed.
require("nvim-treesitter").install({ "php", "phpdoc" })

-- composer.json marks a Composer project root; .git is the safety net so a
-- loose script outside a project still attaches to something sensible.
vim.lsp.config("intelephense", {
  cmd = { "intelephense", "--stdio" },
  filetypes = { "php" },
  root_markers = { "composer.json", ".git" },
})

vim.lsp.enable("intelephense")
