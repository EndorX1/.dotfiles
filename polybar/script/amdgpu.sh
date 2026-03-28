#!/usr/bin/env bash
set -euo pipefail

COLOR_TITLE="${COLOR_TITLE:-#B4BEFE}"
COLOR_LOAD="${COLOR_LOAD:-#94E2D5}"
COLOR_VRAM="${COLOR_VRAM:-#F5C2E7}"

card_path=""
for d in /sys/class/drm/card*/device; do
	[[ -f "$d/gpu_busy_percent" ]] && { card_path="$d"; break; }
done
[[ -z "$card_path" ]] && { echo "GPU n/a"; exit 0; }

t_input=""
for s in "$card_path"/hwmon/hwmon*/temp1_input; do
	[[ -f "$s" ]] && { t_input="$s"; break; }
done
temp="n/a"
if [[ -n "$t_input" ]]; then
	val=$(cat "$t_input" 2>/dev/null || echo "")
	[[ -n "$val" ]] && temp=$((val/1000))
fi

load=$(cat "$card_path/gpu_busy_percent" 2>/dev/null || echo "0")

v_used_b=$(cat "$card_path/mem_info_vram_used" 2>/dev/null || echo "0")
v_total_b=$(cat "$card_path/mem_info_vram_total" 2>/dev/null || echo "0")
v_used=$(( v_used_b / 1024 / 1024 ))
v_total=$(( v_total_b / 1024 / 1024 ))

# GPU 45°C | 12% | 512/8192 MiB
printf "%%{F%s}GPU%%{F-} %s°C | %%{F%s}%s%%%%{F-} | %%{F%s}%s/%s MiB%%{F-}\n" \
  "$COLOR_TITLE" "$temp" "$COLOR_LOAD" "$load" "$COLOR_VRAM" "$v_used" "$v_total"

