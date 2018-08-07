#!/usr/bin/env bash

# Git
alias ga="git add "
alias gaa="git add --all"
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
alias gs=$'git -c color.ui=always status --short --branch | /bin/python -c \'import sys, re; \ order = {"A ":1," M":3,"??":2,"##":0}; ansi_re = re.compile(r"\x1b[^m]*m");\ print "".join(sorted(sys.stdin.readlines(),cmp=lambda x,y: \ cmp(order.get(ansi_re.sub("", x)[0:2],0), order.get(ansi_re.sub("", y)[0:2],0))))\''
alias gx="gitx --all"
alias pull="git pull"
alias recent="git for-each-ref --sort=-committerdate"
alias recentdate="git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname) %(committerdate) %(authorname)' | sed 's/refs\/heads\///g'"

# Read things aloud faster
alias say="say --voice=Daniel --rate=275"

# Quick commands
alias c='clear'
alias x='exit'

# Find external IP address
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"

# ls priority: exa, then gls, then ls
if [[ -n $(command -v exa) ]]; then
    alias ls="command exa -l --group-directories-first --git"
    alias la="command exa -la --group-directories-first --git"
else
    alias ls="command ls -la"
fi

# Default ripgrep settings
alias rg="rg --max-columns=1000 --smart-case"
