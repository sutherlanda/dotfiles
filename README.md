# dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/) and [Homebrew](https://brew.sh/).

## What's included

- **zsh** - Shell config with oh-my-zsh, powerlevel10k, autosuggestions, syntax highlighting
- **git** - Aliases, work/personal email switching, remote host switching, global gitignore
- **tmux** - Prefix remapped to `C-f`, vim-style pane navigation, gruvbox theme
- **kitty** - Terminal emulator config with MesloLGS NF font
- **ranger** - File manager with custom rifle and scope configs
- **scripts** - tmux session management (`session`, `sessions`), VPN helpers, `claude-multi`

## Structure

Each top-level directory is a Stow package. The paths inside mirror where they land relative to `$HOME`.

```
Brewfile               # Homebrew packages
install.sh             # Bootstrap script
zsh/
  .zshrc               # -> ~/.zshrc
  .zshenv              # -> ~/.zshenv
git/
  .config/git/config   # -> ~/.config/git/config
  .config/git/ignore   # -> ~/.config/git/ignore
tmux/
  .tmux.conf           # -> ~/.tmux.conf
  .config/tmux/        # -> ~/.config/tmux/ (themes)
kitty/
  .config/kitty/       # -> ~/.config/kitty/ (config + themes)
ranger/
  .config/ranger/      # -> ~/.config/ranger/ (rc, rifle, scope)
scripts/
  .local/bin/          # -> ~/.local/bin/ (claude-multi, session, sessions, start-vpn, stop-vpn)
```

## Setup

```sh
./install.sh
```

This will:

1. Install [Homebrew](https://brew.sh/) if missing
2. Install [Oh My Zsh](https://ohmyz.sh/) if missing
3. Install all packages from the `Brewfile`
4. Symlink all configs to `$HOME` via Stow
