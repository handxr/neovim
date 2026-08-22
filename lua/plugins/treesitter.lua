require("nvim-treesitter").install({
  "lua", "vim", "vimdoc", "query",
})

-- Not every filetype has an installed parser, so highlighting may fail safely.
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

require("nvim-ts-autotag").setup()
