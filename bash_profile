#!/bin/bash
# A basically sane bash environment.
#
# Mike Hearn, originally copied from Ryan Tomayko
# (https://github.com/rtomayko/dotfiles - original hash: cc190d71)

# the basics
: ${HOME=~}
: ${LOGNAME=$(id -un)}
: ${UNAME=$(uname)}

# complete hostnames from this file
: ${HOSTFILE=~/.ssh/known_hosts}

# readline config
: ${INPUTRC=~/.inputrc}

# ----------------------------------------------------------------------
#  SHELL OPTIONS
# ----------------------------------------------------------------------

# bring in system bashrc
if [ -r /etc/bashrc ]; then
    . /etc/bashrc
fi
if [ -r /etc/profile ]; then
    . /etc/profile
fi

# notify of bg job completion immediately
set -o notify

# shell opts. see bash(1) for details
shopt -s cdspell                 >/dev/null 2>&1
shopt -s extglob                 >/dev/null 2>&1
shopt -s histappend              >/dev/null 2>&1
shopt -s hostcomplete            >/dev/null 2>&1
shopt -s interactive_comments    >/dev/null 2>&1
shopt -u mailwarn                >/dev/null 2>&1
shopt -s no_empty_cmd_completion >/dev/null 2>&1

# fuck that you have new mail shit
unset MAILCHECK

# disable core dumps
ulimit -S -c 0

# default umask
umask 0022

# ----------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# ----------------------------------------------------------------------
NPM_PACKAGES="${HOME}/.npm-packages"

# ----------------------------------------------------------------------
# PATH
# ----------------------------------------------------------------------

# we want the various sbins on the path along with /usr/local/bin
PATH="$PATH:/usr/local/sbin:/usr/sbin:/sbin"
PATH="${HOME}/Dropbox/bin:$PATH"
PATH="$NPM_PACKAGES/bin:$PATH"
PATH="/usr/local/bin:$PATH"

# Unset manpath so we can inherit from /etc/manpath via the `manpath` command
unset MANPATH # delete if you already modified MANPATH elsewhere in your config
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

# put ~/bin first on PATH
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi

# ----------------------------------------------------------------------
# ENVIRONMENT CONFIGURATION
# ----------------------------------------------------------------------

# detect interactive shell
case "$-" in
    *i*) INTERACTIVE=yes ;;
    *)   unset INTERACTIVE ;;
esac

# detect login shell
case "$0" in
    -*) LOGIN=yes ;;
    *)  unset LOGIN ;;
esac

# enable en_US locale w/ utf-8 encodings if not already configured
: ${LANG:="en_US.UTF-8"}
: ${LANGUAGE:="en"}
: ${LC_CTYPE:="en_US.UTF-8"}
: ${LC_ALL:="en_US.UTF-8"}
export LANG LANGUAGE LC_CTYPE LC_ALL

# always use PASSIVE mode ftp
: ${FTP_PASSIVE:=1}
export FTP_PASSIVE

# ignore backups, CVS directories, python bytecode, vim swap files
FIGNORE="~:CVS:#:.pyc:.swp:.swa:apache-solr-*"

# history stuff
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"  # Don't record some commands
export HISTTIMEFORMAT='%F %T '
export HISTCONTROL="erasedups:ignoreboth"
export HISTFILESIZE=100000
export HISTSIZE=500000
shopt -s histappend                     # append to history, don't overwrite it
shopt -s cmdhist
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"


# ----------------------------------------------------------------------
# PAGER / EDITOR
# ----------------------------------------------------------------------

# See what we have to work with ...
HAVE_VIM=$(command -v vim)
HAVE_GVIM=$(command -v gvim)

# EDITOR
set -o vi # Default editor is now VIM
if [ -n "$HAVE_VIM" ]; then
    EDITOR=vim
else
    EDITOR=vi
fi
export EDITOR

# PAGER
if [ -n "$(command -v less)" ]; then
    PAGER="less -FirSwX"
    MANPAGER="less -FiRswX"
else
    PAGER=more
    MANPAGER="$PAGER"
fi
export PAGER MANPAGER

# ACK
ACK_PAGER="$PAGER"
ACK_PAGER_COLOR="$PAGER"

# ----------------------------------------------------------------------
# PROMPT
# ----------------------------------------------------------------------

RED="\[\033[0;31m\]"
BROWN="\[\033[0;33m\]"
GREY="\[\033[0;97m\]"
BLUE="\[\033[0;34m\]"
PS_CLEAR="\[\033[0m\]"
SCREEN_ESC="\[\033k\033\134\]"

if [ "$LOGNAME" = "root" ]; then
    COLOR1="${RED}"
    COLOR2="${BROWN}"
    P="#"
elif hostname | grep -q '\.github\.'; then
    GITHUB=true
    COLOR1="\[\e[0;94m\]"
    COLOR2="\[\e[0;92m\]"
    P="\$"
