{
  config,
  pkgs,
  ...
}: let
  session = pkgs.writeShellScriptBin "session" (builtins.readFile ../scripts/session.sh);
  sessions = pkgs.writeShellScriptBin "sessions" (builtins.readFile ../scripts/sessions.sh);
  startVpn = pkgs.writeShellScriptBin "start-vpn" (builtins.readFile ../scripts/start-vpn.sh);
  stopVpn = pkgs.writeShellScriptBin "stop-vpn" (builtins.readFile ../scripts/stop-vpn.sh);
in {
  home.packages = [
    session
    sessions
    startVpn
    stopVpn
  ];
}
