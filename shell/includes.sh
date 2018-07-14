#!/usr/bin/env bash

# Autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
[ -f /etc/profile.d/autojump.sh ] && . /etc/profile.d/autojump.sh

# environment specific settings & secrets
[ -f $HOME/.bash_env ] && . $HOME/.bash_env
[ -f $HOME/.secrets ] && . $HOME/.secrets
[ -f /etc/profile.d/autojump.sh ] && . /etc/profile.d/autojump.sh

# FZF
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_CTRL_R_OPTS='--sort'
export FZF_DEFAULT_COMMAND='command rg --files'
_fzf_compgen_path() {
    command rg --files --no-ignore --hidden --color=never \
        --glob \!"*node_modules*" \
        --glob \!"*tmp*" \
        --glob \!"*bower_components*" \
        --glob \!"*venv*" \
        --glob \!"*.git" \
        --glob \!"*.pyc" \
        "$1"
}

# completions
[ -f $HOME/.git-completion.bash  ] && . $HOME/.git-completion.bash
[ -f /usr/local/etc/bash_completion  ] && . /usr/local/etc/bash_completion

# vim: syntax=sh ts=4 sts=4 shiftwidth=4 expandtab
