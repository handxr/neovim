-- onedarkpro registers one colorscheme per variant NAME: onedark,
-- onedark_vivid, onedark_dark, onelight and vaporwave — the name you load is
-- what picks the variant, not `background`. setup() is optional (only for
-- customizing colors/styles) and must run BEFORE colorscheme if used.
-- `background` stays at "dark" because other UI components consult it.
-- zenbones is installed as an alternative: swap "onedark" for "zenbones".
vim.o.background = "dark"
vim.cmd.colorscheme("onedark")
