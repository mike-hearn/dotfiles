#!/usr/bin/env bash

# Make vim the default editor.
set -o vi # Default editor is now VIM
export EDITOR=nvim

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

# Prefer US English and use UTF-8, unless OSX, then C to fix sed
export LANG='en_US.UTF-8';
export LANGUAGE="en"
export LC_ALL='en_US.UTF-8';
export LC_CTYPE="en_US.UTF-8"

# golang
export GOPATH=~/.go

# npm global path to allow global packages w/o sudo
export NPM_CONFIG_PREFIX=~/.npm-global

# vim: syntax=sh ts=4 sts=4 shiftwidth=4 expandtab
