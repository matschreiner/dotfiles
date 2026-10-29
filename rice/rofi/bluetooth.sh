#!/usr/bin/env bash
# Bluetooth device selector — same style as powermenu (mod+p)
# ● connected   ○ available

theme="$HOME/.config/rofi/powermenu_style.rasi"
host=$(hostname)

scan_refresh="↻ Scan for devices"
scan_active="↻ Searching for devices…"

power_on_label="⏻ Turn Bluetooth off"
power_off_label="⏻ Turn Bluetooth on"

bt_powered_on() {
    [[ "$(bluetoothctl show 2>/dev/null | awk '/Powered:/ {print $2}')" == "yes" ]]
}

theme_overrides='
    listview { lines: 7; }
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

build_menu_items() {
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
}

rofi_menu() {
    local top_entries="$1"
    local items="${menu_items%\\n}"
    local full_list="$top_entries"
    [[ -n "$items" ]] && full_list+="\n${items}"
    echo -e "$full_list" | rofi -dmenu \
        -theme "$theme" \
        -theme-str "$theme_overrides" \
        -a 0 \
        -kb-custom-1 c \
        -kb-custom-2 d \
        -kb-custom-3 q
}

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

while true; do
    if bt_powered_on; then
        power_label="$power_on_label"
        build_menu_items
        chosen=$(rofi_menu "${power_label}\n${scan_refresh}")
    else
        power_label="$power_off_label"
        menu_items=""
        chosen=$(rofi_menu "${power_label}")
    fi
    rofi_exit=$?

    [[ -z "$chosen" ]] && break

    if [[ "$chosen" == "$power_on_label" || "$chosen" == "$power_off_label" ]]; then
        if bt_powered_on; then
            bluetoothctl power off > /dev/null 2>&1
            notify-send "Bluetooth" "Bluetooth desactivado"
        else
            bluetoothctl power on > /dev/null 2>&1
            notify-send "Bluetooth" "Bluetooth activado"
        fi
        continue
    fi

    if [[ "$chosen" == "$scan_refresh" ]]; then
        rofi_menu "${power_label}\n${scan_active}" &
        rofi_pid=$!
        echo -e "scan on\n"  | bluetoothctl > /dev/null 2>&1
        sleep 5
        echo -e "scan off\n" | bluetoothctl > /dev/null 2>&1
        kill "$rofi_pid" 2>/dev/null
        continue
    fi

    mac=$(echo "$chosen" | grep -oE '[0-9A-Fa-f:]{17}')
    [[ -z "$mac" ]] && break

    name_with_icon=$(echo "$chosen" | sed 's/  \[.*\]$//')
    name="${name_with_icon:2}"

    case $rofi_exit in
        10) do_connect    ;;   # c
        11) do_disconnect ;;   # d
        12) break         ;;   # q
        *)
            connected=$(bluetoothctl info "$mac" 2>/dev/null | awk '/Connected:/ {print $2}')
            if [[ "$connected" == "yes" ]]; then do_disconnect; else do_connect; fi
            ;;
    esac
done
