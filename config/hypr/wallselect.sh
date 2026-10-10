#!/bin/bash
WALL_DIR="$HOME/wallpapers"
THUMB_DIR="$HOME/.cache/wallthumbs"
mkdir -p "$THUMB_DIR"

choice=$(
  for f in "$WALL_DIR"/*.{jpg,jpeg,png,gif,mp4,mkv,webm}; do
    [ -f "$f" ] || continue
    name="$(basename "$f")"
    base="${name%.*}"
    ext="${name##*.}"; ext="${ext,,}"

    # saltar el fondo del lock y las portadas estáticas
    [ "$name" = "lock-bg.png" ] && continue
    case "$name" in *_static.png) continue;; esac

    case "$ext" in
      mp4|mkv|webm)
        # miniatura: usa el .png gemelo si existe; si no, la genera
        thumb="$THUMB_DIR/$base.png"
        if [ -f "$WALL_DIR/$base.png" ]; then
          thumb="$WALL_DIR/$base.png"
        elif [ ! -f "$thumb" ]; then
          ffmpeg -y -i "$f" -vframes 1 "$thumb" >/dev/null 2>&1
        fi
        printf '%s\0icon\x1f%s\n' "$name" "$thumb"
        ;;
      png|jpg|jpeg)
        # saltar imágenes que son gemelas de un vídeo (portadas)
        if [ -f "$WALL_DIR/$base.mp4" ] || [ -f "$WALL_DIR/$base.mkv" ] || [ -f "$WALL_DIR/$base.webm" ]; then
          continue
        fi
        printf '%s\0icon\x1f%s\n' "$name" "$f"
        ;;
      gif)
        printf '%s\0icon\x1f%s\n' "$name" "$f"
        ;;
    esac
  done | rofi -dmenu -i -p "Wallpaper" -theme ~/.config/rofi/wallselect.rasi
)
[ -z "$choice" ] && exit 0
~/.config/hypr/setwall.sh "$WALL_DIR/$choice"
