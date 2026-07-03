-- Neogit: Magit-style git interface. Requires plenary.nvim.
require("neogit").setup({
  integrations = {
    telescope = true, -- use Telescope for branch/tag selectors
  },
})
vim.keymap.set("n", "<leader>gs", "<CMD>Neogit<CR>", { desc = "Git: abrir Neogit" })
