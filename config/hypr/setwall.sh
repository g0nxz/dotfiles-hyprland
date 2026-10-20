#!/bin/bash
IMG="$1"
[ -z "$IMG" ] && exit 1

echo "$IMG" > ~/.config/hypr/wall

ext="${IMG##*.}"; ext="${ext,,}"
LOCKSRC="$IMG"

case "$ext" in
  mp4|mkv|webm|gif)
    awww kill 2>/dev/null
    pkill hyprpaper 2>/dev/null
    pkill mpvpaper 2>/dev/null
    sleep 0.3
    mpvpaper -o "no-audio loop-file=inf --hwdec=auto" '*' "$IMG" &
    frame="/tmp/wal-frame.png"
    ffmpeg -y -i "$IMG" -vframes 1 "$frame" >/dev/null 2>&1
    [ -f "$frame" ] && wal -i "$frame" -n -q
    LOCKSRC="$frame"
    ;;
  *)
    pkill hyprpaper 2>/dev/null
    pgrep -x awww-daemon >/dev/null || { setsid -f awww-daemon >/dev/null 2>&1; sleep 0.5; }
    awww img "$IMG" \
      --transition-type grow --transition-pos center \
      --transition-duration 1.5 --transition-fps 120
    pkill mpvpaper 2>/dev/null
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
