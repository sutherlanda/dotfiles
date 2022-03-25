{ config, pkgs, ... }:

let

  dev = pkgs.writeShellScriptBin "dev" (builtins.readFile ../scripts/dev-shell.sh);
  devList = pkgs.writeShellScriptBin "dev-ls" "tmux ls";
  startVpn = pkgs.writeShellScriptBin "start-vpn" (builtins.readFile ../scripts/start-vpn.sh);
  stopVpn = pkgs.writeShellScriptBin "stop-vpn" (builtins.readFile ../scripts/stop-vpn.sh);
  nvim-py = pkgs.writeShellScriptBin "nvim-py" ''
    if [[ -e "$VIRTUAL_ENV" && -f "$VIRTUAL_ENV/bin/activate" ]]; then
      source "$VIRTUAL_ENV/bin/activate"
      command nvim $@
    else
      command nvim $@
    fi
  '';

in

{
  home.packages =
    [
      dev
      devList
      startVpn
      stopVpn
      nvim-py
    ];
}
