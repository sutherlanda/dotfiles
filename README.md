# dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/) and [Homebrew](https://brew.sh/).

## What's included

- **zsh** - Shell config with oh-my-zsh, powerlevel10k, autosuggestions, syntax highlighting
- **git** - Aliases, work/personal email switching, remote host switching, global gitignore
- **ssh** - `github.com-personal` / `github.com-zestyai` host aliases (keys are not tracked)
- **tmux** - Prefix remapped to `C-f`, vim-style pane navigation, gruvbox theme
- **kitty** - Terminal emulator config with MesloLGS NF font
- **ranger** - File manager with custom rifle and scope configs
- **scripts** - tmux session management (`session`, `sessions`), VPN helpers, `claude-multi`, `setup-github`

## Structure

Each top-level directory is a Stow package. The paths inside mirror where they land relative to `$HOME`.

```
Brewfile               # Homebrew packages
install.sh             # Bootstrap script
macos.sh               # macOS preferences (also run by install.sh)
zsh/
  .zshrc               # -> ~/.zshrc
  .zshenv              # -> ~/.zshenv
  .p10k.zsh            # -> ~/.p10k.zsh
git/
  .config/git/config   # -> ~/.config/git/config
  .config/git/ignore   # -> ~/.config/git/ignore
  .config/git/work     # -> ~/.config/git/work (work email for ~/projects/zesty/)
ssh/
  .ssh/config          # -> ~/.ssh/config
tmux/
  .tmux.conf           # -> ~/.tmux.conf
  .config/tmux/        # -> ~/.config/tmux/ (themes)
kitty/
  .config/kitty/       # -> ~/.config/kitty/ (config + themes)
ranger/
  .config/ranger/      # -> ~/.config/ranger/ (rc, rifle, scope)
scripts/
  .local/bin/          # -> ~/.local/bin/ (claude-multi, session, sessions, setup-github, start-vpn, stop-vpn)
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
5. Apply macOS preferences from `macos.sh` (keyboard repeat, Finder, screenshots, Dock recents)

Then run `setup-github` to create SSH keys, sign in to both GitHub accounts with `gh`, upload the keys, and switch this repo's remote to SSH.

## Making changes

Every config in `$HOME` is a symlink into this checkout, so whatever branch `~/dotfiles` has checked out is live. Switching branches here can briefly remove files a branch doesn't have (including `~/.ssh/config`, which git needs to reach GitHub). Keep `~/dotfiles` on `main` and do branch work in a worktree:

```sh
git -C ~/dotfiles worktree add ../dotfiles-wip -b some-change
# edit, commit and push from ~/dotfiles-wip, merge the PR, then:
git -C ~/dotfiles pull
git -C ~/dotfiles worktree remove ../dotfiles-wip
git -C ~/dotfiles branch -d some-change
```
