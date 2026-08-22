require("nvim-treesitter").install({ "markdown", "markdown_inline" })

require("render-markdown").setup({
  file_types = { "markdown" },
})
vim.keymap.set("n", "<leader>m", "<CMD>RenderMarkdown toggle<CR>", { desc = "Markdown: toggle rendering" })
