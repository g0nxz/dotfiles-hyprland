# 🪻 dotfiles — Hyprland Rice

Configuración personal de un escritorio **Hyprland (Wayland)** sobre **Kali Linux**,
con tema dinámico que se adapta al fondo de pantalla y orientado a pentesting (CPTS/OSCP).

![Hyprland](https://img.shields.io/badge/WM-Hyprland-bb9af7)
![Wayland](https://img.shields.io/badge/Wayland-NVIDIA-9d7cd8)
![Shell](https://img.shields.io/badge/shell-zsh%20%2B%20p10k-7aa2f7)

## ✨ Características

- **Tema dinámico con pywal**: al cambiar de fondo, se recolorean a la vez
  los bordes de Hyprland, Waybar, Rofi, Hyprlock, Dunst y tmux.
- **Fondos animados** (mp4/mkv/webm/gif) vía `mpvpaper`, con extracción de
  frame para que pywal saque la paleta del vídeo.
- **Selector de fondos** tipo carrusel en Rofi, con miniaturas (imágenes y vídeos).
- **Bloqueo** (Hyprlock) con el fondo actual desenfocado y acentos del tema.
- Utilidades de pentesting integradas en la Waybar (target + puertos abiertos).

## 🧩 Componentes

| Parte            | Herramienta                          |
|------------------|--------------------------------------|
| Compositor       | Hyprland (Wayland, NVIDIA propietario) |
| Login            | SDDM                                 |
| Barra            | Waybar                               |
| Lanzador         | Rofi                                 |
| Notificaciones   | Dunst                                |
| Bloqueo          | Hyprlock                             |
| Terminal         | Ghostty                              |
| Shell            | zsh + Powerlevel10k                  |
| Multiplexor      | tmux (prefijo C-a, resurrect/continuum) |
| Theming          | pywal (plantillas en wal/templates)  |

## 🚀 Instalación / restauración

```bash
git clone https://github.com/g0nxz/dotfiles-hyprland ~/dotfiles
cd ~/dotfiles
./restore.sh          # copia las configs a ~/.config y ~
./install-tools.sh    # (opcional) instala el arsenal de pentesting
```

Tras restaurar, dentro de tmux pulsa `Ctrl+a` + `Shift+I` para instalar los plugins (TPM).

## 💾 Mantener el repo al día

```bash
cd ~/dotfiles && ./backup.sh && git add -A && git commit -m "..." && git push
```

## ⌨️ Atajos principales

| Atajo              | Acción                      |
|--------------------|-----------------------------|
| `Super + Return`   | Terminal (Ghostty)          |
| `Super + Space`    | Lanzador (Rofi)             |
| `Super + W`        | Selector de fondos          |
| `Super + L`        | Bloquear (Hyprlock)         |
| `Super + Q`        | Cerrar ventana              |
| `Print`            | Captura (Flameshot)         |

---

> Ricing en constante evolución. Paleta base morada, pero cambia con cada wallpaper 🎨
