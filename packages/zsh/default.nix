{ pkgs }:

let

  # Powerlevel 10 Configuration
  p10k-config = pkgs.writeTextFile {
    name = "p10k-config";
    executable = false;
    destination = "/.p10k.zsh";
    text = (builtins.readFile ./.p10k.zsh);
  };

  # Write .zshrc instead of sourcing ~/.zshrc 
  zshrc = pkgs.writeTextFile {
    name = "zshrc";
    executable = false;
    destination = "/.zshrc";
    text =
      (pkgs.lib.concatStringsSep "\n"
      [''
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
        ZSH_THEME="powerlevel10k/powerlevel10k"
        source ${p10k-config}/.p10k.zsh
      '']);
      
  };

  # Wrap zsh so we can point it to our .zshrc written above.
  zshWrapper = pkgs.writeShellScriptBin "zsh" ''
    ZDOTDIR=${zshrc} ${pkgs.zsh}/bin/zsh $@
  '';

in

  pkgs.symlinkJoin {
    name = "zsh";
    paths = [ zshWrapper ];
  }
