-- Entry point / orchestrator. Execution order is exactly this file, top to
-- bottom — no auto-loading magic. Layout:
--   lua/core/     options and generic keymaps (no plugin/LSP dependencies)
--   lua/plugins/  one file per plugin: setup() + its keymaps
--   lua/lsp/      shared LSP infra: capabilities, completion, LspAttach, diagnostics
--   lua/lang/     one file per language: treesitter parsers + server config
--                 + its own vim.lsp.enable()
-- Adding a language = create lua/lang/<name>.lua + one require below.
-- Adding a plugin   = one line in vim.pack.add + lua/plugins/<name>.lua + one require.

require("core.options") -- must run first: sets the leader key
require("core.keymaps")

-- ─────────────────────────────────────────────────────────────────────────────
-- Plugins (native vim.pack manager, Neovim 0.12+). Clones into
-- ~/.local/share/nvim/site/pack/core/opt/ and adds to the runtimepath.
-- Central list: every installed plugin and shared dependency is visible here.
-- ─────────────────────────────────────────────────────────────────────────────
vim.pack.add({
  { src = "https://github.com/olimorris/onedarkpro.nvim" },      -- active colorscheme (onedark)
  { src = "https://github.com/rktjmp/lush.nvim" },               -- zenbones dependency
  { src = "https://github.com/mcchrish/zenbones.nvim" },         -- alternative colorscheme
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },          -- telescope + neogit dependency
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/NeogitOrg/neogit" },
  { src = "https://github.com/windwp/nvim-autopairs" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" }, -- main branch: needs nvim 0.12+ and the tree-sitter CLI
  { src = "https://github.com/windwp/nvim-ts-autotag" },                            -- auto close/rename HTML/JSX tags (uses treesitter)
  { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },         -- renders markdown inside the buffer (uses treesitter)
})

require("plugins.colorscheme")
require("plugins.oil")
require("plugins.telescope")
require("plugins.autopairs")
require("plugins.treesitter")
require("plugins.render-markdown")
require("plugins.neogit")

require("lsp") -- shared LSP infra; must run before the lang modules

require("lang.typescript")
require("lang.lua")
require("lang.java")
require("lang.web")
require("lang.graphql")
require("lang.rust")
require("lang.go")
require("lang.php")
require("lang.twig")
