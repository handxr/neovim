-- Shared LSP infrastructure (native Neovim 0.11+ API: vim.lsp.config +
-- vim.lsp.enable, no plugins). This module owns everything common to every
-- language server: base capabilities, completion, LspAttach keymaps and
-- diagnostics. The servers themselves live in lua/lang/*.lua, one file per
-- language, each ending with its own vim.lsp.enable().

-- Base client capabilities shared by servers that need snippet support (see
-- lua/lang/web.lua). Neovim does not advertise snippets by default, so we
-- start from the standard capabilities and switch snippetSupport on.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Completion menu: show the popup even with a single match, never preselect
-- (you pick with <C-n>/<C-p>), and show each item's documentation.
vim.o.completeopt = "menuone,noselect,popup"

-- Tab/Shift-Tab, en orden de prioridad:
--   1) menú de completado abierto -> siguiente/anterior item
--   2) snippet activo (huecos pendientes) -> saltar al hueco siguiente/anterior
--   3) en otro caso -> tab normal
-- expr = el valor devuelto se inyecta como si fueran esas teclas. Los saltos de
-- snippet se hacen aquí mismo (no como cadena de teclas) y devolvemos "".
vim.keymap.set("i", "<Tab>", function()
  if vim.fn.pumvisible() == 1 then return "<C-n>" end
  if vim.snippet.active({ direction = 1 }) then
    vim.schedule(function() vim.snippet.jump(1) end)
    return ""
  end
  return "<Tab>"
end, { expr = true, desc = "Completado/snippet: siguiente / tab" })

vim.keymap.set("i", "<S-Tab>", function()
  if vim.fn.pumvisible() == 1 then return "<C-p>" end
  if vim.snippet.active({ direction = -1 }) then
    vim.schedule(function() vim.snippet.jump(-1) end)
    return ""
  end
  return "<S-Tab>"
end, { expr = true, desc = "Completado/snippet: anterior / tab" })

-- <CR> accepts the highlighted suggestion while the popup is open; otherwise
-- it is a normal newline via autopairs_cr(), so the indented line between {}
-- is not lost. This keymap lives here (not in plugins/autopairs.lua) because
-- it depends on BOTH autopairs and LSP completion — completion is the later
-- dependency.
local npairs = require("nvim-autopairs")
local function feed(keys) return vim.api.nvim_replace_termcodes(keys, true, false, true) end
vim.keymap.set("i", "<CR>", function()
  if vim.fn.pumvisible() == 1 then
    if vim.fn.complete_info({ "selected" }).selected ~= -1 then
      return feed("<C-y>")                            -- item highlighted: accept it
    end
    return feed("<C-e>") .. npairs.autopairs_cr()     -- popup with no selection: close it and break the line
  end
  return npairs.autopairs_cr()                        -- no popup: plain newline
end, { expr = true, replace_keycodes = false, desc = "Completado: aceptar / nueva línea" })

-- Keymaps that only exist while an LSP client is attached to the buffer.
-- Neovim 0.11+ defaults we do NOT redefine:
--   K   = hover            grr = references         grn = rename
--   gra = code action      gri = implementation     gO  = document symbols
--   <C-s> (insert) = signature help
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local buf = args.buf
    local map = function(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = buf, desc = "LSP: " .. desc })
    end
    map("gd", vim.lsp.buf.definition,      "ir a definición")
    map("gD", vim.lsp.buf.declaration,     "ir a declaración")
    map("gy", vim.lsp.buf.type_definition, "ir a definición de tipo")

    -- Native LSP autocompletion (no plugins). autotrigger pops the menu up on
    -- its own, but by default only on the server's triggerCharacters (e.g.
    -- "."), so we add letters/digits/_ to also get suggestions while typing a
    -- name. Navigate with <C-n>/<C-p>, accept with <C-y> (applies imports and
    -- snippets).
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method("textDocument/completion") then
      local cap = client.server_capabilities.completionProvider
      local triggers = cap.triggerCharacters or {}
      for c in ("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_"):gmatch(".") do
        table.insert(triggers, c)
      end
      cap.triggerCharacters = triggers
      vim.lsp.completion.enable(true, client.id, buf, { autotrigger = true })
    end
  end,
})

-- Diagnostics: navigation and floating panel
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float,           { desc = "Diagnóstico flotante" })
vim.keymap.set("n", "[d",        function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Diagnóstico anterior" })
vim.keymap.set("n", "]d",        function() vim.diagnostic.jump({ count =  1, float = true }) end, { desc = "Diagnóstico siguiente" })

-- Exported so lua/lang/*.lua files can reuse the shared capabilities:
--   local lsp = require("lsp")
--   vim.lsp.config("html", { capabilities = lsp.capabilities, ... })
return { capabilities = capabilities }
