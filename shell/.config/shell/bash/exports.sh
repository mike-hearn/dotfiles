#!/usr/bin/env bash

# Bash history
export HISTFILESIZE=100000
export HISTSIZE=500000
export HISTIGNORE="&:[ ]*:exit:bg:fg:history:clear"  # Don't record some commands
export HISTTIMEFORMAT='%F %T '
export HISTCONTROL="erasedups:ignoreboth"
shopt -s histappend                     # append to history, don't overwrite it
shopt -s cmdhist
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
