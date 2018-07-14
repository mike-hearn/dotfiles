#!/usr/bin/env bash

# Make vim the default editor.
set -o vi # Default editor is now VIM
export EDITOR=vim

# PAGER
if [ -n "$(command -v less)" ]; then
    PAGER="less -FirSwX"
    MANPAGER="less -FiRswX"
else
    PAGER=more
    MANPAGER="$PAGER"
fi
export PAGER MANPAGER

# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
export PYTHONIOENCODING='UTF-8';

# Bash history
export HISTFILESIZE=100000
export HISTSIZE=500000
export HISTIGNORE="&:[ ]*:exit:bg:fg:history:clear"  # Don't record some commands
export HISTTIMEFORMAT='%F %T '
export HISTCONTROL="erasedups:ignoreboth"
shopt -s histappend                     # append to history, don't overwrite it
shopt -s cmdhist
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# Prefer US English and use UTF-8, unless OSX, then C to fix sed
export LANG='en_US.UTF-8';
export LANGUAGE="en"
export LC_ALL='en_US.UTF-8';
export LC_CTYPE="en_US.UTF-8"

# always use PASSIVE mode ftp
export FTP_PASSIVE=1

# Highlight section titles in manual pages.
export LESS_TERMCAP_md="${yellow}";

# Don’t clear the screen after quitting a manual page.
export MANPAGER='less -X';

# Still NPM; unset manpath so we can inherit from /etc/manpath via the
# `manpath` command
unset MANPATH # delete if you already modified MANPATH elsewhere in your config
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

# ignore backups, CVS directories, python bytecode, vim swap files
export FIGNORE="~:CVS:#:.pyc:.swp:.swa:apache-solr-*"

# golang
export GOPATH=~/.go

# locales to fix sed

# vim: syntax=sh ts=4 sts=4 shiftwidth=4 expandtab
