# Check if XDG_CONFIG_HOME is set, and if not, set it to a default value
if [ -z "$XDG_CONFIG_HOME" ]; then
    export XDG_CONFIG_HOME="$HOME/.config"
fi

# Load brew
eval "$(/opt/homebrew/bin/brew shellenv)"

# FNM
eval "$(fnm env --use-on-cd)"

# Aliases

if [[ -f $(which nvim) ]]; then
  alias vi="nvim"
else
  alias vi="vim"
fi

if [[ ! -z $(command -v lsd) ]]; then
  alias ls="lsd"
fi

if [[ ! -z $(command -v bat) ]]; then
  alias bat="cat"
fi

alias vi-home="nvim ~/projects/personal/home"
alias vi-qmk="nvim ~/projects/personal/qmk"

# Git completions
# zstyle ':completion:*:*:git:*' script ~/.git-completion.bash
# fpath=(~/.zsh/functions $fpath)
# autoload -Uz compinit && compinit
