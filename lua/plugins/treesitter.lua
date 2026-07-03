-- Treesitter (main branch). In Neovim 0.12 the parsing engine is native
-- (vim.treesitter); nvim-treesitter only installs/updates parsers.
-- Gotcha: highlighting is NOT enabled by a setup() call — it is switched on
-- per buffer (see the autocmd below).
--
-- Only the base parsers live here (this config itself + the help system).
-- Language-specific parsers are installed from their lua/lang/*.lua file.

-- install() downloads and compiles (via the tree-sitter CLI) any missing
-- parsers; it is async and a no-op on later startups. After installing new
-- parsers or updating the plugin, run :TSUpdate.
require("nvim-treesitter").install({
  "lua", "vim", "vimdoc", "query",
})

-- Enable treesitter highlighting on every buffer that has a parser.
-- pcall swallows the error on filetypes without one.
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

-- Autotag: typing <div> closes </div>, and renaming a tag updates its pair.
-- Relies on treesitter (html/tsx parsers).
require("nvim-ts-autotag").setup()
