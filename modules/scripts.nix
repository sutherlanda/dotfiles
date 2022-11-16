{ config, pkgs, ... }:

let

  session = pkgs.writeShellScriptBin "session" (builtins.readFile ../scripts/session.sh);
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
      session
      startVpn
      stopVpn
      nvim-py
    ];
}
