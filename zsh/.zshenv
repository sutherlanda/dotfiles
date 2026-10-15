for brew_bin in /opt/homebrew/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
  [ -x "$brew_bin" ] && eval "$("$brew_bin" shellenv)" && break
done
unset brew_bin
export PATH="$HOME/.local/bin:$HOME/go/bin:$PATH"
# postgresql@18 is keg-only; bump together with the Brewfile pin
[ -n "$HOMEBREW_PREFIX" ] && export PATH="$HOMEBREW_PREFIX/opt/postgresql@18/bin:$PATH"
# Docker Desktop installs its CLI per-user
[ -d "$HOME/.docker/bin" ] && export PATH="$HOME/.docker/bin:$PATH"
# Google Cloud SDK: pin Homebrew's Python (gcloud rejects the system 3.9)
# and add the SDK's component bin dir
if [ -d "$HOMEBREW_PREFIX/share/google-cloud-sdk" ]; then
  export CLOUDSDK_PYTHON="$HOMEBREW_PREFIX/bin/python3"
  source "$HOMEBREW_PREFIX/share/google-cloud-sdk/path.zsh.inc"
fi
unset TERMINFO
# WSL: open links (gh, claude, xdg-open) in the Windows browser
command -v wslview >/dev/null && export BROWSER=wslview
