# Taps
tap "domt4/autoupdate" if OS.mac?

# CLI tools
brew "bat"
brew "curl"
brew "direnv"
brew "fzf"
brew "gnu-sed"
brew "jq"
brew "ranger"
brew "stow"
brew "tmux"
brew "tree"

# Linux/WSL only (macOS has pbcopy and its own ssh-agent keychain)
if OS.linux?
  brew "keychain"
  brew "xclip"
end

# Terminal (casks are macOS-only; on WSL use Windows Terminal)
cask "kitty" if OS.mac?

# Apps (Docker Desktop's installer asks for sudo, so run install.sh interactively)
cask "docker-desktop" if OS.mac?
cask "pgadmin4" if OS.mac?

# Cloud
cask "gcloud-cli" if OS.mac?
brew "cloud-sql-proxy" # v2; used by csp in zestyai/scripts

# Kubernetes
brew "kubectl"
brew "kubectx"
brew "k9s"

# Shell
brew "zsh-autosuggestions"
brew "zsh-syntax-highlighting"
brew "powerlevel10k"

# Fonts (on WSL, install MesloLGS NF on the Windows side:
# https://github.com/romkatv/powerlevel10k#manual-font-installation)
if OS.mac?
  cask "font-fira-code-nerd-font"
  cask "font-meslo-lg-nerd-font"
end

# Git
brew "git"
brew "git-crypt"
brew "gh"

# Dev tools & LSPs
brew "autopep8"
brew "bash-language-server"
brew "eslint_d"
brew "fd"
brew "fnm"
brew "go"
brew "gopls"
brew "hurl"
brew "k6"
brew "luajit"
brew "neovim"
brew "postgresql@18" # pinned: major upgrades need a pg_upgrade of $PGDATA
brew "prettier"
brew "prettierd"
brew "pyright"
brew "ripgrep"
brew "rust-analyzer"
brew "rustfmt"
brew "shellcheck"
brew "shfmt"
brew "stylua"
brew "the_silver_searcher"
brew "tree-sitter"
brew "tree-sitter-cli"
brew "typescript-language-server"
brew "universal-ctags"
brew "uv"
brew "yarn"
