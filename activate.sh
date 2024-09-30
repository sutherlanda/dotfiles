#!/bin/bash

case "$1" in
  "darwin-m1") nix run --impure .#darwin-m1 "$@";;
  "debian") nix run --impure .#debian "$@";;
  *)
    echo "usage: activate {darwin-m1,debian}"
    exit 1;;
esac
