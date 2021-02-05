#!/bin/sh
tmux new-session -d
tmux split-window -v -p 1
tmux split-window -h

tmux -2 attach-session -d
