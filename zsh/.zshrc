# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
[[ -d "${XDG_CACHE_HOME:-$HOME/.cache}/gitstatus" ]] || mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/gitstatus"

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

BREW_PREFIX="/opt/homebrew"

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
export FZF_BASE="$BREW_PREFIX/opt/fzf"

# Environment
export NVIM_TUI_ENABLE_TRUE_COLOR=1
export XDG_CONFIG_HOME="$HOME/.config"
export PGDATA="$HOME/pgdata"
export EDITOR=nvim
export VISUAL=nvim
DISABLE_AUTO_TITLE="true"

# History
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt INC_APPEND_HISTORY

# Completion
autoload -U compinit && compinit
unsetopt menu_complete
setopt completealiases

# Oh My Zsh plugins and init
plugins=(git fzf)
source "$ZSH/oh-my-zsh.sh"

# Zsh plugins (Homebrew)
source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$BREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme"

# Direnv
eval "$(direnv hook zsh)"

# Source work-specific config if present
if [ -f "$HOME/.zesty" ]; then
    source "$HOME/.zesty"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
