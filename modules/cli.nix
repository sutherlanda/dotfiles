{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    bash
    curl
    fira-code
    keychain
    meslo-lgs-nf
    mosh
    ranger
    tmux
    tree
    gnused
    kitty
    kubectl
    kubectx
    k9s
    google-cloud-sql-proxy
    xclip
    bat
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = false;
    initExtraFirst = ''
      export TERM=xterm-256color
      export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh
      export FZF_BASE=${pkgs.fzf}/share/fzf
      export EDITOR=nvimvenv
      export VISUAL=nvimvenv
      export NIX_PATH=darwin-config=$HOME/.nixpkgs/darwin-configuration.nix:$HOME/.nix-defexpr/channels''${NIX_PATH:+:}$NIX_PATH
      export NIX_PATH=$HOME/.nix-defexpr/channels''${NIX_PATH:+:}$NIX_PATH
      export NVIM_TUI_ENABLE_TRUE_COLOR=1
      export XDG_CONFIG_HOME=$HOME/.config
      export PGDATA=$HOME/pgdata
      export NIXPKGS_ALLOW_BROKEN=1
      plugins=(git fzf)
      setopt SHARE_HISTORY
      setopt HIST_IGNORE_ALL_DUPS
      setopt HIST_IGNORE_DUPS
      setopt INC_APPEND_HISTORY
      autoload -U compinit && compinit
      unsetopt menu_complete
      setopt completealiases
      source $ZSH/oh-my-zsh.sh
      source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
      source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/config/p10k-lean.zsh
      DISABLE_AUTO_TITLE="true"
      if [ -f "$HOME/.zesty" ]; then
          source "$HOME/.zesty"
      fi

    '';
  };

  home.file.".tmux.conf".source = ../config/tmux/tmux.conf;
  home.file.".config/tmux".source = ../config/tmux;
  home.file.".config/ranger/rifle.conf".source = ../config/ranger/rifle.conf;
  home.file.".config/ranger/rc.conf".source = ../config/ranger/rc.conf;
  home.file.".config/ranger/scope.sh".source = ../config/ranger/scope.sh;
  home.file.".zshenv".text = ''
    export PATH=$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:/usr/local/go/bin:$PATH
    alias nvim=nvimvenv
  '';
  home.file.".kitty.conf".source = ../config/kitty/kitty.conf;
  home.file.".config/kitty".source = ../config/kitty;
  home.file.".config/nvim/init.vim".text = "";
}
