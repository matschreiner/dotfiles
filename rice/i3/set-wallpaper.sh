#!/usr/bin/env bash
# feh needs one image argument per connected monitor (in output order) to
# fill each one independently instead of stretching across the combined
# virtual screen. This repeats the wallpaper once per connected monitor.

wallpaper="$HOME/dotfiles/rice/images/pink-floyd-gruvbox-hd.jpg"
monitor_count=$(xrandr --query | grep -c " connected")

images=()
for ((i = 0; i < monitor_count; i++)); do
    images+=("$wallpaper")
done

feh --bg-fill "${images[@]}"
