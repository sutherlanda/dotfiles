#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
STOW_PACKAGES=(zsh git tmux kitty ranger scripts)

# Install Homebrew if missing
if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install Oh My Zsh if missing
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    ZSH= sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
fi

# Install packages
echo "Installing packages from Brewfile..."
brew bundle --file="$DOTFILES_DIR/Brewfile" || echo "Warning: some packages failed to install (see above)"

# Set up brew autoupdate (daily updates via launchd)
echo "Configuring brew autoupdate..."
brew tap homebrew/autoupdate 2>/dev/null || true
brew autoupdate delete 2>/dev/null || true
brew autoupdate start 86400 --upgrade --cleanup

# Install Go tools (not available via Homebrew)
if command -v go &>/dev/null; then
    echo "Installing Go tools..."
    go install golang.org/x/tools/cmd/goimports@latest
fi

# Create ~/.local/bin if it doesn't exist
mkdir -p "$HOME/.local/bin"

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
    stow -v --target="$HOME" --restow "$pkg"
done

echo "Done!"
