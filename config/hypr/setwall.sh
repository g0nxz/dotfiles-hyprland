#!/bin/bash
IMG="$1"
[ -z "$IMG" ] && exit 1

echo "$IMG" > ~/.config/hypr/wall

pkill mpvpaper 2>/dev/null
pkill hyprpaper 2>/dev/null
sleep 0.3

ext="${IMG##*.}"; ext="${ext,,}"
LOCKSRC="$IMG"

case "$ext" in
  mp4|mkv|webm|gif)
    mpvpaper -o "no-audio loop-file=inf --hwdec=auto" '*' "$IMG" &
    frame="/tmp/wal-frame.png"
    ffmpeg -y -i "$IMG" -vframes 1 "$frame" >/dev/null 2>&1
    [ -f "$frame" ] && wal -i "$frame" -n -q
    LOCKSRC="$frame"
    ;;
  *)
    hyprpaper &
    sleep 1
    hyprctl hyprpaper preload "$IMG"
    hyprctl hyprpaper wallpaper "HDMI-A-1,$IMG"
    hyprctl hyprpaper wallpaper "DP-1,$IMG"
    wal -i "$IMG" -n -q
    ;;
esac

# --- Propagar el tema a todo el entorno ---
cp "$LOCKSRC" ~/.cache/wal/lock-bg.png 2>/dev/null

cp ~/.cache/wal/dunstrc ~/.config/dunst/dunstrc 2>/dev/null
dunstctl reload 2>/dev/null || killall dunst 2>/dev/null

killall -SIGUSR2 waybar 2>/dev/null
tmux source-file ~/.cache/wal/colors-tmux.conf 2>/dev/null

hyprctl reload
