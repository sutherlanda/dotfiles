{ config, pkgs, ...}:

let

  dev = pkgs.writeShellScriptBin "dev" (builtins.readFile ../scripts/dev.sh);
  devFromFlake = pkgs.writeShellScriptBin "dev-from-flake" (builtins.readFile ../scripts/dev-with-deps.sh);
  devList = pkgs.writeShellScriptBin "dev-ls" "tmux ls";

in

  {
    home.packages = [ dev devFromFlake devList ];
  }
