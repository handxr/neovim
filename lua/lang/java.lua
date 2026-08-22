require("nvim-treesitter").install({ "java" })

-- Keep jdtls metadata isolated per project to prevent index corruption.
vim.lsp.config("jdtls", {
  cmd = function(dispatchers, config)
    local root = config.root_dir or vim.fn.getcwd()
    local project_name = vim.fn.fnamemodify(root, ":p:h:t") -- last path component
    local workspace = vim.fn.stdpath("cache") .. "/jdtls/" .. project_name
    return vim.lsp.rpc.start({ "jdtls", "-data", workspace }, dispatchers)
  end,
  filetypes = { "java" },
  root_markers = {
    "pom.xml",
    "build.gradle", "build.gradle.kts", "settings.gradle", "settings.gradle.kts",
    "mvnw", "gradlew",
    ".git",
  },
})

vim.lsp.enable("jdtls")
