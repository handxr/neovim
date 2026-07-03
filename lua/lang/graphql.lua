-- GraphQL: treesitter parser (highlights .graphql files and embedded queries)
-- + language server. Binary: graphql-lsp (npm i -g graphql-language-service-cli).
-- It needs to know where your schema is to complete fields: add a config file
-- at the project root (e.g. .graphqlrc.yml with `schema: ./schema.graphql`).
-- Without it the server starts but offers little help. The react filetypes are
-- included for queries embedded in gql`...`.
require("nvim-treesitter").install({ "graphql" })

vim.lsp.config("graphql", {
  cmd = { "graphql-lsp", "server", "--method", "stream" },
  filetypes = { "graphql", "typescriptreact", "javascriptreact" },
  root_markers = {
    ".graphqlrc", ".graphqlrc.yml", ".graphqlrc.yaml", ".graphqlrc.json",
    "graphql.config.js", "graphql.config.ts", "package.json", ".git",
  },
})

vim.lsp.enable("graphql")
