#!/bin/sh

function activate_venv () {
	if [[ -d ./.venv ]]
	then
		tmux send-keys 'source .venv/bin/activate' Enter
	fi
}


if [[ -s $1 ]]
then
	cd $1
fi

tmux send-keys nvim Enter Enter \; send-keys C-n \; send-keys C-l

tmux split-window -v
activate_venv

tmux resize-pane -y 18
tmux split-window -h
activate_venv


