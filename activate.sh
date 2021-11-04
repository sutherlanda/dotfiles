#!/bin/bash

case "$1" in
  "darwin-intel") nix run .#darwin-intel;;
  "darwin-m1") nix run .#darwin-m1;;
  "debian") nix run .#debian;;
  "nixos") nix run .#nixos;;
  *)
    "usage: activate {darwin,debian,nixos}"
    exit 1;;
esac
