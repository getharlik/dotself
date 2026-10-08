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
CACHE_DIR="$HOME/.cache/wall-select/320x480"
CURRENT_WALL="$HOME/.cache/current_wallpaper"

mkdir -p "$CACHE_DIR"

# Card geometry — keep in sync with wall-select.rasi
CARD_W=192      # element-icon 160px + element padding 2 * 16px
CARD_GAP=4      # listview spacing
LIST_PAD=24     # listview padding
MAX_CARDS=5

# ImageMagick 7 ships `magick`; older installs only have `convert`
if command -v magick >/dev/null; then IM=magick
elif command -v convert >/dev/null; then IM=convert
else
    notify-send "Wallpaper" "ImageMagick is not installed — can't build previews"
    exit 1
fi

# Fit an odd number of cards (so one sits in the middle) on the focused monitor,
# using its logical width so scaling and rotation are accounted for
screen_w=$(hyprctl monitors -j | jq -r '.[] | select(.focused)
    | (if .transform % 2 == 1 then .height else .width end) / .scale | floor' 2>/dev/null)
[[ "$screen_w" =~ ^[0-9]+$ ]] || screen_w=1920
VISIBLE=$(( (screen_w * 95 / 100 - 2 * LIST_PAD + CARD_GAP) / (CARD_W + CARD_GAP) ))
(( VISIBLE > MAX_CARDS )) && VISIBLE=$MAX_CARDS
(( VISIBLE % 2 == 0 )) && (( VISIBLE-- ))
(( VISIBLE < 1 )) && VISIBLE=1

generate_thumbnails() {
    for img in "$WALLPAPER_DIR"/*.{jpg,jpeg,png,webp}; do
        [ -f "$img" ] || continue
        thumb="$CACHE_DIR/$(basename "$img")"
        # -s: a failed conversion can leave an empty file behind; redo those
        if [ ! -s "$thumb" ]; then
            "$IM" "${img}[0]" -resize 320x480^ -gravity center -extent 320x480 "$thumb" 2>/dev/null \
                || rm -f "$thumb"
        fi
    done
}

generate_thumbnails

# Only offer wallpapers that have a preview — anything else would be a blank card
walls=()
for img in "$WALLPAPER_DIR"/*.{jpg,jpeg,png,webp}; do
    [ -f "$img" ] && [ -s "$CACHE_DIR/$(basename "$img")" ] && walls+=("$img")
done

current=$(cat "$CURRENT_WALL" 2>/dev/null)
offset=0
for i in "${!walls[@]}"; do
    [ "${walls[$i]}" = "$current" ] && offset=$i && break
done

count=${#walls[@]}
[ "$count" -eq 0 ] && { notify-send "Wallpaper" "No wallpapers in $WALLPAPER_DIR"; exit 1; }

# Never size the window for more cards than there are wallpapers
(( VISIBLE > count )) && VISIBLE=$count
middle=$(( VISIBLE / 2 ))
WINDOW_W=$(( 2 * LIST_PAD + VISIBLE * CARD_W + (VISIBLE - 1) * CARD_GAP ))
start=$(( (offset - middle + count) % count ))

# Squircle window body, sized to match (see ~/.config/rofi/squircle.sh)
WINDOW_H=326    # window height in wall-select.rasi
SHAPE=$("$HOME/.config/rofi/squircle.sh" "$WINDOW_W" "$WINDOW_H")

list_wallpapers() {
    for (( n = 0; n < count; n++ )); do
        img="${walls[$(( (start + n) % count ))]}"
        local name
        name=$(basename "$img")
        echo -en "${name}\0icon\x1f$CACHE_DIR/${name}\n"
    done
}

apply_wallpaper() {
    local wallpaper="$1"

    echo "$wallpaper" > "$CURRENT_WALL"

    case "$(basename "$wallpaper")" in
        5.jpg) wal --theme hysteria -n -q ;;
        *)      wal -i "$wallpaper" --cols16 darken --backend wal --contrast 1.5 -n -q ;;
    esac

    # pick up the new pywal colors in waybar
    pkill -SIGUSR2 -x waybar

    monitors=$(hyprctl monitors -j | jq -r '.[].name')
    for monitor in $monitors; do
        hyprctl hyprpaper wallpaper "$monitor,$wallpaper"
    done

    notify-send -i "$wallpaper" "Wallpaper Changed" "$(basename "$wallpaper")"
}

chosen=$(list_wallpapers | rofi -dmenu \
    -i \
    -p "Wallpaper" \
    -show-icons \
    -sync \
    -selected-row "$middle" \
    -theme "$HOME/.config/rofi/wall-select.rasi" \
    -theme-str "window { width: ${WINDOW_W}px; background-image: url(\"${SHAPE}\", both); } listview { columns: ${VISIBLE}; }" \
    -kb-move-char-back "" -kb-move-char-forward "" \
    -kb-row-left "Left,Control+Page_Up" -kb-row-right "Right,Control+Page_Down" \
)

if [ -n "$chosen" ]; then
    apply_wallpaper "$WALLPAPER_DIR/$chosen"
fi