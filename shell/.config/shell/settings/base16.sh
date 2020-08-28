#!/usr/bin/env bash

BASE16_SHELL="$HOME/.config/base16-shell/"

function _load_base16 {
    [ -n "$PS1" ] && \
        [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        "$BASE16_SHELL/profile_helper.sh" | head -n 2 > ~/.base16_bootstrap
}

function base16_bootstrap {
    [ -n "$PS1" ] && \
        [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"
}

( _load_base16 & )

. ~/.base16_bootstrap

# vim: syntax=sh ts=4 sts=4 shiftwidth=4 expandtab

