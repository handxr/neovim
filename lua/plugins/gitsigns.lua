local gs = require("gitsigns")

gs.setup({
  signs = {
    delete    = { text = "▁" },
    topdelete = { text = "▔" },
  },

  current_line_blame_opts = { delay = 300 },
  current_line_blame_formatter = "<author>, <author_time:%R> · <summary>",

  on_attach = function(bufnr)
    local function map(mode, lhs, rhs, desc, opts)
      opts = vim.tbl_extend("force", { buffer = bufnr, desc = desc }, opts or {})
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    map("n", "<leader>gb", function() gs.blame_line({ full = true }) end,
      "Git: blame current line")
    map("n", "<leader>gB", gs.blame, "Git: blame entire file")
    map("n", "<leader>gt", gs.toggle_current_line_blame,
      "Git: toggle inline blame")

    -- Preserve Vim's native change navigation in diff mode.
    map("n", "]c", function()
      if vim.wo.diff then return "]c" end
      vim.schedule(function() gs.nav_hunk("next") end)
      return "<Ignore>"
    end, "Git: next hunk", { expr = true })
    map("n", "[c", function()
      if vim.wo.diff then return "[c" end
      vim.schedule(function() gs.nav_hunk("prev") end)
      return "<Ignore>"
    end, "Git: previous hunk", { expr = true })

    map("n", "<leader>gp", gs.preview_hunk, "Git: preview hunk")
    map("n", "<leader>gr", gs.reset_hunk, "Git: reset hunk")
    map("n", "<leader>gd", gs.diffthis, "Git: diff file against index")
  end,
})

local tb = require("telescope.builtin")
vim.keymap.set("n", "<leader>gc", tb.git_bcommits,
  { desc = "Git: file commit history" })
vim.keymap.set("v", "<leader>gc", tb.git_bcommits_range,
  { desc = "Git: selected lines commit history" })
