#!/usr/bin/env bash

# We want the various sbins on the path along with /usr/local/bin
ADDPATH="/usr/local/sbin" \
    && [[ ! $PATH == *"$ADDPATH"* ]] && [ -d $ADDPATH ] && PATH="$PATH:$ADDPATH"
ADDPATH="/usr/sbin" \
    && [[ ! $PATH == *"$ADDPATH"* ]] && [ -d $ADDPATH ] && PATH="$PATH:$ADDPATH"
ADDPATH="/sbin" \
    && [[ ! $PATH == *"$ADDPATH"* ]] && [ -d $ADDPATH ] && PATH="$PATH:$ADDPATH"

# bin folder in dropbox for synced executables/scripts
ADDPATH="$HOME/Dropbox/bin" \
    && [[ ! $PATH == *"$ADDPATH"* ]] && [ -d $ADDPATH ] && PATH="$ADDPATH:$PATH"

# npm/yarn/node bin directories
ADDPATH="$NPM_PACKAGES/bin" \
    && [ ! -z "${NPM_PACKAGES}" ]&& [[ ! $PATH == *"$ADDPATH"* ]] && [ -d $ADDPATH ] && PATH="$ADDPATH:$PATH"
ADDPATH="$NPM_CONFIG_PREFIX/bin" \
    && [ ! -z "${NPM_CONFIG_PREFIX}" ] && [[ ! $PATH == *"$ADDPATH"* ]] && [ -d $ADDPATH ] && PATH="$ADDPATH:$PATH"
ADDPATH="$HOME/.yarn/bin" \
    && [[ ! $PATH == *"$ADDPATH"* ]] && [ -d $ADDPATH ] && PATH="$ADDPATH:$PATH"
ADDPATH="$HOME/.config/yarn/global/node_modules/.bin" \
    && [[ ! $PATH == *"$ADDPATH"* ]] && [ -d $ADDPATH ] && PATH="$ADDPATH:$PATH"

# macos user python site-packages support
ADDPATH="$HOME/Library/Python/2.7/bin" \
    && [[ ! $PATH == *"$ADDPATH"* ]] && [ -d $ADDPATH ] && PATH="$ADDPATH:$PATH"
ADDPATH="$HOME/Library/Python/3.5/bin" \
    && [[ ! $PATH == *"$ADDPATH"* ]] && [ -d $ADDPATH ] && PATH="$ADDPATH:$PATH"
ADDPATH="$HOME/Library/Python/3.6/bin" \
    && [[ ! $PATH == *"$ADDPATH"* ]] && [ -d $ADDPATH ] && PATH="$ADDPATH:$PATH"
ADDPATH="$HOME/Library/Python/3.7/bin" \
    && [[ ! $PATH == *"$ADDPATH"* ]] && [ -d $ADDPATH ] && PATH="$ADDPATH:$PATH"

# Rustup support
ADDPATH="$HOME/.cargo/bin" \
    && [[ ! $PATH == *"$ADDPATH"* ]] && [ -d $ADDPATH ] && PATH="$ADDPATH:$PATH"

# Go support
ADDPATH="$HOME/.go/bin" \
    && [[ ! $PATH == *"$ADDPATH"* ]] && [ -d $ADDPATH ] && PATH="$ADDPATH:$PATH"

# Linuxbrew, if we're using the local package manager
ADDPATH="$HOME/.linuxbrew/bin" \
    && [[ ! $PATH == *"$ADDPATH"* ]] && [ -d $ADDPATH ] && PATH="$ADDPATH:$PATH"
ADDPATH="/home/linuxbrew/.linuxbrew/bin" \
    && [[ ! $PATH == *"$ADDPATH"* ]] && [ -d $ADDPATH ] && PATH="$ADDPATH:$PATH"
ADDPATH="/home/linuxbrew/.linuxbrew/Homebrew/Library/Homebrew/vendor/portable-ruby/2.3.3/bin:" \
    && [[ ! $PATH == *"$ADDPATH"* ]] && [ -d $ADDPATH ] && PATH="$ADDPATH:$PATH"

# various local `bin` directories
ADDPATH="$HOME/bin" \
    && [[ ! $PATH == *"$ADDPATH"* ]] && [ -d $ADDPATH ] && PATH="$ADDPATH:$PATH"
ADDPATH="$HOME/.bin" \
    && [[ ! $PATH == *"$ADDPATH"* ]] && [ -d $ADDPATH ] && PATH="$ADDPATH:$PATH"
ADDPATH="$HOME/.local/bin" \
    && [[ ! $PATH == *"$ADDPATH"* ]] && [ -d $ADDPATH ] && PATH="$ADDPATH:$PATH"

# Final export
export PATH

# vim: syntax=sh ts=4 sts=4 shiftwidth=4 expandtab
