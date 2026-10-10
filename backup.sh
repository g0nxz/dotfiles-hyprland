#!/bin/bash
# Copia las configs vivas -> repo
set -e
REPO="$HOME/dotfiles"; cd "$REPO"
EX="--exclude=wall --exclude=target --exclude=ports --exclude=*.ovpn --exclude=*.log"

for d in hypr waybar rofi dunst ghostty wlogout wal/templates qt5ct qt6ct; do
  [ -e "$HOME/.config/$d" ] || continue
  mkdir -p "config/$(dirname "$d")"
  rsync -a --delete $EX "$HOME/.config/$d" "config/$(dirname "$d")/"
done

[ -f "$HOME/.config/gtk-3.0/settings.ini" ] && { mkdir -p config/gtk-3.0; cp "$HOME/.config/gtk-3.0/settings.ini" config/gtk-3.0/; }
[ -f "$HOME/.config/starship.toml" ] && cp "$HOME/.config/starship.toml" config/
[ -f "$HOME/.zshrc" ]    && { mkdir -p home; cp "$HOME/.zshrc" home/; }
[ -f "$HOME/.p10k.zsh" ] && { mkdir -p home; cp "$HOME/.p10k.zsh" home/; }

[ -f "$HOME/bloodhound-ce/docker-compose.yml" ] && { mkdir -p bloodhound-ce; cp "$HOME/bloodhound-ce/docker-compose.yml" bloodhound-ce/; }
echo "Backup actualizado en $REPO"
