#!/bin/bash

#      _______  ________  ________  ________  ________ 
#    ╱╱       ╲╱    ╱   ╲╱        ╲╱        ╲╱        ╲
#   ╱╱        ╱         ╱    ╱    ╱    ╱    ╱         ╱
#  ╱       --╱         ╱         ╱        _╱   ╱  ╱  ╱ 
#  ╲________╱╲___╱____╱╲___╱____╱╲____╱___╱╲__╱__╱__╱  
#
# One of the lucky charm.
#
# Rofi wallpaper/theme selector with previews

WALLPAPER_DIR="$HOME/Assets/Walls"
CACHE_DIR="$HOME/.cache/wall-select"
CURRENT_WALL="$HOME/.cache/current_wallpaper"

mkdir -p "$CACHE_DIR"

generate_thumbnails() {
    for img in "$WALLPAPER_DIR"/*.{jpg,jpeg,png,webp}; do
        [ -f "$img" ] || continue
        thumb="$CACHE_DIR/$(basename "$img")"
        if [ ! -f "$thumb" ]; then
            convert "$img" -resize 200x200^ -gravity center -extent 200x200 "$thumb" 2>/dev/null
        fi
    done
}

list_wallpapers() {
    for img in "$WALLPAPER_DIR"/*.{jpg,jpeg,png,webp}; do
        [ -f "$img" ] || continue
        local name
        name=$(basename "$img")
        local thumb_path="$CACHE_DIR/$name"

        if [ -f "$thumb_path" ]; then
            echo -en "${name}\0icon\x1f${thumb_path}\n"
        else
            echo "${name}"
        fi
    done
}

apply_wallpaper() {
    local wallpaper="$1"

    echo "$wallpaper" > "$CURRENT_WALL"

    case "$(basename "$wallpaper")" in
        15.png) wal --theme gray -n -q ;;
        *)      wal -i "$wallpaper" --cols16 darken --backend wal --contrast 1.5 -n -q ;;
    esac

    hyprctl hyprpaper unload all
    hyprctl hyprpaper preload "$wallpaper"

    monitors=$(hyprctl monitors -j | jq -r '.[].name')
    for monitor in $monitors; do
        hyprctl hyprpaper wallpaper "$monitor,$wallpaper"
    done

    notify-send -i "$wallpaper" "Wallpaper Changed" "$(basename "$wallpaper")"
}

generate_thumbnails

chosen=$(list_wallpapers | rofi -dmenu \
    -i \
    -p "Wallpaper" \
    -show-icons \
    -theme "$HOME/.config/rofi/wall-select.rasi" \
)

if [ -n "$chosen" ]; then
    apply_wallpaper "$WALLPAPER_DIR/$chosen"
fi