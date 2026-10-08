#!/bin/bash
hyprctl dispatch moveworkspacetomonitor 1 HDMI-A-3
hyprctl dispatch moveworkspacetomonitor 2 HDMI-A-3
hyprctl dispatch moveworkspacetomonitor 3 HDMI-A-3
hyprctl dispatch moveworkspacetomonitor 4 HDMI-A-3
hyprctl dispatch moveworkspacetomonitor 5 HDMI-A-3

hyprctl keyword monitor "eDP-1,disable"
hyprctl keyword monitor "HDMI-A-3,1920x1080@120,0x0,1"