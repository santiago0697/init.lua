#!/usr/bin/env bash
#
# Set up this Neovim configuration on a fresh machine.
#   - installs required external tools (LSPs, formatters, linters, CLI tools)
#   - backs up any existing ~/.config/nvim and ~/.local/share/nvim
#   - symlinks this repo to ~/.config/nvim
#   - bootstraps lazy.nvim and installs plugins headlessly
#
# Usage:  ./setup.sh [--no-install] [--copy] [--yes]
#   --no-install   Skip installing external tools (assume they are present)
#   --copy         Copy the repo to ~/.config/nvim instead of symlinking
#   --yes          Don't prompt for confirmation before touching ~/.config/nvim

set -euo pipefail

NO_INSTALL=0
USE_COPY=0
ASSUME_YES=0
for arg in "$@"; do
	case "$arg" in
		--no-install) NO_INSTALL=1 ;;
		--copy)       USE_COPY=1 ;;
		--yes|-y)     ASSUME_YES=1 ;;
		-h|--help)
			sed -n '2,12p' "$0" | sed 's/^# \{0,1\}//'
			exit 0
			;;
		*) echo "Unknown argument: $arg" >&2; exit 2 ;;
	esac
done

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NVIM_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
NVIM_DATA="${XDG_DATA_HOME:-$HOME/.local/share}/nvim"
TS="$(date +%Y%m%d-%H%M%S)"

log()  { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m!!\033[0m  %s\n' "$*" >&2; }
err()  { printf '\033[1;31mxx\033[0m  %s\n' "$*" >&2; }
have() { command -v "$1" >/dev/null 2>&1; }

confirm() {
	[[ "$ASSUME_YES" -eq 1 ]] && return 0
	read -r -p "$1 [y/N] " ans
	[[ "$ans" =~ ^([yY]|[yY][eE][sS])$ ]]
}

# ---------- preflight ----------

if ! have nvim; then
	err "Neovim is not installed. Install it first (brew install neovim) and re-run."
	exit 1
fi

NVIM_VERSION="$(nvim --version | head -n1 | awk '{print $2}' | sed 's/^v//')"
NVIM_MAJOR="${NVIM_VERSION%%.*}"
NVIM_MINOR="$(echo "$NVIM_VERSION" | cut -d. -f2)"
if (( NVIM_MAJOR < 1 )) && (( NVIM_MINOR < 11 )); then
	err "Neovim >= 0.11.0 is required (found $NVIM_VERSION)."
	exit 1
fi
log "Found Neovim $NVIM_VERSION"

if ! have git; then
	err "git is required."
	exit 1
fi

# ---------- install external tools ----------

install_brew_pkg() {
	local pkg="$1"
	if have brew && ! brew list --formula "$pkg" >/dev/null 2>&1; then
		log "brew install $pkg"
		brew install "$pkg"
	fi
}

install_go_pkg() {
	local pkg="$1"; local bin="$2"
	if have go && ! have "$bin"; then
		log "go install $pkg"
		go install "$pkg"
	fi
}

install_npm_pkg() {
	local pkg="$1"; local bin="$2"
	if have npm && ! have "$bin"; then
		log "npm install -g $pkg"
		npm install -g "$pkg"
	fi
}

if [[ "$NO_INSTALL" -eq 0 ]]; then
	log "Installing external tools (skip with --no-install)"

	if ! have brew; then
		warn "Homebrew not found — brew-installed tools will be skipped."
	fi
	if ! have go; then
		warn "Go not found — gopls / goimports / shfmt(go) will be skipped."
	fi
	if ! have npm; then
		warn "npm not found — vtsls / eslint_d / prettier will be skipped."
	fi

	# language servers
	install_brew_pkg lua-language-server
	install_go_pkg   golang.org/x/tools/gopls@latest                 gopls
	install_npm_pkg  @vtsls/language-server                          vtsls

	# formatters
	install_go_pkg   golang.org/x/tools/cmd/goimports@latest         goimports
	install_brew_pkg stylua
	install_brew_pkg shfmt
	install_npm_pkg  prettier                                        prettier

	# linters
	install_brew_pkg golangci-lint
	install_brew_pkg shellcheck
	install_npm_pkg  eslint_d                                        eslint_d

	# CLI helpers used by snacks.nvim
	install_brew_pkg ripgrep
	install_brew_pkg fd
	install_brew_pkg lazygit
fi

# ---------- link config ----------

if [[ -e "$NVIM_CONFIG" || -L "$NVIM_CONFIG" ]]; then
	# already pointing here? nothing to do.
	if [[ -L "$NVIM_CONFIG" ]] && [[ "$(readlink "$NVIM_CONFIG")" == "$REPO_DIR" ]]; then
		log "$NVIM_CONFIG already links to this repo — leaving it alone."
	else
		warn "$NVIM_CONFIG already exists."
		confirm "Move it to ${NVIM_CONFIG}.bak.${TS} and continue?" || { err "Aborted."; exit 1; }
		mv "$NVIM_CONFIG" "${NVIM_CONFIG}.bak.${TS}"
		log "Backed up to ${NVIM_CONFIG}.bak.${TS}"
	fi
fi

if [[ -d "$NVIM_DATA" ]]; then
	warn "$NVIM_DATA exists (plugin state from a previous config)."
	if confirm "Move it to ${NVIM_DATA}.bak.${TS} for a clean install?"; then
		mv "$NVIM_DATA" "${NVIM_DATA}.bak.${TS}"
		log "Backed up to ${NVIM_DATA}.bak.${TS}"
	fi
fi

if [[ ! -e "$NVIM_CONFIG" ]]; then
	mkdir -p "$(dirname "$NVIM_CONFIG")"
	if [[ "$USE_COPY" -eq 1 ]]; then
		log "Copying $REPO_DIR -> $NVIM_CONFIG"
		cp -R "$REPO_DIR" "$NVIM_CONFIG"
	else
		log "Linking $REPO_DIR -> $NVIM_CONFIG"
		ln -s "$REPO_DIR" "$NVIM_CONFIG"
	fi
fi

# ---------- bootstrap plugins ----------

log "Bootstrapping lazy.nvim and installing plugins (headless)…"
nvim --headless "+Lazy! sync" +qa || warn "lazy.nvim sync exited non-zero — open nvim and run :Lazy to inspect."

log "Done. Launch with: nvim"
log "Then verify with :checkhealth, :Lazy, :LspInfo"
