#!/bin/bash

# Change to your terminal emulator if needed (e.g., alacritty, kitty, etc.)
TERMINAL="kitty"

# Focus on workspace 1
i3-msg "workspace Terminal"

sleep 1
# Launch first terminal
$TERMINAL &

# Split horizontally and launch second terminal
i3-msg "split horizontal"
$TERMINAL &

sleep 0.5

# Focus right (on the second terminal), split vertically, and launch third terminal
i3-msg "split vertical"
$TERMINAL &
