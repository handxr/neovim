-- Oil: file explorer as an editable buffer.
require("oil").setup({
  default_file_explorer = true, -- replaces netrw
  delete_to_trash = true,       -- safety net: deletions go to the trash
  view_options = {
    show_hidden = true,
  },
})
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Abrir directorio padre (oil)" })
