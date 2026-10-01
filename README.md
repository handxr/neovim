# Neovim configuration

A personal, Lua-based Neovim configuration focused on native APIs, fast navigation, Git workflows, Treesitter highlighting, and built-in LSP completion. It uses `vim.pack` for plugins and `vim.lsp.config` / `vim.lsp.enable` for language servers, without Mason or nvim-lspconfig.

## Requirements

Required:

- Neovim 0.12 or newer
- Git
- The `tree-sitter` CLI and a C compiler for parser installation
- A clipboard provider supported by Neovim

Recommended for Telescope:

- [ripgrep](https://github.com/BurntSushi/ripgrep) for live text search
- [fd](https://github.com/sharkdp/fd) for faster file discovery

Language servers are not installed by this repository. Install only the binaries needed for the languages you use; see [Language support](#language-support).

## Installation

Back up any existing configuration, then clone this repository:

```sh
if [ -d "$HOME/.config/nvim" ]; then
  mv "$HOME/.config/nvim" "$HOME/.config/nvim.backup"
fi
git clone https://github.com/handxr/neovim.git "$HOME/.config/nvim"
nvim
```

On first launch, `vim.pack` downloads the configured plugins and Treesitter begins installing missing parsers asynchronously. Run the following after installation finishes:

```vim
:TSUpdate
:checkhealth
```

A successful setup opens with the `catppuccin-macchiato` colorscheme and lets you open the Oil file explorer with `-`.

## Features

- Native plugin management with locked revisions in `nvim-pack-lock.json`
- Oil file explorer with hidden files and trash-backed deletion
- Telescope file, text, buffer, help, and symbol search
- Neogit plus Gitsigns hunk navigation, blame, diffs, and file history
- Native LSP completion with snippet navigation and autopairs integration
- Treesitter highlighting, HTML/JSX autotagging, and in-buffer Markdown rendering
- Persistent undo, system clipboard integration, relative line numbers, and smart-case search

## Key mappings

The leader key is `Space`.

### General

| Mapping | Action |
| --- | --- |
| `<leader>w` | Save the current file |
| `<leader>q` | Quit the current window |
| `<Esc>` | Clear search highlights |
| `jj` | Leave insert mode |
| `-` | Open the parent directory in Oil |
| `<leader>m` | Toggle rendered Markdown |

### Search

| Mapping | Action |
| --- | --- |
| `<leader>ff` | Find files |
| `<leader>fg` | Search text in the repository |
| `<leader>fb` | List open buffers |
| `<leader>fh` | Search help tags |
| `<leader>fr` | Resume the previous Telescope search |
| `<leader>fs` | Search document symbols |

### LSP and diagnostics

LSP navigation mappings are buffer-local when a client attaches. Completion and diagnostic mappings are configured globally.

| Mapping | Action |
| --- | --- |
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `[d` / `]d` | Go to the previous / next diagnostic and open its float |
| `<Tab>` / `<S-Tab>` | Navigate completion items or snippet placeholders |
| `<CR>` | Accept a selected completion or insert a newline |

Neovim's native LSP mappings remain available, including `K`, `grr`, `grn`, `gra`, `gri`, `grt` (type definition), `gO`, and `<C-w>d` (diagnostic float).

### Git

| Mapping | Action |
| --- | --- |
| `<leader>gs` | Open Neogit |
| `<leader>gb` | Blame the current line |
| `<leader>gB` | Open full-file blame |
| `<leader>gt` | Toggle inline blame |
| `]c` / `[c` | Go to the next / previous hunk |
| `<leader>gp` | Preview the current hunk |
| `<leader>gr` | Reset the current hunk |
| `<leader>gd` | Diff the file against the index |
| `<leader>gc` | Show file commit history; in visual mode, limit it to the selection |

## Language support

Each language module installs its Treesitter parser and enables its native LSP configuration. The server executable must be available on `$PATH` before Neovim opens a matching file.

| Language | Server executable | Project markers |
| --- | --- | --- |
| Assembly | `asm-lsp` | `.asm-lsp.toml`, `.git` |
| C | `clangd` | `compile_commands.json`, `.clangd`, `.git` |
| Go | `gopls` | `go.work`, `go.mod`, `.git` |
| GraphQL | `graphql-lsp` | GraphQL config files only (does not start without one) |
| Java | `jdtls` | Maven or Gradle files, `.git` |
| Lua | `lua-language-server` | `.luarc.json`, `.luarc.jsonc`, `.git` |
| PHP | `intelephense` | `composer.json`, `.git` |
| Python | `pyright-langserver` | `pyproject.toml`, `setup.py`, `.git` |
| Rust | `rust-analyzer` | `Cargo.toml`, `Cargo.lock`, `.git` |
| TypeScript / JavaScript | `typescript-language-server` | `tsconfig.json`, `jsconfig.json`, `package.json`, `.git` |
| HTML / CSS / JSON | `vscode-*-language-server` | `package.json`, `.git` |
| Twig | None | Treesitter highlighting only |

The configuration also installs parsers for Markdown, Vim, Vimdoc, and Treesitter queries.

## Structure

```text
init.lua              Plugin declarations and module loading order
lua/core/             Editor options and global mappings
lua/plugins/          Plugin setup and plugin-specific mappings
lua/lsp/init.lua      Shared completion, diagnostics, and LSP mappings
lua/lang/             Per-language parsers and LSP configurations
nvim-pack-lock.json   Locked plugin revisions
```

Module order in `init.lua` is intentional: core settings load first, plugins load next, shared LSP behavior loads before language modules, and each language module enables its server last.

## Customization

To add a plugin:

1. Add its repository to `vim.pack.add` in `init.lua`.
2. Create `lua/plugins/<name>.lua` for setup and mappings.
3. Require that module from `init.lua`.

To add a language:

1. Create `lua/lang/<name>.lua`.
2. Install its parser with `require("nvim-treesitter").install(...)`.
3. Configure and enable the server with `vim.lsp.config(...)` and `vim.lsp.enable(...)`.
4. Require the module from `init.lua`.
5. Confirm that the server binary is on `$PATH`, then run `:TSUpdate`.

Keep names, descriptions, documentation, and necessary comments in English. Comments should explain non-obvious constraints rather than restating the code.

## Validation

From the repository root, verify that the configuration starts without errors:

```sh
nvim --headless '+qa'
```

For an individual language, open a matching project and use `:LspInfo` to confirm that its server attached.
