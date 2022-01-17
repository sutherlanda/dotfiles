{ config, pkgs, ... }:

let

  dev = pkgs.writeShellScriptBin "dev-shell" (builtins.readFile ../scripts/dev-shell.sh);
  devList = pkgs.writeShellScriptBin "dev-ls" "tmux ls";
  startVpn = pkgs.writeShellScriptBin "start-vpn" (builtins.readFile ../scripts/start-vpn.sh);
  stopVpn = pkgs.writeShellScriptBin "stop-vpn" (builtins.readFile ../scripts/stop-vpn.sh);

in

{
  home.packages =
    [
      dev
      devList
      startVpn
      stopVpn
    ];
}
