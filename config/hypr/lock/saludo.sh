#!/bin/bash
h=$(date +%-H)
if   (( h < 6 ));  then s="Buenas noches"
elif (( h < 14 )); then s="Buenos días"
elif (( h < 21 )); then s="Buenas tardes"
else                    s="Buenas noches"; fi
echo "$s, Xavi"
