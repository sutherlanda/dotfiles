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

# Create ~/.local/bin if it doesn't exist
mkdir -p "$HOME/.local/bin"

# Stow all packages
echo "Linking dotfiles..."
cd "$DOTFILES_DIR"
for pkg in "${STOW_PACKAGES[@]}"; do
    echo "  Stowing $pkg..."
    stow -v --target="$HOME" --restow "$pkg"
done

echo "Done!"
