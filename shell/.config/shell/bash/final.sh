#!/usr/bin/env bash
#
# This file is executed last in the initialization sequence. Anything that
# needs to be executed after everything else should go here.

# Clear screen before every new command
boldwhite="\e[1;37m"
reset="\e[0m"
source bash-preexec.sh
preexec() { clear; printf "${boldwhite}$ $1\n\n${reset}"; }

# vim: syntax=sh ts=4 sts=4 shiftwidth=4 expandtab
