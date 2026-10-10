#!/bin/bash
WALL=$(cat ~/.config/hypr/wall 2>/dev/null)
[ -z "$WALL" ] && WALL="$HOME/wallpapers/fondo.jpg"
hyprpaper &
sleep 1
hyprctl hyprpaper preload "$WALL"
hyprctl hyprpaper wallpaper "HDMI-A-1,$WALL"
hyprctl hyprpaper wallpaper "DP-1,$WALL"
