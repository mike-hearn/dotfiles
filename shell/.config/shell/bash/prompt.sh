#!/usr/bin/env bash

# Two-line, full-width prompt based on:
# https://gist.github.com/mkottman/1936195

source git-prompt.sh

# Create horizontal line to fill bash prompt

# Find and print the active virtual environment
function virtualenv_info(){
    if [[ -n "$VIRTUAL_ENV" ]]; then
        # Strip out the path and just leave the env name
        venv="${VIRTUAL_ENV##*/}"
    else
        # In case you don't have one activated
        venv=''
    fi
    [[ -n "$venv" ]] && printf "\n[environment: $venv] "
}

if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
    export TERM='gnome-256color';
elif infocmp xterm-256color >/dev/null 2>&1; then
    export TERM='xterm-256color';
fi;

# True color codes
if tput setaf 1 &> /dev/null; then
	tput sgr0; # reset colors
	bold=$(tput bold);
	reset=$(tput sgr0);
	black=$(tput setaf 0);
	blue=$(tput setaf 33);
	cyan=$(tput setaf 37);
	green=$(tput setaf 30);
	orange=$(tput setaf 202);
	purple=$(tput setaf 125);
	red=$(tput setaf 124);
	violet=$(tput setaf 61);
	white=$(tput setaf 15);
	yellow=$(tput setaf 220);
fi

# Color codes
base_reset="\[\e[0m\]";
base_black="\[\e[1;30m\]";
base_red="\[\e[1;31m\]";
base_green="\[\e[1;32m\]";
base_yellow="\[\e[1;33m\]";
base_blue="\[\e[1;34m\]";
base_purple="\[\e[1;35m\]";
base_cyan="\[\e[1;36m\]";
base_white="\[\e[1;37m\]";
base_darkgray="\[\e[90m\]";

# Highlight the user name when logged in as root.
if [[ "${USER}" == "root" ]]; then
	userStyle="${base_red}";
else
	userStyle="${base_yellow}";
fi;

# Highlight the hostname when connected via SSH.
if [[ "${SSH_TTY}" ]]; then
	hostStyle="${base_red}";
else
	hostStyle="${base_yellow}";
fi;



# Prompt variables
VENV="\$(virtualenv_info)";
PROMPT_BEFORE+="${VENV} ";
PROMPT_BEFORE+="\n"; # newline
PROMPT_BEFORE+="${base_darkgray}\${PS_FILL}\[\033[0G\]${base_purple}\u"; # username
PROMPT_BEFORE+="${base_white}@";
PROMPT_BEFORE+="${hostStyle}\h"; # host
PROMPT_BEFORE+="${base_white}:";
PROMPT_BEFORE+="${base_blue}\w"; # working directory full path
PROMPT_AFTER="\n${base_reset}\$ "
PROMPT_FORMAT=" ${base_white}on %s   "; # working directory full path

# Prompt command
PROMPT_COMMAND='__git_ps1 "$PROMPT_BEFORE" "$PROMPT_AFTER" "$PROMPT_FORMAT";'

# Git prompt features (read ~/.git-prompt.sh for reference)
export GIT_PS1_SHOWDIRTYSTATE="true"
export GIT_PS1_SHOWSTASHSTATE="true"
export GIT_PS1_SHOWUNTRACKEDFILES="true"
export GIT_PS1_SHOWUPSTREAM="auto"
export GIT_PS1_SHOWCOLORHINTS="true"
export VIRTUAL_ENV_DISABLE_PROMPT=1 # disable the default virtualenv prompt

PS2="\[${base_yellow}\]→ \[${base_reset}\]";
export PS2;

