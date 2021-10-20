{ pkgs }:

let

  rifle-conf = pkgs.writeTextFile {
    name = "rifle-conf";
    executable = false;
    destination = "/rifle.conf";
    text = (builtins.readFile ./rifle.conf);
  };

in

  pkgs.python3Packages.buildPythonApplication rec {
    pname = "ranger";
    version ="1.9.3";

    src = pkgs.fetchFromGitHub {
      owner = "ranger";
      repo = "ranger";
      rev = "v${version}";
      sha256 = "1rygfryczanvqxn43lmlkgs04sbqznbvbb9hlbm3h5qgdcl0xlw8";
    };

    checkInputs = with pkgs.python3Packages; [ pytestCheckHook ];
    propogatedBuildInputs = with pkgs; [ file python3Packages.pillow ];
    # Overwrite the default rifle.conf
    rifleConfig = "${rifle-conf}/rifle.conf"; 
    preConfigure = ''
      cat "${rifleConfig}" > ranger/config/rifle.conf;
    '';
  }
