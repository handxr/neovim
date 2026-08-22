require("neogit").setup({
  integrations = {
    telescope = true,
  },
})
vim.keymap.set("n", "<leader>gs", "<CMD>Neogit<CR>", { desc = "Git: open Neogit" })
