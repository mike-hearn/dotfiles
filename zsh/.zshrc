SHELL=/bin/zsh

ZSH_THEME=""
ZSH_CUSTOM="$HOME/.config/shell/zsh"

fpath=( "$ZSH_CUSTOM/functions" $fpath )

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"


plugins=(
  autojump
  django
  docker
  docker-compose
  git
  npm
  nvmfast
  pure
  ssh-agent
  vi-mode
  yarn
)

source $ZSH/oh-my-zsh.sh

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

for f in ~/.config/shell/shared/*; do . "$f"; done
for f in ~/.config/shell/apps/*; do . "$f"; done


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
