#!/bin/bash

CURRENT_WALL="$HOME/.cache/current_wallpaper"

if [ -f "$CURRENT_WALL" ]; then
    wallpaper=$(cat "$CURRENT_WALL")

    if [ -f "$wallpaper" ]; then
        for i in $(seq 1 50); do
            hyprctl hyprpaper listactive &>/dev/null && break
            sleep 0.2
        done

        monitors=$(hyprctl monitors -j | jq -r '.[].name')
        for monitor in $monitors; do
            hyprctl hyprpaper wallpaper "$monitor,$wallpaper"
        done

        wal --theme hysteria -n -q
    fi
fi
