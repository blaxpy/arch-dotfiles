#!/usr/bin/bash

# Terminate already running polybar instances.
killall -q polybar

# Launch "top" bar.
echo "---" | tee --append /tmp/polybar_top.log
polybar top >> /tmp/polybar_top.log 2>&1 &

echo "Bar launched..."
