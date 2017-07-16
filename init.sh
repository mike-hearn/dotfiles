#!/usr/bin/env /bin/bash

# Bash
ln -sf $(pwd)/bash/bash_profile $HOME/.profile

# Node
ln -sf $(pwd)/node/npmrc $HOME/.npmrc
ln -sf $(pwd)/node/tern-project $HOME/.tern-project
ln -sf $(pwd)/node/eslintrc $HOME/.eslintrc
ln -sf $(pwd)/node/stylelintrc $HOME/.stylelintrc

# Tmux
if [ ! -d $HOME/.tmux/plugins ]; then
    mkdir -p $HOME/.tmux/plugins
    ln -sf $(pwd)/tmux/tmux.conf $HOME/.tmux.conf
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Vim
mkdir -p $HOME/.vim
ln -sf $(pwd)/vim/vimrc $HOME/.vimrc
ln -sf $(pwd)/vim/UltiSnips $HOME/.vim/
ln -sf $(pwd)/vim/UltiSnips $HOME/.config/nvim/

# Neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -sf $(pwd)/nvim/init.vim $HOME/.config/nvim/init.vim

# Editorconfig
ln -sf $(pwd)/editorconfig/editorconfig $HOME/.editorconfig

# Git
ln -sf $(pwd)/git/gitconfig $HOME/.gitconfig
ln -sf $(pwd)/git/gitignore_global $HOME/.gitignore_global

