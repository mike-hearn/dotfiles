#!/usr/bin/env zsh

if [[ -v VSCODE_IPC_HOOK_CLI ]]; then
	gitroot=$(basename $(git top) 2> /dev/null)
	mkdir -p ~/.config/vscode/

	if [[ -v gitroot ]]; then
		echo $(which code) > ~/.config/vscode/code_binary_location
		sed -i "/^$gitroot=/d" ~/.config/vscode/vscode_ipc_hook_map
		echo "$gitroot=$VSCODE_IPC_HOOK_CLI" >> ~/.config/vscode/vscode_ipc_hook_map
	fi
fi
