-- Gitsigns: per-line git info. Two things it gives you that Neogit doesn't:
--   1. signs in the gutter for added/changed/deleted lines in the open buffer
--   2. blame — who last touched a line, when, and in which commit
-- No dependencies; it shells out to `git` and reads the index directly.
local gs = require("gitsigns")

gs.setup({
  signs = {
    add          = { text = "┃" },
    change       = { text = "┃" },
    delete       = { text = "▁" },
    topdelete    = { text = "▔" },
    changedelete = { text = "~" },
    untracked    = { text = "┆" },
  },

  -- Inline blame as virtual text at the end of the cursor line. Off by
  -- default because it's noisy while writing; toggle it with <leader>gB.
  current_line_blame = false,
  current_line_blame_opts = {
    virt_text_pos = "eol",
    delay = 300,        -- ms after the cursor stops before the blame appears
    ignore_whitespace = false,
  },
  current_line_blame_formatter = "<author>, <author_time:%R> · <summary>",

  -- Runs once per buffer that gitsigns attaches to, so these mappings only
  -- exist inside files that are actually tracked by git.
  on_attach = function(bufnr)
    local function map(mode, lhs, rhs, desc, opts)
      opts = vim.tbl_extend("force", { buffer = bufnr, desc = desc }, opts or {})
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- ── Blame ────────────────────────────────────────────────────────────────
    -- Popup with author, date, commit hash and message for the current line.
    -- full = true also shows the diff hunk that commit introduced.
    map("n", "<leader>gb", function() gs.blame_line({ full = true }) end,
      "Git: blame de la línea (popup)")
    -- Side panel with blame for every line of the file, scroll-synced with the
    -- buffer. This is the "git blame" view you'd get in a GUI.
    map("n", "<leader>gB", gs.blame, "Git: blame del archivo completo")
    -- Toggle the inline virtual-text blame configured above.
    map("n", "<leader>gt", gs.toggle_current_line_blame,
      "Git: alternar blame inline")

    -- ── Hunks ────────────────────────────────────────────────────────────────
    -- ]c / [c are Vim's native "next/prev change" in diff mode, so fall back to
    -- them when the buffer is a real diff and use gitsigns otherwise. Returning
    -- a key from the callback is why these need expr = true.
    map("n", "]c", function()
      if vim.wo.diff then return "]c" end
      vim.schedule(function() gs.nav_hunk("next") end)
      return "<Ignore>"
    end, "Git: siguiente hunk", { expr = true })
    map("n", "[c", function()
      if vim.wo.diff then return "[c" end
      vim.schedule(function() gs.nav_hunk("prev") end)
      return "<Ignore>"
    end, "Git: hunk anterior", { expr = true })

    map("n", "<leader>gp", gs.preview_hunk, "Git: previsualizar hunk")
    map("n", "<leader>gr", gs.reset_hunk, "Git: descartar cambios del hunk")
    map("n", "<leader>gd", gs.diffthis, "Git: diff del archivo vs índice")
  end,
})

-- ── Telescope: commit history ──────────────────────────────────────────────
-- Complements blame: blame tells you the *last* commit on a line, these show
-- the *whole* history. In normal mode, the file's commits; in visual mode, only
-- the commits that touched the selected lines. <CR> checks out that version.
local tb = require("telescope.builtin")
vim.keymap.set("n", "<leader>gc", tb.git_bcommits,
  { desc = "Git: commits de este archivo" })
vim.keymap.set("v", "<leader>gc", tb.git_bcommits_range,
  { desc = "Git: commits de las líneas seleccionadas" })
