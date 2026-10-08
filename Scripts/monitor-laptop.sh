#!/bin/bash
hyprctl dispatch moveworkspacetomonitor 1 eDP-1
hyprctl dispatch moveworkspacetomonitor 2 eDP-1
hyprctl dispatch moveworkspacetomonitor 3 eDP-1
hyprctl dispatch moveworkspacetomonitor 4 eDP-1
hyprctl dispatch moveworkspacetomonitor 5 eDP-1

hyprctl keyword monitor "HDMI-A-3,disable"
hyprctl keyword monitor "eDP-1,2880x1800@60,0x0,1.5"