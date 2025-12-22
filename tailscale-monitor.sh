#!/bin/bash

# File to store last known Tailscale devices
STATE_FILE="/var/tmp/tailscale_devices.txt"
EMAIL="email@example.com"

# Get current device list (IP + hostname)
CURRENT=$(tailscale status --json | jq -r '.Peer[] | "\(.TailscaleIPs[0]) \(.HostName)"' | sort)

# Read previous device list
if [ -f "$STATE_FILE" ]; then
    PREVIOUS=$(cat "$STATE_FILE")
else
    PREVIOUS=""
fi

# Compare current vs previous
NEW=$(comm -13 <(echo "$PREVIOUS") <(echo "$CURRENT"))

if [ -n "$NEW" ]; then
    echo -e "New Tailscale device(s) detected:\n$NEW" | mail -s "Tailscale Alert: New device connected" "$EMAIL"
fi

# Update the state file
echo "$CURRENT" > "$STATE_FILE"
