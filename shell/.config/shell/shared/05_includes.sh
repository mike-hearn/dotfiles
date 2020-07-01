#!/usr/bin/env bash

# environment specific settings & secrets
[ -f "$HOME"/.env ] && . "$HOME"/.env
[ -f "$HOME"/.shenv ] && . "$HOME"/.shenv
[ -f "$HOME"/.secrets ] && . "$HOME"/.secrets

# vim: syntax=sh ts=4 sts=4 shiftwidth=4 expandtab
