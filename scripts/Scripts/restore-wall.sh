#!/bin/bash

CURRENT_WALL="$HOME/.cache/current_wallpaper"

if [ -f "$CURRENT_WALL" ]; then
    wallpaper=$(cat "$CURRENT_WALL")

    if [ -f "$wallpaper" ]; then
        sleep 1
        hyprctl hyprpaper unload all
        hyprctl hyprpaper preload "$wallpaper"

        monitors=$(hyprctl monitors -j | jq -r '.[].name')
        for monitor in $monitors; do
            hyprctl hyprpaper wallpaper "$monitor,$wallpaper"
        done
    fi
fi