#!/usr/bin/env /bin/bash

# Initial mkdir
mkdir -p $HOME/.bin
mkdir -p $HOME/.config
mkdir -p $HOME/.local
mkdir -p $HOME/.vim
mkdir -p $HOME/.terminfo/78/

# Initial stow
stow -t $HOME bin
stow -t $HOME base16
stow -t $HOME ctags
stow -t $HOME editorconfig
stow -t $HOME git
stow -t $HOME node
stow -t $HOME nvim
stow -t $HOME shell
stow -t $HOME terminfo
stow -t $HOME tmux
stow -t $HOME tmuxinator
stow -t $HOME vim
stow -t $HOME zsh

# Copy files
cp terminfo/.terminfo/x/xterm-kitty ~/.terminfo/78/
