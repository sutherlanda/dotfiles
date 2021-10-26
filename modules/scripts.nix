{ config, pkgs, ...}:

let
  foo = pkgs.writeShellScriptBin "dev" (builtins.readFile ../scripts/dev.sh);
in
  {
    home.packages = [ foo ];
  }
