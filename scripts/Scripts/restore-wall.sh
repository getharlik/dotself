#!/bin/bash

CURRENT_WALL="$HOME/.cache/current_wallpaper"

if [ -f "$CURRENT_WALL" ]; then
    wallpaper=$(cat "$CURRENT_WALL")

    if [ -f "$wallpaper" ]; then
        for i in $(seq 1 50); do
            hyprctl hyprpaper listloaded &>/dev/null && break
            sleep 0.2
        done
        hyprctl hyprpaper unload all
        hyprctl hyprpaper preload "$wallpaper"

        monitors=$(hyprctl monitors -j | jq -r '.[].name')
        for monitor in $monitors; do
            hyprctl hyprpaper wallpaper "$monitor,$wallpaper"
        done

        wal --theme gray -n -q
    fi
fi