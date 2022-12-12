{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    alacritty
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
    cloud-sql-proxy
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = false;
    initExtraFirst = ''
      export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh
      export FZF_BASE=${pkgs.fzf}/share/fzf
      export EDITOR=nvim
      export VISUAL=nvim
      export NIX_PATH=darwin-config=$HOME/.nixpkgs/darwin-configuration.nix:$HOME/.nix-defexpr/channels''${NIX_PATH:+:}$NIX_PATH
      export NIX_PATH=$HOME/.nix-defexpr/channels''${NIX_PATH:+:}$NIX_PATH
      export TERM=screen-256color
      export NVIM_TUI_ENABLE_TRUE_COLOR=1
      export XDG_CONFIG_HOME=$HOME/.config
      export PGDATA=$HOME/pgdata
      plugins=(git fzf)
      HISTFILESIZE=500000
      HISTSIZE=500000
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
      ZSH_THEME="powerlevel10k/powerlevel10k"
      DISABLE_AUTO_TITLE="true"

      eval "$(direnv hook zsh)"

      eval "$(keychain --eval id_rsa_github_personal -q --noask)"
      eval "$(keychain --eval id_rsa_github_zesty -q --noask)"

      alias t-start='sudo systemctl start transmission-daemon.service'
      alias t-stop='sudo systemctl stop transmission-daemon.service'
      alias t-list='transmission-remote -n 'transmission:transmission' -l'
      alias t-basicstats='transmission-remote -n 'transmission:transmission' -st'
      alias t-fullstats='transmission-remote -n 'transmission:transmission' -si'

      alias pg-start='pg_ctl -D $HOME/pgdata -l logfile start'
      alias pg-stop='pg_ctl stop'

      alias myip='curl https://ipinfo.io/ip'

      if [ -f $HOME/zesty.zsh ]; then
        source $HOME/zesty.zsh
      fi
    '';
  };

  home.file.".tmux.conf".source = ../config/tmux/tmux.conf;
  home.file.".config/tmux".source = ../config/tmux;
  home.file.".config/ranger/rifle.conf".source = ../config/ranger/rifle.conf;
  home.file.".config/ranger/rc.conf".source = ../config/ranger/rc.conf;
  home.file.".zshenv".text = ''
    export PATH=$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$PATH
  '';
  home.file.".alacritty.yml".source = ../config/alacritty/alacritty.yml;
}
