#!/usr/bin/env bash

# Git
alias ga="git add " alias gaa="git add --all"
alias gb="git branch "
alias gbr="git for-each-ref --sort=-committerdate refs/remotes/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'"
alias gc="git commit"
alias gci="git ci"
alias gco="git checkout "
alias gd="git diff"
alias get="git "
alias gf="git fetch --all"
alias gk="gitk --all&"
alias got="git "
alias gps="git stash save --include-untracked; git pull; git stash pop;"
alias grb="git for-each-ref --sort=-committerdate refs/remotes/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'"
alias gs="echo;echo;git status -s;echo;"
alias gx="gitx --all"
alias pull="git pull"
alias recent="git for-each-ref --sort=-committerdate"
alias recentdate="git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname) %(committerdate) %(authorname)' | sed 's/refs\/heads\///g'"
alias lg="lazygit"

# Read things aloud faster
alias say="say --voice=Daniel --rate=275"

# Quick commands
alias c='clear'
alias x='exit'

# Find external IP address
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
# ls priority: exa, then gls, then ls
if [ -x "$(command -v exa)" ]; then
    alias ls="command exa -l --group-directories-first --git"
    alias la="command exa -la --group-directories-first --git"
    alias l="command exa -la --group-directories-first --git"
else
    alias ls="command ls -la"
fi

# Default ripgrep settings
alias rg="rg --max-columns=1000 --smart-case"

# autojump key now uses z, in case I can't fix my muscle memory
alias j="z"

# move the system bin path to the front of $PATH
alias systembin="export PATH=/usr/bin:$PATH"
