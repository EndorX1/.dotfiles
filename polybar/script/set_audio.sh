#!/bin/bash
sink="$1"
wpctl set-default "$sink"
wpctl list | grep "Sink Input" | awk '{print $2}' | tr -d '.' | while read -r input; do
    wpctl move "$input" "$sink"
done
notify-send "Audio → Switched to $sink"
