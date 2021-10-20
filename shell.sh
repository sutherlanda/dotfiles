#!/bin/zsh
nix-shell --pure --command "exec zsh; return" "$@"
