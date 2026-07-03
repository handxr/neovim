-- Java: treesitter parser + jdtls (Eclipse JDT Language Server). The `jdtls`
-- binary is a Homebrew wrapper that locates the Eclipse launcher and boots the
-- JVM for you.
require("nvim-treesitter").install({ "java" })

-- Unlike ts_ls, jdtls stores project metadata (indexes, compiled classes) in a
-- "workspace" dir that MUST be unique per project — sharing one data dir across
-- projects corrupts it. So `cmd` is a function: it is evaluated when jdtls
-- attaches to a buffer, once the project root (config.root_dir) is known, and
-- derives a dedicated data dir for each project.
vim.lsp.config("jdtls", {
  cmd = function(dispatchers, config)
    local root = config.root_dir or vim.fn.getcwd()
    local project_name = vim.fn.fnamemodify(root, ":p:h:t") -- last path component
    local workspace = vim.fn.stdpath("cache") .. "/jdtls/" .. project_name
    return vim.lsp.rpc.start({ "jdtls", "-data", workspace }, dispatchers)
  end,
  filetypes = { "java" },
  -- Typical Maven and Gradle root markers. .git is last as a safety net for
  -- loose projects without a build tool.
  root_markers = {
    "pom.xml",                  -- Maven
    "build.gradle", "build.gradle.kts", "settings.gradle", "settings.gradle.kts", -- Gradle
    "mvnw", "gradlew",          -- wrappers
    ".git",
  },
})

vim.lsp.enable("jdtls")
