unset ENV

# autoloads
autoload -Uz compinit; compinit

# exports
export LESS="-R --quit-if-one-screen"
export SHELL=/bin/zsh
export ZSH_CUSTOM="$HOME/.config/shell/zsh"
export ZSH="$HOME/.oh-my-zsh"

# function path
fpath=(
  "$ZSH_CUSTOM/functions"
  "$HOME/.zfunctions"
  "$fpath"
)

# oh-my-zsh plugins+source
plugins=(
  autojump
  conda
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

# Base16 shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
  [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
  eval "$("$BASE16_SHELL/profile_helper.sh")"

# FZF
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Spaceship prompt settings
eval "$(starship init zsh)"

# Direnv
eval "$(direnv hook zsh)"

# Autosource files
for f in ~/.config/shell/shared/*; do . "$f"; done
for f in ~/.config/shell/apps/*; do . "$f"; done
for f in ~/.config/shell/zsh/autosource/*sh; do . "$"; done
