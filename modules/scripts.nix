{ config, pkgs, ... }:

let

  dev = pkgs.writeShellScriptBin "dev-shell" (builtins.readFile ../scripts/dev-shell.sh);
  devList = pkgs.writeShellScriptBin "dev-ls" "tmux ls";

in

{
  home.packages = [ dev devList ];
}
