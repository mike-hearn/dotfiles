alias gs="git status "
alias ga="git add "
alias gaa="git add --all"
alias gb="git branch "
alias gc="git commit"
alias gd="git diff"
alias gf="git fetch --all"
alias gco="git checkout "
alias gk="gitk --all&"
alias gx="gitx --all"
alias got="git "
alias get="git "
alias gci="git ci"
alias gbr="git for-each-ref --sort=-committerdate refs/remotes/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'"
alias grb="git for-each-ref --sort=-committerdate refs/remotes/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'"
alias gps="git stash save --include-untracked; git pull; git stash pop;"
alias pull="git pull"
alias recent="git for-each-ref --sort=-committerdate"
alias recentdate="git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname) %(committerdate) %(authorname)' | sed 's/refs\/heads\///g'"
alias fix='$EDITOR `git diff --name-only | uniq`'