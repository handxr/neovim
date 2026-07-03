-- render-markdown: renders markdown INSIDE the buffer (headings, bullets,
-- code blocks, tables, checkboxes…) from the treesitter tree — no browser or
-- separate window. In the buffer under the CURSOR it shows the raw markdown
-- so you can edit the symbols, and renders everything else.
-- Without an icon provider (nvim-web-devicons / mini.icons) it works fine;
-- only the language icons on code blocks are missing.

-- Needs both markdown parsers, so they are installed here.
require("nvim-treesitter").install({ "markdown", "markdown_inline" })

require("render-markdown").setup({
  file_types = { "markdown" },
})
vim.keymap.set("n", "<leader>m", "<CMD>RenderMarkdown toggle<CR>", { desc = "Markdown: alternar render" })
