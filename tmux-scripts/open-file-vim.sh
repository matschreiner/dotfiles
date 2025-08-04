#!/bin/bash

line=$(xclip -selection clipboard -o)


if [[ "$line" =~ File\ \"([^\"]+)\"\,\ line\ ([0-9]+) ]]; then
    filepath="${BASH_REMATCH[1]}"
    lineno="${BASH_REMATCH[2]}"

    tmux send-keys -t 0 Escape

    tmux send-keys -t 0 C-r
    tmux send-keys -t 0 C-r
    tmux send-keys -t 0 C-r
    tmux send-keys -t 0 C-r
    tmux send-keys -t 0 C-r

    tmux send-keys -t 0 ":set splitright"
    tmux send-keys -t 0 Enter
    tmux send-keys -t 0 ":vsplit +$lineno $filepath"
    tmux send-keys -t 0 Enter
    tmux select-pane -t 0

else
    echo "Not a StackTrace"
fi
