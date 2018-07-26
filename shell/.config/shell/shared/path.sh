#!/usr/bin/env bash

# We want the various sbins on the path along with /usr/local/bin
[ -d "/usr/local/sbin" ] && PATH="$PATH:/usr/local/sbin"
[ -d "/usr/sbin" ] && PATH="$PATH:/usr/sbin"
[ -d "/sbin" ] && PATH="$PATH:/sbin"

# bin folder in dropbox for synced executables/scripts
[ -d "$HOME/Dropbox/bin" ] && PATH="$HOME/Dropbox/bin:$PATH"

# npm/yarn/node bin directories
[ -d "$NPM_PACKAGES/bin" ] && [ ! -z "${NPM_PACKAGES}" ] && PATH="$NPM_PACKAGES/bin:$PATH"
[ -d "$NPM_CONFIG_PREFIX" ] && PATH="$NPM_CONFIG_PREFIX:$PATH"
[ -d "$HOME/.yarn/bin" ] && PATH="$HOME/.yarn/bin:$PATH"
[ -d "$HOME/.config/yarn/global/node_modules/.bin" ] && PATH="$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# macos user python site-packages support
[ -d "$HOME/Library/Python/2.7/bin" ] && PATH="$HOME/Library/Python/2.7/bin:$PATH"
[ -d "$HOME/Library/Python/3.5/bin" ] && PATH="$HOME/Library/Python/3.5/bin:$PATH"
[ -d "$HOME/Library/Python/3.6/bin" ] && PATH="$HOME/Library/Python/3.6/bin:$PATH"

# Rustup support
[ -d "$HOME/.cargo/bin" ] && PATH="$HOME/.cargo/bin:$PATH"

# Go support
[ -d "$HOME/.go/bin" ] && PATH="$HOME/.go/bin:$PATH"

# Linuxbrew, if we're using the local package manager
[ -d "$HOME/.linuxbrew/bin" ] && PATH="$HOME/.linuxbrew/bin:$PATH"
[ -d "/home/linuxbrew/.linuxbrew/bin" ] && PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
[ -d "/home/linuxbrew/.linuxbrew/Homebrew/Library/Homebrew/vendor/portable-ruby/2.3.3/bin:" ] && PATH="/home/linuxbrew/.linuxbrew/Homebrew/Library/Homebrew/vendor/portable-ruby/2.3.3/bin:$PATH"

# various local `bin` directories
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"
[ -d "$HOME/.bin" ] && PATH="$HOME/.bin:$PATH"
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"

# Final export
export PATH

# vim: syntax=sh ts=4 sts=4 shiftwidth=4 expandtab
