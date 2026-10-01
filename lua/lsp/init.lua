vim.o.completeopt = "menuone,noselect,popup"

-- Prioritize completion, then snippet jumps, then regular indentation.
vim.keymap.set("i", "<Tab>", function()
  if vim.fn.pumvisible() == 1 then return "<C-n>" end
  if vim.snippet.active({ direction = 1 }) then
    vim.schedule(function() vim.snippet.jump(1) end)
    return ""
  end
  return "<Tab>"
end, { expr = true, desc = "Completion/snippet: next or indent" })

vim.keymap.set("i", "<S-Tab>", function()
  if vim.fn.pumvisible() == 1 then return "<C-p>" end
  if vim.snippet.active({ direction = -1 }) then
    vim.schedule(function() vim.snippet.jump(-1) end)
    return ""
  end
  return "<S-Tab>"
end, { expr = true, desc = "Completion/snippet: previous or indent" })

-- Preserve autopairs newline behavior while accepting selected completions.
local npairs = require("nvim-autopairs")
local function feed(keys) return vim.api.nvim_replace_termcodes(keys, true, false, true) end
vim.keymap.set("i", "<CR>", function()
  if vim.fn.pumvisible() == 1 then
    if vim.fn.complete_info({ "selected" }).selected ~= -1 then
      return feed("<C-y>")
    end
    return feed("<C-e>") .. npairs.autopairs_cr()
  end
  return npairs.autopairs_cr()
end, { expr = true, replace_keycodes = false, desc = "Completion: accept or insert newline" })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local buf = args.buf
    local map = function(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = buf, desc = "LSP: " .. desc })
    end
    map("gd", vim.lsp.buf.definition,  "go to definition")
    map("gD", vim.lsp.buf.declaration, "go to declaration")

    -- Add alphanumeric triggers so completion opens while identifiers are typed.
    -- Capabilities are per client, so extend them only on the first attach.
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method("textDocument/completion") then
      local cap = client.server_capabilities.completionProvider
      if not cap._identifier_triggers then
        local triggers = cap.triggerCharacters or {}
        for c in ("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_"):gmatch(".") do
          table.insert(triggers, c)
        end
        cap.triggerCharacters = triggers
        cap._identifier_triggers = true
      end
      vim.lsp.completion.enable(true, client.id, buf, { autotrigger = true })
    end
  end,
})

vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Previous diagnostic" })
vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "Next diagnostic" })
