#!/usr/bin/env /bin/bash

# Bash
ln -sf $(pwd)/bash/bash_aliases $HOME/.bash_aliases
ln -sf $(pwd)/bash/bash_profile $HOME/.profile

# Node
ln -sf $(pwd)/node/npmrc $HOME/.npmrc

# Tmux
ln -sf $(pwd)/tmux/tmux.conf $HOME/.tmux.conf

# Vim
ln -sf $(pwd)/vim/vimrc $HOME/.vimrc

# Git
ln -sf $(pwd)/git/gitconfig $HOME/.gitconfig
ln -sf $(pwd)/git/gitignore_global $HOME/.gitignore_global

