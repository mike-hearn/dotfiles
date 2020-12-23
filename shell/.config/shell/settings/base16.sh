#!/usr/bin/env bash

BASE16_SHELL="$HOME/.config/base16-shell/"

function base16_bootstrap {
    [ -n "$PS1" ] && \
        [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"
}

function _load_base16 {
    base16_bootstrap > ~/.base16_bootstrap
}


base16_bootstrap

# vim: syntax=sh ts=4 sts=4 shiftwidth=4 expandtab

