unset ENV

# exports
export LESS="-R --quit-if-one-screen"
export SHELL=/bin/zsh
export ZSH_CUSTOM="$HOME/.config/shell/zsh"
export ZSH="$HOME/.oh-my-zsh"

# function path
fpath+=(
  "$ZSH_CUSTOM/functions"
  "$HOME/.zfunctions"
  "$fpath"
)

# oh-my-zsh plugins+source
plugins=(
  autojump
  direnv
  django
  docker
  docker-compose
  fzf
  git
  npm
  nvmfast
  ssh-agent
  vi-mode
  yarn
)

source $ZSH/oh-my-zsh.sh

# Autosource files
for f in ~/.config/shell/shared/*; do . "$f"; done
for f in ~/.config/shell/settings/*; do . "$f"; done
for f in ~/.config/shell/zsh/autosource/*sh; do . "$f"; done

# Spaceship prompt settings
eval "$(starship init zsh)"
