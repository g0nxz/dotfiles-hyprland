#!/bin/bash
# Restaura el repo -> configs vivas (tras un reinstall)
set -e
REPO="$HOME/dotfiles"
rsync -a "$REPO/config/" "$HOME/.config/"
[ -f "$REPO/home/.zshrc" ]    && cp "$REPO/home/.zshrc" "$HOME/"
[ -f "$REPO/home/.p10k.zsh" ] && cp "$REPO/home/.p10k.zsh" "$HOME/"
echo "Dotfiles restaurados. Reinicia Hyprland (o cierra sesión y entra)."
