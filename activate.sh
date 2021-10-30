#!/bin/bash

case "$1" in
  "darwin") nix run .#darwin;;
  "debian") nix run .#debian;;
  "nixos") nix run .#nixos;;
  *)
    "usage: activate {darwin,debian,nixos}"
    exit 1;;
esac
