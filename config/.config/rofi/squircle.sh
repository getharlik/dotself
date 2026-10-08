#!/bin/bash

# Rofi squircle background generator
#
# Rofi is a layer surface, so Hyprland's decoration.rounding_power never touches
# it, and rofi's own border-radius only draws circular arcs. Instead the window
# is left transparent and painted with an SVG of the same superellipse corner
# Hyprland uses: |x|^n + |y|^n = r^n.
#
# Usage: squircle.sh WIDTH HEIGHT [OUTPUT]   — prints the path of the SVG

RADIUS=${SQUIRCLE_RADIUS:-40}       # keep in sync with border-rad in the themes
POWER=${SQUIRCLE_POWER:-4}          # decoration.rounding_power in looknfeel.lua
FILL=${SQUIRCLE_FILL:-#2d2d2d}      # rgba(45, 45, 45, 0.3)
OPACITY=${SQUIRCLE_OPACITY:-0.3}

w=$1 h=$2
[[ "$w" =~ ^[0-9]+$ && "$h" =~ ^[0-9]+$ ]] || { echo "usage: $0 WIDTH HEIGHT [OUTPUT]" >&2; exit 1; }

out=${3:-${XDG_CACHE_HOME:-$HOME/.cache}/rofi/squircle-${w}x${h}.svg}
mkdir -p "$(dirname "$out")"

awk -v w="$w" -v h="$h" -v r="$RADIUS" -v n="$POWER" -v fill="$FILL" -v op="$OPACITY" '
function pt(cx, cy, sx, sy, t) {
    d = d sprintf("%.2f,%.2f ", cx + sx * r * cos(t) ^ (2 / n), cy + sy * r * sin(t) ^ (2 / n))
}
BEGIN {
    half = atan2(1, 1) * 2; steps = 32
    if (r > w / 2) r = w / 2
    if (r > h / 2) r = h / 2
    # clockwise from the top-right corner
    for (i = steps; i >= 0; i--) pt(w - r, r,      1, -1, half * i / steps)
    for (i = 0; i <= steps; i++) pt(w - r, h - r,  1,  1, half * i / steps)
    for (i = steps; i >= 0; i--) pt(r,     h - r, -1,  1, half * i / steps)
    for (i = 0; i <= steps; i++) pt(r,     r,     -1, -1, half * i / steps)
    printf "<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"%d\" height=\"%d\" viewBox=\"0 0 %d %d\">", w, h, w, h
    printf "<polygon points=\"%s\" fill=\"%s\" fill-opacity=\"%s\"/></svg>\n", d, fill, op
}' > "$out"

echo "$out"
