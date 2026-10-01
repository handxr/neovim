require("core.options") -- Sets the leader key before any mappings are defined.
require("core.keymaps")

vim.pack.add({
  { src = "https://github.com/olimorris/onedarkpro.nvim" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/NeogitOrg/neogit" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/windwp/nvim-autopairs" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  { src = "https://github.com/windwp/nvim-ts-autotag" },
  { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
})

require("plugins.colorscheme")
require("plugins.oil")
require("plugins.telescope")
require("plugins.autopairs")
require("plugins.treesitter")
require("plugins.render-markdown")
require("plugins.neogit")
require("plugins.gitsigns") -- after telescope: reuses its bcommits pickers

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
require("lang.python")
require("lang.assembly")
require("lang.c")
