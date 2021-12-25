#!/bin/bash

case "$1" in
  "darwin-m1") nix run .#darwin-m1 "$@";;
  "debian") nix run .#debian "$@";;
  *)
    "usage: activate {darwin-m1,debian}"
    exit 1;;
esac
