-- Generic keymaps with no plugin or LSP dependencies.
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Guardar" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Salir" })
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { desc = "Limpiar resaltado de búsqueda" })
vim.keymap.set("i", "jj", "<Esc>", { desc = "Salir del modo insert" })
