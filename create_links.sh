#!/usr/bin/env /bin/bash

# Vim
ln -sF $(pwd)/vim/vimrc $HOME/.vimrc

# Bash
ln -sF $(pwd)/bash/bash_aliases $HOME/.bash_aliases
ln -sF $(pwd)/bash/bash_profile $HOME/.profile

# Tmux
ln -sF $(pwd)/tmux/tmux.conf $HOME/.tmux.conf

