for brew_bin in /opt/homebrew/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
  [ -x "$brew_bin" ] && eval "$("$brew_bin" shellenv)" && break
done
unset brew_bin
export PATH="$HOME/.local/bin:$HOME/go/bin:$PATH"
# postgresql@18 is keg-only; bump together with the Brewfile pin
[ -n "$HOMEBREW_PREFIX" ] && export PATH="$HOMEBREW_PREFIX/opt/postgresql@18/bin:$PATH"
unset TERMINFO
# WSL: open links (gh, claude, xdg-open) in the Windows browser
command -v wslview >/dev/null && export BROWSER=wslview
