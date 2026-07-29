-- Twig (Symfony templates): treesitter parser only, no language server.
-- A clean standalone Twig LSP binary doesn't exist on $PATH (the maintained
-- server is a library with no CLI), so we stick to syntax highlighting, which
-- covers ~90% of the value for templates.
--
-- No filetype setup needed: Neovim natively maps *.twig and *.html.twig to the
-- `twig` filetype, and the treesitter autocmd in plugins/treesitter.lua starts
-- highlighting on any buffer whose filetype has a matching parser installed.
require("nvim-treesitter").install({ "twig" })
