-- Telescope: fuzzy finder. Uses rg (grep) and fd (find) when on $PATH.
require("telescope").setup({
  defaults = {
    path_display = { "truncate" }, -- long paths get shortened from the left
    layout_strategy = "horizontal",
    layout_config = { prompt_position = "top" },
    sorting_strategy = "ascending",
  },
  pickers = {
    find_files = { hidden = true }, -- include dotfiles
  },
})
local tb = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", tb.find_files,  { desc = "Telescope: archivos" })
vim.keymap.set("n", "<leader>fg", tb.live_grep,   { desc = "Telescope: grep en el repo" })
vim.keymap.set("n", "<leader>fb", tb.buffers,     { desc = "Telescope: buffers abiertos" })
vim.keymap.set("n", "<leader>fh", tb.help_tags,   { desc = "Telescope: ayuda" })
vim.keymap.set("n", "<leader>fr", tb.resume,      { desc = "Telescope: reabrir última búsqueda" })
vim.keymap.set("n", "<leader>fs", tb.lsp_document_symbols, { desc = "Telescope: símbolos del archivo" })
