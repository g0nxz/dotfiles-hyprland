#!/bin/bash
# Restaura el último fondo al iniciar sesión (imagen con awww o vídeo con mpvpaper)
WALL=$(cat ~/.config/hypr/wall 2>/dev/null)
[ -f "$WALL" ] || WALL="$HOME/wallpapers/fondo.jpg"
exec ~/.config/hypr/setwall.sh "$WALL"
