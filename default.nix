let
  pkgs = import (import ./config/nixpkgs.nix) {};

  my-pkgs = with pkgs;
    [
      # Customized packages
      zsh
      neovim
      ranger
      tmux
      git

      # Unmodified packages
      pkgs.file
      pkgs.git
      pkgs.curl
      pkgs.which
      pkgs.direnv
      pkgs.fzf
      pkgs.htop
      pkgs.less
      pkgs.niv
      pkgs.nix
      pkgs.nix-diff
      pkgs.tree
    ];

  zsh = import ./packages/zsh { inherit pkgs; };
  neovim = import ./packages/neovim { inherit pkgs; };
  ranger = import ./packages/ranger { inherit pkgs; };
  tmux = import ./packages/tmux { inherit pkgs; };
  git = import ./packages/git { inherit pkgs; };

in
  if pkgs.lib.inNixShell
    then pkgs.mkShell
      { buildInputs = my-pkgs;
        shellHook = ''
          export SHELL=${zsh}/bin/zsh
        '';
      }
    else my-pkgs
