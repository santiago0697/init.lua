### 2025 NeoVim configuration using lua and lazy.vim as plugin manager

## External Dependencies

To make this Neovim configuration work properly, you need to install the following external tools:

### Required
- **Neovim** >= 0.10.0
- **Git** (for plugin management and gitsigns)
- **Node.js** (for some LSP servers and tools)

### Language Servers (LSP)
Install these to enable language-specific features:
- **gopls** - Go language server
  ```bash
  go install golang.org/x/tools/gopls@latest
  ```
- **lua-language-server** - Lua language server
  ```bash
  # macOS (Homebrew)
  brew install lua-language-server
  ```

### Formatters
Install these for code formatting (conform.nvim):
- **goimports** & **gofmt** - Go formatting (gofmt comes with Go)
  ```bash
  go install golang.org/x/tools/cmd/goimports@latest
  ```
- **stylua** - Lua formatter
  ```bash
  # macOS (Homebrew)
  brew install stylua
  # Or via cargo
  cargo install stylua
  ```
- **prettier** - JavaScript/TypeScript/JSON/YAML/Markdown/HTML/CSS formatter
  ```bash
  npm install -g prettier
  ```
- **shfmt** - Shell script formatter
  ```bash
  # macOS (Homebrew)
  brew install shfmt
  # Or via Go
  go install mvdan.cc/sh/v3/cmd/shfmt@latest
  ```

### Linters
Install these for code linting (nvim-lint):
- **golangci-lint** - Go linter
  ```bash
  # macOS (Homebrew)
  brew install golangci-lint
  # Or via Go
  go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
  ```
- **shellcheck** - Shell script linter
  ```bash
  # macOS (Homebrew)
  brew install shellcheck
  ```

### Optional but Recommended
- **ripgrep** - For faster searching (used by many plugins)
  ```bash
  brew install ripgrep
  ```
- **fd** - Fast alternative to find (used by some plugins)
  ```bash
  brew install fd
  ```

### Notes
- Most plugins will be automatically installed by lazy.nvim when you first launch Neovim
- Tree-sitter parsers will be auto-installed when opening supported file types
- Make sure the tools are in your `$PATH` after installation
