{ config, pkgs, ... }:

rec {
  home.packages = with pkgs; [
    bash
    curl
    keychain
    mosh
    nix-zsh-completions
    ranger
    tmux
    tree
    zsh
    meslo-lgs-nf
    fira-code
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = false;
    initExtraFirst = ''
      export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh/
      export FZF_BASE=${pkgs.fzf}/share/fzf/
      export EDITOR=vim
      export VISUAL=vim
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
    '';
  };

  home.file.".tmux.conf".source = ../config/tmux/tmux.conf;
  xdg.configFile."ranger/rifle.conf".source = ../config/ranger/rifle.conf;
}
