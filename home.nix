{ config, pkgs, ... }:

let

  neovim = import ./packages/neovim { inherit pkgs; };
  ranger = import ./packages/ranger { inherit pkgs; };
  zsh = import ./packages/zsh { inherit pkgs; };
  tmux = import ./packages/tmux { inherit pkgs; };
  git = import ./packages/git { inherit pkgs; };

in

  {
    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    home.username = "andrewsutherland";
    home.homeDirectory = "/Users/andrewsutherland";

    # Package to install
    home.packages = [
      # Customized packages
      neovim
      ranger
      zsh
      tmux
      git

      # Standard packages
    ];

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    home.stateVersion = "21.11";
  }
