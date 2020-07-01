#!/usr/bin/env bash

# Base16 shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
  [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
  eval "$("$BASE16_SHELL/profile_helper.sh")"

# vim: syntax=sh ts=4 sts=4 shiftwidth=4 expandtab

