#!/bin/bash
t=$(curl -s -m 3 'wttr.in/Mollet+del+Valles?format=%c+%t' 2>/dev/null)
[[ -n "$t" && "$t" != *Unknown* && "$t" != *html* ]] && echo "$t  ·  Mollet"
