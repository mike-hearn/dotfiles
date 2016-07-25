#!/usr/bin/env /bin/bash

# Vim
ln -sf $(pwd)/vim/vimrc $HOME/.vimrc

# Bash
ln -sf $(pwd)/bash/bash_aliases $HOME/.bash_aliases
ln -sf $(pwd)/bash/bash_profile $HOME/.profile

# Tmux
ln -sf $(pwd)/tmux/tmux.conf $HOME/.tmux.conf

