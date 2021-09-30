#/bin/bash

file=$(pbpaste)


tmux send-keys -t 0 ":vsplit $file"
tmux send-keys -t 0 Enter