else
    COLOR1="${BLUE}"
    COLOR2="${BROWN}"
    P="\$"
fi

prompt_simple() {
    PS1="[\u@\h:\w]\$ "
    PS2="> "
}

prompt_compact() {
    PS1="${COLOR1}${P}${PS_CLEAR} "
    PS2="> "
}

prompt_color() {
    PS1="${GREY}[${COLOR1}\u${GREY}@${COLOR2}\h${GREY}:${COLOR1}\W${GREY}]${COLOR2}$P${PS_CLEAR} "
    PS2="> "
}

prompt_full() {
    PS1="\n${GREY}[${COLOR1}\u${GREY}@${COLOR2}\h${GREY}:${COLOR1}\w${GREY}]\n${GREY}$P${PS_CLEAR} "
    PS2="> "
}

# ----------------------------------------------------------------------
# MACOS X / DARWIN SPECIFIC
# ----------------------------------------------------------------------

if [ "$UNAME" = Darwin ]; then
    # setup java environment. puke.
    export JAVA_HOME="/System/Library/Frameworks/JavaVM.framework/Home"

    # Homebrew bash completion
    # export BASH_COMPLETION_DIR=$HOME/.bash_completion
    # if [ -f `brew --prefix`/etc/bash_completion ]; then
        # . `brew --prefix`/etc/bash_completion
    # fi
fi

# ----------------------------------------------------------------------
# BASH COMPLETION
# ----------------------------------------------------------------------

# if [ -z "$BASH_COMPLETION" ]; then
    # bash=${BASH_VERSION%.*}; bmajor=${bash%.*}; bminor=${bash#*.}
    # if [ -n "$PS1" -a "$bmajor" -gt 1 ]; then
        # # search for a bash_completion file to source
        # for f in ~/.bash_completion{,.d}/*; do
            # if [ -f $f ]; then
                # source $f
            # fi
        # done
    # fi
    # unset bash bmajor bminor
# fi

# override and disable tilde expansion
_expand() {
    return 0
}

# ----------------------------------------------------------------------
# LS AND DIRCOLORS
# ----------------------------------------------------------------------

# we always pass these to ls(1)
LS_COMMON="-hBGl"

if [ "$(uname)" == "Linux" ]; then
    LS_COMMON="$LS_COMMON -F --color --show-control-chars"
fi

# if the dircolors utility is available, set that up to
dircolors="$(type -P gdircolors dircolors | head -1)"
if [ -n "$dircolors" ]; then
    COLORS=/etc/DIR_COLORS
    test -e "/etc/DIR_COLORS.$TERM"   && COLORS="/etc/DIR_COLORS.$TERM"
    test -e "$HOME/.dircolors"        && COLORS="$HOME/.dircolors"
    test ! -e "$COLORS"               && COLORS=
    eval `$dircolors --sh $COLORS`
fi
unset dircolors

# setup the main ls alias if we've established common args
if [ -n "$LS_COMMON" ]; then
    alias ls="command ls $LS_COMMON"
fi

# these use the ls aliases above
alias ll="ls -l"
alias la="ls -la"

# -------------------------------------------------------------------
# ALIASES
# -------------------------------------------------------------------

# Git
alias gs="git status "
alias ga="git add "
alias gaa="git add --all"
alias gb="git branch "
alias gc="git commit"
alias gd="git diff"
alias gco="git checkout "
alias gk="gitk --all&"
alias gx="gitx --all"
alias got="git "
alias get="git "
alias gci="git ci"
alias gbr="git for-each-ref --sort=committerdate refs/remotes/ --format=%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))"
alias grb="git for-each-ref --sort=committerdate refs/remotes/ --format=%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))"
alias recent="git for-each-ref --sort=-committerdate"
alias recentdate="git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname) %(committerdate) %(authorname)' | sed 's/refs\/heads\///g'"
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# Docker
alias compose="command docker-compose"
alias machine="command docker-machine"
alias swarm="command docker-swarm"

# Read things aloud faster
alias say="say --voice=Daniel --rate=275"

# Quick clear
alias c='clear'

# Import additional alises
if [ -r ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# -------------------------------------------------------------------
# USER SHELL ENVIRONMENT
# -------------------------------------------------------------------

# ~/.shenv is used as a machine specific ~/.bashrc
if [ -r ~/.config/bash/bash_env.sh ]; then
    . ~/.config/bash/bash_env.sh
fi

# Use the color prompt by default when interactive
if [ -n "$PS1" ]; then
    prompt_full
fi

# Load those secrets, if they exist
if [ -e $HOME/.secrets ]; then source $HOME/.secrets; fi

# -------------------------------------------------------------------
# MOTD / FORTUNE
# -------------------------------------------------------------------

if [ -n "$INTERACTIVE" -a -n "$LOGIN" ]; then
    uname -npsr
    uptime
fi

# beep
alias beep='tput bel'

# vim: ts=4 sts=4 shiftwidth=4 expandtab

