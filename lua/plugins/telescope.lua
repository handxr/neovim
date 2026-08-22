require("telescope").setup({
  defaults = {
    path_display = { "truncate" },
    layout_strategy = "horizontal",
    layout_config = { prompt_position = "top" },
    sorting_strategy = "ascending",
  },
  pickers = {
    find_files = { hidden = true },
  },
})
local tb = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", tb.find_files, { desc = "Telescope: find files" })
vim.keymap.set("n", "<leader>fg", tb.live_grep, { desc = "Telescope: search repository" })
vim.keymap.set("n", "<leader>fb", tb.buffers, { desc = "Telescope: open buffers" })
vim.keymap.set("n", "<leader>fh", tb.help_tags, { desc = "Telescope: help tags" })
vim.keymap.set("n", "<leader>fr", tb.resume, { desc = "Telescope: resume last search" })
vim.keymap.set("n", "<leader>fs", tb.lsp_document_symbols, { desc = "Telescope: document symbols" })
