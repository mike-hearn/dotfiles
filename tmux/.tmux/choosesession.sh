#!/bin/bash

TMUXSESSIONS=$(tmux list-sessions -F "#{session_name}")
TMUXINATORSESSIONS=$(\ls ~/.tmuxinator/ | sed -e 's/\.yml$//' | sed -e 's/[ -_]/-/g')

function tmux_switch_to_session() {
	read session

	if   [[ $TMUXSESSIONS =~ .*$session.* ]]; then
		tmux switch-client -t "$session"
	elif [[ $TMUXINATORSESSIONS =~ .*$session.* ]]; then
		tmuxinator $(echo $session | sed -e 's/[-_ ]/-/')
	fi
}

cat <(echo "$TMUXSESSIONS") <(echo "$TMUXINATORSESSIONS") \
	| sort -rfu \
	| fzf-tmux \
	| tr -d '\n' \
	| tmux_switch_to_session
