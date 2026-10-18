# dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/) and [Homebrew](https://brew.sh/).

## What's included

- **zsh** - Shell config with oh-my-zsh, powerlevel10k, autosuggestions, syntax highlighting
- **git** - Aliases, work/personal email switching, remote host switching, global gitignore
- **ssh** - `github.com-personal` / `github.com-zestyai` host aliases (keys are not tracked)
- **tmux** - Prefix remapped to `C-f`, vim-style pane navigation, gruvbox theme
- **kitty** - Terminal emulator config with MesloLGS NF font
- **ranger** - File manager with custom rifle and scope configs
- **scripts** - tmux session management (`session`, `sessions`), VPN helpers, `claude-multi`, `claude-settings-sync`, `setup-github`
- **claude** - Global Claude Code instructions and shared base settings

## Structure

Each top-level directory is a Stow package. The paths inside mirror where they land relative to `$HOME`.

```
Brewfile               # Homebrew packages
Brewfile.minimal       # Packages for ./install.sh --minimal
install.sh             # Bootstrap script
macos.sh               # macOS preferences (also run by install.sh)
zesty.example          # Template for untracked ~/.zesty (secrets, work-only env)
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
  .local/bin/          # -> ~/.local/bin/ (claude-multi, claude-settings-sync, session, sessions, setup-github, start-vpn, stop-vpn)
claude/
  .claude/CLAUDE.md            # -> ~/.claude/CLAUDE.md
  .claude/settings.base.json   # -> ~/.claude/settings.base.json (merged into settings.json, see below)
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
5. Merge the shared Claude Code settings into `~/.claude/settings.json` (`claude-settings-sync`)
6. Apply macOS preferences from `macos.sh` (keyboard repeat, Finder, screenshots, Dock recents)

Copy `zesty.example` to `~/.zesty` for machine-local secrets (it is sourced by `.zshrc` and never committed).

Then run `setup-github` to create SSH keys, sign in to both GitHub accounts with `gh`, upload the keys, and switch this repo's remote to SSH.

### Minimal (servers)

For a shell-only machine such as a home server:

```sh
./install.sh --minimal
```

This installs Homebrew and Oh My Zsh, installs only the packages in `Brewfile.minimal`, and stows only `zsh`, `git`, `tmux` and `scripts`. It skips brew autoupdate, the Node/Go/Claude Code installs, `claude-settings-sync` and `macos.sh`. The `ssh` package is left out so an existing `~/.ssh/config` (e.g. one with an OrbStack `Include`) isn't replaced.

## Making changes

Every config in `$HOME` is a symlink into this checkout, so whatever branch `~/dotfiles` has checked out is live. Switching branches here can briefly remove files a branch doesn't have (including `~/.ssh/config`, which git needs to reach GitHub). Keep `~/dotfiles` on `main` and do branch work in a worktree:

```sh
git -C ~/dotfiles worktree add ../dotfiles-wip -b some-change
# edit, commit and push from ~/dotfiles-wip, merge the PR, then:
git -C ~/dotfiles pull
git -C ~/dotfiles worktree remove ../dotfiles-wip
git -C ~/dotfiles branch -d some-change
```

## Claude Code settings

`~/.claude/settings.json` is **not** a symlink: Claude Code writes to it itself (`/model`, `/config`, plugins, auto mode), so a tracked copy conflicted on every machine. Instead, shared settings live in `claude/.claude/settings.base.json` and each machine keeps its own `settings.json`.

After pulling a change to the base file, run:

```sh
claude-settings-sync            # or --dry-run to print the result without writing
```

Objects merge deeply, this machine's value wins for everything else, and permission lists (`allow`, `deny`, `ask`, `additionalDirectories`) are combined. Removing an entry from the base doesn't remove it locally; edit `~/.claude/settings.json` for that. To share a setting across machines, add it to the base file rather than relying on Claude Code's own write.
