{ config, pkgs, ...}:

let
  rustEnv = dev { name = "rust-env"; envPath = ../packages/rust; };

  dev = { name, envPath }: pkgs.writeShellScriptBin name ''
    if [ $# -ne 1 ]; then
      echo "usage: ${name} session";
      exit 1
    fi

    session=$1

    # Check if there is an existing session
    tmux has-session -t $session 2> /dev/null

    # Create a new session if one was not found
    if [ $? != 0 ]
    then
      tmux new-session -s $session -n ranger -d "nix develop ${envPath}# -c ranger"
      tmux new-window -t $session -n shell "nix develop ${envPath}# -c $SHELL"
      tmux select-window -t $session:1
    fi

    tmux attach-session -t $session
  '';
in
  {
    home.packages = [ rustEnv ];
  }
