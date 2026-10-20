#!/bin/bash
command -v playerctl >/dev/null || exit 0
[[ "$(playerctl status 2>/dev/null)" == "Playing" ]] || exit 0
playerctl metadata --format '{{artist}} — {{title}}' 2>/dev/null | cut -c1-38 | sed 's/^/󰎆  /'
