#!/usr/bin/env /bin/bash

shopt -s expand_aliases

# Machine specific setup
if [ "$(uname)" == "Darwin" ]; then
    alias lnd="ln -sf"

    # If gnu ln is installed on MacOS, use that
    if [ -x "$(command -v gln)" ]; then
        unalias lnd
        alias lnd="gln -sfT"
    fi
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    alias lnd="ln -sfT"
fi

# Initial mkdir
mkdir -p $HOME/.bin

# Bash
ln -sf $(pwd)/bash/bash_profile $HOME/.profile
cp ./bash/scripts/rerun.sh $HOME/.bin/rerun && chmod +x $HOME/.bin/rerun

# ctags
lnd $(pwd)/ctags $HOME/.ctags.d

# Bash colorscheme
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell 2> /dev/null

# Node
ln -sf $(pwd)/node/npmrc $HOME/.npmrc
ln -sf $(pwd)/node/tern-project $HOME/.tern-project
ln -sf $(pwd)/node/eslintrc $HOME/.eslintrc
ln -sf $(pwd)/node/stylelintrc $HOME/.stylelintrc

# Tmux
if [ ! -d $HOME/.tmux/plugins ]; then
    mkdir -p $HOME/.tmux/plugins
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
ln -sf $(pwd)/tmux/tmux.conf $HOME/.tmux.conf
ln -sf $(pwd)/tmux/restartsession.sh $HOME/.tmux/restartsession.sh
ln -sf $(pwd)/tmux/choosesession.sh $HOME/.tmux/choosesession.sh

# Tmuxinator
lnd $(pwd)/tmuxinator $HOME/.tmuxinator

# Vim
mkdir -p $HOME/.vim
mkdir -p $HOME/.vim/tmp/undo $HOME/.vim/tmp/backup $HOME/.vim/tmp/swap
ln -sf $(pwd)/vim/vimrc $HOME/.vimrc
ln -sf $(pwd)/vim/UltiSnips $HOME/.vim/
ln -sf $(pwd)/vim/UltiSnips $HOME/.config/nvim/

# Neovim
mkdir -p $HOME/.config/nvim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -sf $(pwd)/nvim/init.vim $HOME/.config/nvim/init.vim
ln -sf $(pwd)/nvim/functions.vim $HOME/.config/nvim/functions.vim

# Editorconfig
ln -sf $(pwd)/editorconfig/editorconfig $HOME/.editorconfig

# Git
ln -sf $(pwd)/git/gitconfig $HOME/.gitconfig
ln -sf $(pwd)/git/gitignore_global $HOME/.gitignore_global

# Cleanup
unalias lnd
