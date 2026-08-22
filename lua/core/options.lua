vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.number = true
vim.o.relativenumber = true

-- Use two-space indentation by default.
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.smartindent = true

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.hlsearch = true

vim.o.termguicolors = true
vim.o.signcolumn = "yes"
vim.o.cursorline = true
vim.o.scrolloff = 8
vim.o.wrap = true
vim.o.linebreak = true
vim.o.breakindent = true

-- Guide at 75% of the terminal width; recalculate when the layout changes
vim.api.nvim_create_autocmd({ "VimResized", "BufEnter", "WinEnter" }, {
  callback = function()
    vim.wo.colorcolumn = tostring(math.floor(vim.o.columns * 0.75))
  end,
})

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.mouse = "a"
vim.o.clipboard = "unnamedplus"
vim.o.undofile = true
vim.o.updatetime = 250
vim.o.timeoutlen = 300
