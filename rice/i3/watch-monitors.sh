#!/usr/bin/env bash
# Re-applies the wallpaper and polybar whenever the set of connected
# monitors changes, no matter what triggered the change (arandr, the
# $mod+m autorandr binding, hotplug, ...). Polls instead of listening to
# X11 RandR events directly to keep this dependency-free.

pidfile="/tmp/watch-monitors.pid"
if [[ -f "$pidfile" ]] && kill -0 "$(cat "$pidfile")" 2>/dev/null; then
    kill "$(cat "$pidfile")"
fi
echo $$ > "$pidfile"

prev=""
while true; do
    current=$(xrandr --query | grep " connected")
    if [[ "$current" != "$prev" ]]; then
        if [[ -n "$prev" ]]; then
            $HOME/dotfiles/rice/i3/set-wallpaper.sh
            $HOME/.config/polybar/launch_polybars.sh
        fi
        prev="$current"
    fi
    sleep 3
done
