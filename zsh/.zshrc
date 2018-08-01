fpath=( "$HOME/.oh-my-zsh/custom/functions" $fpath )

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=""

plugins=(
  autojump
  custom-aliases
  django
  docker
  docker-compose
  git
  gitaliases
  npm
  nvmfast
  pure
  ssh-agent
  vi-mode
  yarn
)

source $ZSH/oh-my-zsh.sh

source $HOME/.config/shell/shared/*

autoload -U promptinit; promptinit
prompt pure

BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

export LESS="-R --quit-if-one-screen"

for f in ~/.config/shell/apps/*; do . "$f"; done
