#!/usr/bin/env bash

# environment specific settings & secrets
[ -f $HOME/.bash_env ] && . $HOME/.bash_env
[ -f $HOME/.env ] && . $HOME/.env
[ -f $HOME/.secrets ] && . $HOME/.secrets
[ -f /etc/profile.d/autojump.sh ] && . /etc/profile.d/autojump.sh

# vim: syntax=sh ts=4 sts=4 shiftwidth=4 expandtab
