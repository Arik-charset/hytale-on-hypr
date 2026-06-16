#!/usr/bin/env bash

trap 'kill $(jobs -p) 2>/dev/null' EXIT

# D-Bus monitor loop
stdbuf -oL dbus-monitor "interface='org.freedesktop.portal.OpenURI'" 2>/dev/null | while read -r line; do
    if [[ "$line" =~ (https://oauth\.accounts\.hytale\.com/[^[:space:]\"]+) ]]; then
        echo "Found URL. Opening it"
        xdg-open "${BASH_REMATCH}" >/dev/null 2>&1 &
    fi
done &

# Launch Hytale, change to your method of choice :)
flatpak run com.hypixel.HytaleLauncher
