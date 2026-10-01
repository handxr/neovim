require("nvim-treesitter").install({ "graphql" })

vim.lsp.config("graphql", {
  cmd = { "graphql-lsp", "server", "--method", "stream" },
  filetypes = { "graphql", "typescriptreact", "javascriptreact" },
  root_markers = {
    ".graphqlrc", ".graphqlrc.yml", ".graphqlrc.yaml", ".graphqlrc.json",
    "graphql.config.js", "graphql.config.ts",
  },
  -- Only start in projects with a GraphQL config, not in every React project.
  workspace_required = true,
})

vim.lsp.enable("graphql")
