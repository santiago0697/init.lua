# 2026 Neovim Configuration

A modern Neovim configuration written in Lua, using [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager and the native Neovim 0.11+ LSP API (`vim.lsp.enable` + `lsp/` directory).

## Structure

```
.
├── init.lua              # Entry point
├── lsp/                  # Native LSP server configs (Neovim 0.11+)
│   ├── gopls.lua
│   ├── lua_ls.lua
│   └── vtsls.lua
└── lua/
    ├── config/           # Editor options, keymaps, autocmds, icons
    ├── core/             # Bootstrap: lazy.nvim setup + LSP diagnostics/commands
    └── plugins/          # Plugin specs (one file per plugin)
```

## Requirements

### Required
- **Neovim** >= 0.11.0 (uses `vim.lsp.enable()` and the top-level `lsp/` directory)
- **Git** — for plugin management and `gitsigns.nvim`
- **A Nerd Font** — required for the icons used in diagnostics, statusline, and pickers (e.g. [JetBrainsMono Nerd Font](https://www.nerdfonts.com/))
- **Node.js** & **npm** — required by `vtsls`, `eslint_d`, and `prettier`
- **Go** — required to install `gopls`, `goimports`, and `golangci-lint`

### Language Servers (LSP)

| Server                | Language       | Install |
|-----------------------|----------------|---------|
| `gopls`               | Go             | `go install golang.org/x/tools/gopls@latest` |
| `lua-language-server` | Lua            | `brew install lua-language-server` |
| `vtsls`               | TS / JS / JSX  | `npm install -g @vtsls/language-server` |

### Formatters (via `conform.nvim`)

| Tool         | Filetypes                                                     | Install |
|--------------|---------------------------------------------------------------|---------|
| `goimports`  | go                                                            | `go install golang.org/x/tools/cmd/goimports@latest` |
| `gofmt`      | go                                                            | ships with Go |
| `stylua`     | lua                                                           | `brew install stylua` (or `cargo install stylua`) |
| `prettier`   | js, ts, jsx, tsx, json, jsonc, yaml, markdown, html, css, scss | `npm install -g prettier` |
| `shfmt`      | sh, bash                                                      | `brew install shfmt` (or `go install mvdan.cc/sh/v3/cmd/shfmt@latest`) |

Formatting runs automatically on save (`format_on_save`), or manually with `<leader>=`.

### Linters (via `nvim-lint`)

| Tool             | Filetypes                  | Install |
|------------------|----------------------------|---------|
| `golangci-lint`  | go                         | `brew install golangci-lint` |
| `eslint_d`       | js, ts, jsx, tsx           | `npm install -g eslint_d` |
| `shellcheck`     | sh, bash, zsh              | `brew install shellcheck` |

Linting runs automatically on `BufEnter`, `BufWritePost`, and `InsertLeave`. Trigger manually with `<leader>ll`.

### Recommended CLI tools
- **ripgrep** (`brew install ripgrep`) — used by the snacks.nvim grep pickers
- **fd** (`brew install fd`) — fast file discovery
- **lazygit** (`brew install lazygit`) — invoked from `<leader>gg` via snacks.nvim

## Plugins

| Plugin                                                      | Purpose |
|-------------------------------------------------------------|---------|
| [`folke/lazy.nvim`](https://github.com/folke/lazy.nvim)     | Plugin manager (bootstrapped automatically) |
| [`catppuccin/nvim`](https://github.com/catppuccin/nvim)     | Colorscheme (transparent background) |
| [`folke/snacks.nvim`](https://github.com/folke/snacks.nvim) | Explorer, picker, lazygit integration |
| [`saghen/blink.cmp`](https://github.com/Saghen/blink.cmp)   | Completion engine |
| [`L3MON4D3/LuaSnip`](https://github.com/L3MON4D3/LuaSnip) + [`rafamadriz/friendly-snippets`](https://github.com/rafamadriz/friendly-snippets) | Snippets |
| [`folke/lazydev.nvim`](https://github.com/folke/lazydev.nvim) | Lua/Neovim API completion |
| [`stevearc/conform.nvim`](https://github.com/stevearc/conform.nvim) | Formatting |
| [`mfussenegger/nvim-lint`](https://github.com/mfussenegger/nvim-lint) | Linting |
| [`nvim-treesitter/nvim-treesitter`](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting / indent |
| [`lewis6991/gitsigns.nvim`](https://github.com/lewis6991/gitsigns.nvim) | Git gutter & hunk actions |
| [`nvim-lualine/lualine.nvim`](https://github.com/nvim-lualine/lualine.nvim) | Statusline |
| [`SmiteshP/nvim-navic`](https://github.com/SmiteshP/nvim-navic) | Code context in the winbar |
| [`nvim-tree/nvim-web-devicons`](https://github.com/nvim-tree/nvim-web-devicons) | File-type icons |
| [`windwp/nvim-autopairs`](https://github.com/windwp/nvim-autopairs) | Auto-close brackets/quotes |
| [`unblevable/quick-scope`](https://github.com/unblevable/quick-scope) | Highlight `f`/`F`/`t`/`T` targets |
| [`tpope/vim-commentary`](https://github.com/tpope/vim-commentary) | Toggle comments |
| [`tpope/vim-sleuth`](https://github.com/tpope/vim-sleuth) | Auto-detect indent settings |

Treesitter parsers auto-installed: `bash`, `c`, `html`, `javascript`, `json`, `lua`, `luadoc`, `luap`, `markdown`, `markdown_inline`, `python`, `query`, `regex`, `tsx`, `typescript`, `vim`, `vimdoc`, `yaml`, `go`, `gomod`, `gowork`, `gosum`, `terraform`.

## Initial Setup

### Quick start (recommended)

Clone the repo anywhere, then run the bundled `setup.sh`:

```bash
git clone <this-repo> ~/code/nvim-config
cd ~/code/nvim-config
./setup.sh
```

`setup.sh` will:

1. Verify that Neovim `>= 0.11` and `git` are installed.
2. Install the external tools from [Requirements](#requirements) — language servers, formatters, linters, and the CLI helpers — via `brew`, `go install`, and `npm install -g`. Anything already on your `$PATH` is skipped; missing package managers produce a warning rather than a hard failure.
3. Back up any existing `~/.config/nvim` and `~/.local/share/nvim` to `*.bak.<timestamp>` (prompts before moving).
4. Symlink this repo to `~/.config/nvim` so edits in the repo are picked up immediately.
5. Bootstrap `lazy.nvim` and install all plugins headlessly (`nvim --headless "+Lazy! sync" +qa`).

#### Flags

| Flag           | Behavior |
|----------------|----------|
| `--no-install` | Skip the dependency-install step (assume all external tools are already present). |
| `--copy`       | Copy the repo into `~/.config/nvim` instead of symlinking. |
| `--yes` / `-y` | Don't prompt before moving an existing `~/.config/nvim` or `~/.local/share/nvim` out of the way. |

### Manual setup

If you'd rather do it by hand:

1. Install all required tools listed in [Requirements](#requirements).
2. Back up any existing Neovim config and data:
   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   mv ~/.local/share/nvim ~/.local/share/nvim.bak
   ```
3. Clone this repo into your Neovim config directory:
   ```bash
   git clone <this-repo> ~/.config/nvim
   ```
4. Start Neovim. `lazy.nvim` will bootstrap itself, install all plugins, and treesitter parsers will install lazily on first use of each filetype.
   ```bash
   nvim
   ```

### Verifying the install

After either path, open Neovim and run:

- `:Lazy` — confirm all plugins installed
- `:checkhealth` — confirm Neovim version, providers, and external tool availability
- `:LspInfo` — inspect attached LSP clients in a buffer
- `:LintStatus` — show linters for the current filetype
- `:ConformInfo` — show formatter status

## Key Bindings

Leader key: `<Space>`

### Editor
| Key            | Action |
|----------------|--------|
| `<leader>h`    | New horizontal split |
| `<leader>v`    | New vertical split |
| `<C-h/j/k/l>`  | Move between splits |
| `<C-d>` / `<C-u>` | Half-page scroll (centered) |
| `<Right>` / `<Left>` | Next / previous buffer |
| `<leader>cp`   | Copy relative path of current file |
| `<Esc>`        | Clear search highlight |

### Files & search (snacks.nvim)
| Key            | Action |
|----------------|--------|
| `<leader>e`    | File explorer |
| `<leader>pv`   | Reveal current file in explorer |
| `<leader>ff`   | Find files |
| `<leader>/`    | Live grep |
| `<leader>sw`   | Grep word under cursor / selection |
| `<leader>,`    | Buffer picker |
| `<leader>gg`   | Lazygit |

### LSP
| Key            | Action |
|----------------|--------|
| `gd`           | Goto definition |
| `gr`           | References |
| `gI`           | Goto implementation |
| `gs`           | Signature help |
| `<leader>ss`   | LSP symbols |
| `<leader>cr`   | Rename |
| `<leader>ca`   | Code action |
| `<leader>=`    | Format buffer |

### Diagnostics
| Key            | Action |
|----------------|--------|
| `<leader>dc`   | Show diagnostic float |
| `<leader>da`   | Diagnostics picker |
| `<leader>db`   | Buffer diagnostics picker |
| `<leader>ll`   | Trigger linting |

### Git (gitsigns)
| Key            | Action |
|----------------|--------|
| `<leader>gl`   | Blame line |
| `<leader>gj`   | Next hunk |
| `<leader>gs`   | Stage hunk |

### Buffers
| Key            | Action |
|----------------|--------|
| `<leader>q`    | Delete current buffer |
| `<leader>Q`    | Delete all other buffers |
| `<leader>aq`   | Delete all buffers |

## Custom Commands

- `:LspInfo` — full LSP report (clients, root, capabilities, diagnostics summary)
- `:LspStatus` — concise per-client status
- `:LspCapabilities` — full capability matrix per client
- `:LspRestart` — restart LSP clients attached to the current buffer
- `:LintStatus` — show linters configured for the current filetype

## Notes

- Plugins install on first launch via `lazy.nvim` — no manual sync step needed.
- Treesitter parsers install lazily as filetypes are opened (`auto_install = true`).
- LSP servers are **not** managed by Mason in this config — install them yourself per the table above and make sure they live on your `$PATH`.
- `vim.opt.clipboard = "unnamedplus"` is set, so yanks go to the system clipboard. On Linux ensure `xclip` or `wl-clipboard` is installed.
