unset ENV

export SHELL=/bin/zsh
export ZSH_CUSTOM="$HOME/.config/shell/zsh"
export ZSH="$HOME/.oh-my-zsh"

fpath=( "$ZSH_CUSTOM/functions" $fpath )

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
fpath=( "$HOME/.zfunctions" ""  "${fpath[@]}" )

# Spaceship prompt settings
eval "$(starship init zsh)"

# Autosource files from ~/.config/shell/zsh/autosource dir
for file in ~/.config/shell/zsh/autosource/*sh; do
  source "$file"
done

eval "$(direnv hook zsh)"
fpath=($fpath "/home/mikehearn/.zfunctions")

  # Set Spaceship ZSH as a prompt
  autoload -U promptinit; promptinit
  prompt spaceship
