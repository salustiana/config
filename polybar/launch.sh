#!/bin/bash

# terminate running bar instances
killall -q polybar

# launch polybar, using default config location
# ~/.config/polybar/config.ini
polybar mybar 2>&1 | tee -a /tmp/polybar.log & disown

echo "polybar lanzado"
