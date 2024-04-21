#!/bin/bash

nix build ./flakes/neovim
nix build ./flakes/mosh

case "$1" in
  "darwin-m1") nix run --impure .#darwin-m1 "$@";;
  "debian") nix run --impure .#debian "$@";;
  *)
    "usage: activate {darwin-m1,debian}"
    exit 1;;
esac
