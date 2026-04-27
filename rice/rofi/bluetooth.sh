#!/usr/bin/env bash
# Bluetooth device selector — same style as powermenu (mod+p)
# ● connected   ○ available

theme="$HOME/.config/rofi/powermenu_style.rasi"
host=$(hostname)

scan_refresh="↻ Scan for devices"
scan_active="↻ Searching for devices…"

theme_overrides='
    listview { lines: 6; }
    mainbox  { children: [ "listview" ]; }
    element normal.active {
        background-color: @background-alt;
        text-color:       @foreground;
        border-radius:    10px;
    }
    element selected.active {
        background-color: @selected;
        text-color:       @background;
        border-radius:    10px;
    }
'

# Build device list with live connection status
menu_items=""
while IFS= read -r line; do
    mac=$(echo "$line" | awk '{print $2}')
    name=$(echo "$line" | cut -d' ' -f3-)
    connected=$(bluetoothctl info "$mac" 2>/dev/null | awk '/Connected:/ {print $2}')
    if [[ "$connected" == "yes" ]]; then
        menu_items+="● ${name}  [${mac}]\n"
    else
        menu_items+="○ ${name}  [${mac}]\n"
    fi
done < <(bluetoothctl devices Paired 2>/dev/null)

rofi_menu() {
    local top_entry="$1"
    echo -e "${top_entry}\n${menu_items%\\n}" | rofi -dmenu \
        -theme "$theme" \
        -theme-str "$theme_overrides" \
        -a 0 \
        -kb-custom-1 c \
        -kb-custom-2 d
}

chosen=$(rofi_menu "$scan_refresh")
rofi_exit=$?

[[ -z "$chosen" ]] && exit 0

# Scan: replace top entry with "Searching…", run discovery, reopen
if [[ "$chosen" == "$scan_refresh" ]]; then
    rofi_menu "$scan_active" &
    rofi_pid=$!

    echo -e "scan on\n"  | bluetoothctl > /dev/null 2>&1
    sleep 5
    echo -e "scan off\n" | bluetoothctl > /dev/null 2>&1

    kill "$rofi_pid" 2>/dev/null
    exec "$0"
fi

# Extract MAC from [XX:XX:XX:XX:XX:XX]
mac=$(echo "$chosen" | grep -oE '[0-9A-Fa-f:]{17}')
[[ -z "$mac" ]] && exit 1

# Extract device name (strip "● "/"○ " prefix and "  [MAC]" suffix)
name_with_icon=$(echo "$chosen" | sed 's/  \[.*\]$//')
name="${name_with_icon:2}"

do_connect() {
    notify-send "Bluetooth" "Connecting to ${name}…"
    result=$(echo -e "connect $mac\n" | bluetoothctl 2>&1)
    if echo "$result" | grep -q "successful"; then
        notify-send "Bluetooth" "Connected to ${name}"
    else
        notify-send -u critical "Bluetooth" "Failed to connect to ${name}"
    fi
}

do_disconnect() {
    echo -e "disconnect $mac\n" | bluetoothctl > /dev/null 2>&1 &
    notify-send "Bluetooth" "Disconnecting from ${name}…"
}

case $rofi_exit in
    10) do_connect ;;      # c
    11) do_disconnect ;;   # d
    *)                     # Enter — toggle
        connected=$(bluetoothctl info "$mac" 2>/dev/null | awk '/Connected:/ {print $2}')
        if [[ "$connected" == "yes" ]]; then do_disconnect; else do_connect; fi
        ;;
esac
