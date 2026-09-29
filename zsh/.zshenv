for brew_bin in /opt/homebrew/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
  [ -x "$brew_bin" ] && eval "$("$brew_bin" shellenv)" && break
done
unset brew_bin
export PATH="$HOME/.local/bin:$HOME/go/bin:$PATH"
unset TERMINFO
# WSL: open links (gh, claude, xdg-open) in the Windows browser
command -v wslview >/dev/null && export BROWSER=wslview
