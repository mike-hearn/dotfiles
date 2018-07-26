#!/usr/bin/env bash

source ~/.config/shell/bash/initial.sh
source ~/.config/shell/bash/prompt.sh

for f in ~/.config/shell/shared/*; do . "$f"; done
for f in ~/.config/shell/apps/*; do . "$f"; done

source ~/.config/shell/bash/final.sh

# vim: ts=4 sts=4 shiftwidth=4 expandtab


