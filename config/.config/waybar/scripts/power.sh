#!/bin/bash

# Options
shutdown="⏻  Shutdown"
reboot="  Reboot"
lock="  Lock"

# Rofi prompt
chosen=$(echo -e "$lock\n$reboot\n$shutdown" | rofi -dmenu -i -p "Power" -theme ~/.config/rofi/power-menu.rasi)

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