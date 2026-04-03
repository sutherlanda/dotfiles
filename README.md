# dotfiles

Personal dotfiles managed with [Nix](https://nixos.org/) and [home-manager](https://github.com/nix-community/home-manager).

## What's included

- **zsh** - Shell config with oh-my-zsh, powerlevel10k, autosuggestions, syntax highlighting
- **git** - Aliases, work/personal email switching, remote host switching
- **tmux** - Prefix remapped to `C-f`, vim-style pane navigation, gruvbox theme
- **kitty** - Terminal emulator config with MesloLGS NF font
- **ranger** - File manager with custom rifle and scope configs
- **scripts** - tmux session management (`session`, `sessions`), VPN helpers

## Structure

```
flake.nix          # Nix flake entry point
activate.sh        # Activation script (usage: ./activate.sh darwin-m1)
modules/
  cli.nix          # Shell, terminal, CLI tools
  dev.nix          # Dev tools, LSPs, formatters
  git.nix          # Git and GitHub CLI
  scripts.nix      # Shell scripts wrapped as Nix derivations
config/
  git/             # gitconfig
  kitty/           # kitty.conf and themes
  tmux/            # tmux.conf and themes
  ranger/          # rc.conf, rifle.conf, scope.sh
scripts/           # Shell scripts (session management, VPN)
```

## Setup

Requires [Nix](https://nixos.org/download.html) with flakes enabled.

```sh
# macOS (Apple Silicon)
./activate.sh darwin-m1

# Linux (x86_64)
./activate.sh debian
```

## Supported systems

| Name | Architecture |
|------|-------------|
| `darwin-m1` | aarch64-darwin (macOS Apple Silicon) |
| `debian` | x86_64-linux |
