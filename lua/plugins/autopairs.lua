-- Autopairs: auto-closes (), [], {}, "", '', ``. <BS> deletes the whole pair.
-- NOTE: the <CR> keymap that combines autopairs with LSP completion lives in
-- lua/lsp/init.lua, next to the completion setup it depends on.
require("nvim-autopairs").setup({})
