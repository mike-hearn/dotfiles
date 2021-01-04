#!/bin/bash

[[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf-tmux --exit-0) &&  tmux $change -t "$session" || exit 0
