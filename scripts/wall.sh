#!/bin/bash

FOLDER="$HOME/Pictures/Wallpapers"
mapfile -t wallpapers < <(find "$FOLDER" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) | shuf)

if [[ $1 == "start" ]]; then
    awww img "${wallpapers[0]}"
elif [[ $1 == "random" ]]; then
    awww img "${wallpapers[0]}" --transition-fps 60 --transition-type wipe
else
    choice=$(printf "%s\n" "${wallpapers[@]}" | xargs -n 1 basename | sort | fuzzel -w 10 --dmenu --prompt "  ")
    [[ -n $choice ]] && awww img "$(find "$FOLDER" -name "$choice")" --transition-fps 60 --transition-type wipe
fi
