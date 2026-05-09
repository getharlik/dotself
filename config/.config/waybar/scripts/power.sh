#!/bin/bash

# Options
reboot="󰜉    Reboot"
lock="󰍃    Lock"
shutdown="󰐥    Shutdown"

# Rofi prompt
chosen=$(echo -e "$shutdown\n$reboot\n$lock" | rofi -dmenu -i -p "Power" -theme ~/.config/rofi/power-menu.rasi)

case "$chosen" in
    "$shutdown")
        systemctl poweroff
        ;;
    "$reboot")
        systemctl reboot
        ;;
    "$lock")
        hyprlock
        ;;
esac