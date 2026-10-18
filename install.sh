#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# --minimal: shell-only setup for servers (Brewfile.minimal, no GUI/dev
# tooling, no ssh config, no Claude Code, no macOS preferences)
MINIMAL=false
for arg in "$@"; do
    case "$arg" in
        --minimal) MINIMAL=true ;;
        *) echo "Usage: $0 [--minimal]" >&2; exit 1 ;;
    esac
done

if $MINIMAL; then
    BREWFILE="$DOTFILES_DIR/Brewfile.minimal"
    STOW_PACKAGES=(zsh git tmux scripts)
else
    BREWFILE="$DOTFILES_DIR/Brewfile"
    STOW_PACKAGES=(zsh git ssh tmux kitty ranger scripts claude)
fi

# Install Homebrew if missing
if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    for brew_bin in /opt/homebrew/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
        [ -x "$brew_bin" ] && eval "$("$brew_bin" shellenv)" && break
    done
fi

# Install Oh My Zsh if missing
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    ZSH="" sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
fi

# Install packages
echo "Installing packages from $(basename "$BREWFILE")..."
brew bundle --file="$BREWFILE" || echo "Warning: some packages failed to install (see above)"

# Set up brew autoupdate (daily updates via launchd, macOS only)
if ! $MINIMAL && [ "$(uname)" = "Darwin" ]; then
    echo "Configuring brew autoupdate..."
    # Homebrew moved this tap to domt4/autoupdate and only loads commands from
    # trusted third-party taps
    brew tap domt4/autoupdate
    brew trust --tap domt4/autoupdate
    brew autoupdate delete 2>/dev/null || true
    brew autoupdate start 86400 --upgrade --cleanup
fi

# Install the latest LTS Node as fnm's default
if ! $MINIMAL && command -v fnm &>/dev/null && ! fnm list | grep -q default; then
    echo "Installing Node LTS..."
    fnm install --lts && fnm default lts-latest
fi

# Install Go tools (not available via Homebrew)
if ! $MINIMAL && command -v go &>/dev/null; then
    echo "Installing Go tools..."
    go install golang.org/x/tools/cmd/goimports@latest
fi

# Create ~/.local/bin if it doesn't exist
mkdir -p "$HOME/.local/bin"

# Install Claude Code (native installer, self-updating, lands in ~/.local/bin)
if ! $MINIMAL && [ ! -x "$HOME/.local/bin/claude" ]; then
    echo "Installing Claude Code..."
    curl -fsSL https://claude.ai/install.sh | bash
fi

# Stow all packages
echo "Linking dotfiles..."
cd "$DOTFILES_DIR"
for pkg in "${STOW_PACKAGES[@]}"; do
    echo "  Stowing $pkg..."
    # Remove files/symlinks that would conflict with stow
    while IFS= read -r file; do
        rel="${file#"$DOTFILES_DIR/$pkg/"}"
        target="$HOME/$rel"
        # Check parent directories — if any is an external symlink (e.g. Nix),
        # remove the symlink so stow can create the real directory
        dir="$rel"
        while dir="$(dirname "$dir")" && [ "$dir" != "." ]; do
            parent="$HOME/$dir"
            if [ -L "$parent" ] && ! readlink "$parent" | grep -q "$DOTFILES_DIR"; then
                echo "  Removing external symlink: $dir => $(readlink "$parent")"
                rm "$parent"
                break
            fi
        done
        if [ -L "$target" ] && ! readlink "$target" | grep -q "$DOTFILES_DIR"; then
            echo "  Removing external symlink: $rel => $(readlink "$target")"
            rm "$target"
        elif [ -f "$target" ] && ! [ -L "$target" ]; then
            echo "  Removing existing file: $rel"
            rm "$target"
        fi
    done < <(find "$DOTFILES_DIR/$pkg" -type f)
    # --no-folding: link files, not whole directories, so files apps write at
    # runtime (e.g. ~/.claude credentials/history) stay out of the repo
    stow -v --no-folding --target="$HOME" --restow "$pkg"
done

if ! $MINIMAL; then
    # Claude Code writes to its own settings.json, so it's a per-machine file
    # seeded from the stowed settings.base.json rather than a symlink
    "$DOTFILES_DIR/scripts/.local/bin/claude-settings-sync"

    # macOS preferences (no-op elsewhere)
    "$DOTFILES_DIR/macos.sh"
fi

echo "Done!"
