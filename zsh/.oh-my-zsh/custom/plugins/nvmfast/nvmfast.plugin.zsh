autoload -U add-zsh-hook

load-nvmrc() {
  if [[ -f .nvmrc ]] && type 'nvm' 2> /dev/null | grep -q 'not found'; then
    unset NPM_CONFIG_PREFIX &> /dev/null
    export NVM_DIR="$HOME/.nvm"
    . "$NVM_DIR"/nvm.sh
    [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
    nvm use &> /dev/null
  fi
}

force-load-nvmrc() {
  unset NPM_CONFIG_PREFIX &> /dev/null
  export NVM_DIR="$HOME/.nvm"
  . "$NVM_DIR"/nvm.sh
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
  nvm use &> /dev/null
}

add-zsh-hook chpwd  load-nvmrc
add-zsh-hook precmd load-nvmrc
