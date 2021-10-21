{ pkgs }:

let

  gitHome = pkgs.writeTextFile
    {
      name = "git-config";
      text =
        builtins.replaceStrings
          [ "SUBSTITUTE_GITIGNORE" ] [ "${./gitignore}" ]
          (builtins.readFile ./config);
      destination = "/.gitconfig";
    };

in

  pkgs.symlinkJoin {
    name = "git";
    buildInputs = [ pkgs.makeWrapper ];
    paths = [ pkgs.git ];
    postBuild = ''
      wrapProgram "$out/bin/git" --set HOME "${gitHome}"
    '';
  }
