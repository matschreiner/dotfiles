#!/bin/sh
tmux new-session -d
tmux send-keys 'source .venv/bin/activate' C-m
tmux send-keys 'vim' C-m

tmux split-window -v -p 20
tmux send-keys 'source .venv/bin/activate' C-m

tmux split-window -h
tmux send-keys 'source .venv/bin/activate' C-m

tmux -2 attach-session -d
