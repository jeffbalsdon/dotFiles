#Basic .zshrc file to use for oh my zsh and powerlevel10k theme

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH:/usr/sbin

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search)
source $ZSH/oh-my-zsh.sh

if [ -x "$(command -v exa)" ]; then
    alias ls="exa --icons"
    alias la="exa --long --all --group --icons"
fi
alias nano="/opt/homebrew/bin/nano"

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
