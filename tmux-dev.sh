#!/bin/sh
tmux new-session -d
tmux split-window -v -p 1 -c $PWD
tmux split-window -h -c $PWD

tmux -2 attach-session -d
