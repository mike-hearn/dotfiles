#!/usr/bin/env bash

BREW_PREFIX=$(brew --prefix 2> /dev/null || true)
TEMPORARY_PATH=""
PREPEND_ARRAY=()
APPEND_ARRAY=()

function _add_to_path {
    PATH_TO_BE_ADDED="$1"

    # If 'append', put it at the back
    if [ "$2" = "append" ]; then
        # PATH="$PATH:$PATH_TO_BE_ADDED"
        APPEND_ARRAY+=("$1")

    # Else, prepend it to $PATH
    else
        # PATH="$PATH_TO_BE_ADDED:$PATH"
        PREPEND_ARRAY+=("$1")
    fi

    return
}

# We want the various sbins on the path along with /usr/local/bin
_add_to_path "/usr/local/sbin" append
_add_to_path "/usr/sbin" append
_add_to_path "/sbin" append

# bin folder in dropbox for synced executables/scripts
_add_to_path "$HOME/Dropbox/bin"

# Linuxbrew, if we're using the local package manager
_add_to_path "$HOME/.linuxbrew/bin"
_add_to_path "/home/linuxbrew/.linuxbrew/bin"
_add_to_path "/home/linuxbrew/.linuxbrew/Homebrew/Library/Homebrew/vendor/portable-ruby/2.3.3/bin:"

# Various local `bin` directories
_add_to_path "$HOME/bin"
_add_to_path "$HOME/.bin"
_add_to_path "$HOME/.local/bin"

# nvidia cuda
_add_to_path "/usr/local/cuda/bin"

# npm/yarn/node bin directories
_add_to_path "$HOME/.yarn/bin"
_add_to_path "$HOME/.config/yarn/global/node_modules/.bin"
_add_to_path "$HOME/.nodenv/shims"

# Python site-packages support
_add_to_path "$HOME/Library/Python/2.7/bin"
_add_to_path "$HOME/Library/Python/3.5/bin"
_add_to_path "$HOME/Library/Python/3.6/bin"
_add_to_path "$HOME/Library/Python/3.7/bin"
_add_to_path "$HOME/.pyenv/shims"
_add_to_path "$HOME/.poetry/bin"

# Ruby env
_add_to_path "$HOME/.rbenv/shims"

# Rustup support
_add_to_path "$HOME/.cargo/bin"

# Go support
_add_to_path "$HOME/.go/bin"

for x in $PREPEND_ARRAY; do
  case ":$TEMPORARY_PATH:" in
    *":$x:"*) :;; # already there
    *) TEMPORARY_PATH="$x:$TEMPORARY_PATH";;
  esac
done

for x in $APPEND_ARRAY; do
  case ":$TEMPORARY_PATH:" in
    *":$x:"*) :;; # already there
    *) TEMPORARY_PATH="$TEMPORARY_PATH:$x";;
  esac
done

PATH="$TEMPORARY_PATH:$PATH"

# Final export
export PATH


# LD_LIBRARY_PATH -------------------------------------------------------------

ADDPATH="/usr/local/cuda/lib64" \
    && [[ ! $LD_LIBRARY_PATH == *"$ADDPATH"* ]] && [ -d $ADDPATH ] && LD_LIBRARY_PATH="$ADDPATH:$LD_LIBRARY_PATH"

# vim: syntax=sh ts=4 sts=4 shiftwidth=4 expandtab
