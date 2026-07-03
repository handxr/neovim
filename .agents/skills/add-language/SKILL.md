---
name: add-language
description: Add full support for a language to this Neovim config — Treesitter parser + native LSP (vim.lsp.config/enable) + binary on $PATH. Use when the user wants to add or configure a new language (Go, Python, C, Bash…), says "soporte para <language>" / "support for <language>", or mentions a missing LSP server or treesitter parser.
---

# Add a language to the config

This config is minimal and native (`vim.pack`, Neovim 0.11+ native LSP, Treesitter `main` branch, no `mason` or `lspconfig`). Each language is a **self-contained** file at `lua/lang/<name>.lua` that installs its parser, configures its server, and enables it — then a single `require` in `init.lua` loads it. Nothing about a language lives anywhere else, so adding one is one new file plus one line, and deleting that file fully removes it.

Style rule, don't break it: **comments in English**, and explain to the user what you add and why — they build their config in phases and want to understand every line. Mirror an existing `lua/lang/*.lua` file; don't invent a new shape.

## Step 1 — Gather the language's data

Before writing the file you need these five facts. For common languages they're in the table; for others, derive them from the language's official LSP server.

| Language | `server` (key) | `cmd` | TS parser | install binary |
|----------|----------------|-------|-----------|----------------|
| Go | `gopls` | `{ "gopls" }` | `go`, `gomod` | `go install golang.org/x/tools/gopls@latest` |
| Python | `pyright` | `{ "pyright-langserver", "--stdio" }` | `python` | `npm i -g pyright` |
| C / C++ | `clangd` | `{ "clangd" }` | `c`, `cpp` | OS package manager (`apt install clangd`) |
| Bash | `bashls` | `{ "bash-language-server", "start" }` | `bash` | `npm i -g bash-language-server` |
| Ruby | `ruby_lsp` | `{ "ruby-lsp" }` | `ruby` | `gem install ruby-lsp` |
| YAML | `yamlls` | `{ "yaml-language-server", "--stdio" }` | `yaml` | `npm i -g yaml-language-server` |

Plus two you derive yourself:
- **`filetypes`**: the language's Neovim filetypes (e.g. `{ "go" }`, `{ "python" }`).
- **`root_markers`**: the files that mark the project root, most-specific first with `.git` as a safety net (Go → `go.mod`; Python → `pyproject.toml`, `setup.py`; C → `compile_commands.json`, `.clangd`).

**Done when** you have all five facts (`server`, `cmd`, `filetypes`, `root_markers`, parser) and the binary install command.

## Step 2 — Create the language file

Create `lua/lang/<name>.lua`, self-contained in three parts. Mirror the closest existing file:
- Server speaking over stdio with no extras → copy `typescript.lua`.
- Server returning snippets (HTML/CSS/JSON-style) → copy `web.lua`: `local lsp = require("lsp")` and pass `capabilities = lsp.capabilities`.
- Server with its own `settings` → copy `rust.lua` (settings under its server key) or `go.lua`.

The three parts, in order:

```lua
-- 1. Install the Treesitter parser(s). Add all if the language ships several.
require("nvim-treesitter").install({ "<parser>" })

-- 2. Configure the server. English comment explaining what's SPECIFIC to this
--    language (where the binary comes from, what its settings do, why those
--    root_markers). Don't restate what the pattern already makes obvious.
vim.lsp.config("<server>", {
  cmd = { … },
  filetypes = { … },
  root_markers = { … },
})

-- 3. Enable it. Without this the config block never starts.
vim.lsp.enable("<server>")
```

**Done when** `lua/lang/<name>.lua` exists with all three parts and its comment.

## Step 3 — Wire it into init.lua

Add one line to the `lang` requires at the bottom of `init.lua`, after the other languages:

```lua
require("lang.<name>")
```

**Done when** the `require("lang.<name>")` line is in `init.lua`.

## Step 4 — Verify the binary

Check the server is on `$PATH` and responds:

```bash
which <binary> && <binary> --version
```

If missing, install it with the table's command. Two frequent traps:
- **Proxies** (rustup/asdf): a `which` that finds the binary but whose `--version` fails means the real component isn't installed — install it for real before moving on.
- **Binary outside `$PATH`**: many installers drop the binary in a dir not on `$PATH` (Go → `$GOPATH/bin`, e.g. `~/go/bin`; npm global, gems, etc.). A binary invisible to `$PATH` is also invisible to Neovim. Check its directory is on `$PATH`, and if not, give the user the command to add it (don't edit their rc files without permission).

**Done when** the binary prints its version, or (if you can't install it) you've given the user the exact command.

## Step 5 — Close

Remind the user to open Neovim and run `:TSUpdate` to download the new parser (the install is async and only fetches what's missing).

**Done when** `lua/lang/<name>.lua` holds all three parts, `init.lua` requires it, and you've given the `:TSUpdate` reminder.
