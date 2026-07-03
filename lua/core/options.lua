-- Leader = space. MUST be set before any keymap is defined.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.number = true
vim.o.relativenumber = true -- makes count motions like 5j / 12k practical

-- Indent (JS/TS standard = 2 spaces)
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.smartindent = true

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true -- uppercase in the query => case-sensitive search
vim.o.incsearch = true
vim.o.hlsearch = true

-- Appearance
vim.o.termguicolors = true
vim.o.signcolumn = "yes" -- fixed column for diagnostics (avoids layout jumps)
vim.o.cursorline = true
vim.o.scrolloff = 8
vim.o.wrap = false

-- Open new splits to the right / below instead of left / above
vim.o.splitright = true
vim.o.splitbelow = true

-- Behavior
vim.o.mouse = "a"               -- mouse enabled (easing the VSCode transition)
vim.o.clipboard = "unnamedplus" -- yank/paste share the system clipboard
vim.o.undofile = true           -- persistent undo across sessions
vim.o.updatetime = 250
vim.o.timeoutlen = 300
