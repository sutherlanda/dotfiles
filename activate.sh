#!/bin/bash

nix build ./flakes/neovim
nix flake update neovim-flake
nix build ./flakes/mosh
nix flake update mosh-flake

case "$1" in
  "darwin-m1") nix run --impure .#darwin-m1 "$@";;
  "debian") nix run --impure .#debian "$@";;
  *)
    echo "usage: activate {darwin-m1,debian}"
    exit 1;;
esac
