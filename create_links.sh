#!/usr/bin/env /bin/bash

# Bash
ln -sf $(pwd)/bash/bash_aliases $HOME/.bash_aliases
ln -sf $(pwd)/bash/bash_profile $HOME/.profile

# Node
ln -sf $(pwd)/node/npmrc $HOME/.npmrc
ln -sf $(pwd)/node/tern-project $HOME/.tern-project
ln -sf $(pwd)/node/eslintrc $HOME/.eslintrc
ln -sf $(pwd)/node/stylelintrc $HOME/.stylelintrc

# Tmux
ln -sf $(pwd)/tmux/tmux.conf $HOME/.tmux.conf

# Vim
mkdir -p $HOME/.vim
ln -sf $(pwd)/vim/vimrc $HOME/.vimrc
ln -sf $(pwd)/vim/UltiSnips $HOME/.vim/

# Git
ln -sf $(pwd)/git/gitconfig $HOME/.gitconfig
ln -sf $(pwd)/git/gitignore_global $HOME/.gitignore_global

