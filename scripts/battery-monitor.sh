#!/bin/bash
# Battery monitor — sends a critical notification at <= 10% while discharging.
# Uses a lockfile so exec_always in i3 doesn't spawn duplicate instances.

LOCKFILE="/tmp/battery-monitor.lock"
BATTERY_PATH="/org/freedesktop/UPower/devices/battery_BAT0"

# Exit if already running
if [ -f "$LOCKFILE" ] && kill -0 "$(cat "$LOCKFILE")" 2>/dev/null; then
    exit 0
fi
echo $$ > "$LOCKFILE"
trap 'rm -f "$LOCKFILE"' EXIT

notified_10=false
notified_5=false

while true; do
    info=$(upower -i "$BATTERY_PATH" 2>/dev/null)
    percentage=$(echo "$info" | awk '/percentage:/ {gsub(/%/, "", $2); print $2}')
    state=$(echo "$info" | awk '/state:/ {print $2}')

    if [[ "$state" == "discharging" && "$percentage" =~ ^[0-9]+$ ]]; then
        if (( percentage <= 5 )) && [[ "$notified_5" == "false" ]]; then
            notify-send -u critical "Critical Battery" "Battery at ${percentage}% — plug in now!"
            notified_5=true
            notified_10=true
        elif (( percentage <= 10 )) && [[ "$notified_10" == "false" ]]; then
            notify-send -u critical "Low Battery" "Battery at ${percentage}% — connect charger soon."
            notified_10=true
        fi
    else
        # Reset flags when charging or above threshold
        if (( percentage > 10 )); then
            notified_10=false
            notified_5=false
        fi
    fi

    sleep 60
done
