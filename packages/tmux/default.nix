{ pkgs }:

pkgs.symlinkJoin {
  name = "tmux";
  buildInputs = [ pkgs.makeWrapper ];
  paths = [ pkgs.tmux ];
  postBuild = ''
    wrapProgram "$out/bin/tmux" --add-flags "-u -f ${./tmux.conf}"
  '';
}
