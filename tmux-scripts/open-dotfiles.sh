#!/usr/bin/env bash
set -euo pipefail
tmux new-window -n dev -c "$HOME/dotfiles" 'nvim -c "NvimTreeOpen"'
