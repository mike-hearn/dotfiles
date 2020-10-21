#!/bin/bash

TMUXINATORSESSIONS=$(\ls ~/.tmuxinator/ | sed -e 's/\.yml$//')

function restart_session() {
	read session

	# Run if session is not empty to avoid killing the current sesh
	if [ ! -z "$session" ]; then
		currentsession=$(tmux display-message -p '#S')
		lastsession=$(tmux display-message -p '#{client_last_session}')
		sessiontoberestarted=$(echo $session | sed -e 's/[-_ ]/-/')

		if [ "$session" == "$currentsession" ]; then
			tmux switch-client -t "$lastsession"
			tmuxinator stop $sessiontoberestarted
			tmuxinator $sessiontoberestarted
		else
			tmuxinator stop $sessiontoberestarted
			tmuxinator $sessiontoberestarted
			tmux switch-client -t "$lastsession"
			tmux switch-client -t "$currentsession"
		fi

		# tmux rename-session -t "$session" sessiontobekilled
		# tmuxinator $(echo $session | sed -e 's/[-_ ]/-/')
		# tmux kill-session -t sessiontobekilled

		# tmux switch-client -t "$lastsession"
		# tmux switch-client -t "$currentsession"
		tmux switch-client
	fi
}

cat <(echo "$TMUXINATORSESSIONS") \
	| sort -rfu \
	| ~/.fzf/bin/fzf-tmux \
	| tr -d '\n' \
	| restart_session
