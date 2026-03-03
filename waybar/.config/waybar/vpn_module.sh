#!/bin/bash

# --- MULLVAD CHECK ---
if command -v mullvad &> /dev/null; then
    if mullvad status | grep -q "^Connected"; then
        
        LOCATION=$(mullvad status | \
            grep "Visible location:" | \
            sed 's/.*Visible location:[[:space:]]*//' | \
            cut -d'.' -f1)

        # Extract only country (before comma)
        COUNTRY=$(echo "$LOCATION" | cut -d',' -f1 | xargs)

        echo "{\"text\":\"$COUNTRY\", \"tooltip\":\"Mullvad: $LOCATION\", \"class\":\"mullvad\"}"
        exit 0
    fi
fi

# --- VPNC CHECK ---
if pgrep vpnc > /dev/null; then
    PROFILE=$(grep "IPSec gateway" /var/run/vpnc/* 2>/dev/null | awk -F': ' '{print $2}' | head -n1)
    PROFILE=${PROFILE:-vpnc}
    echo "{\"text\":\"$PROFILE\", \"tooltip\":\"VPNC: $PROFILE\", \"class\":\"vpnc\"}"
    exit 0
fi

# --- DISCONNECTED ---
echo "{\"text\":\"No VPN\", \"tooltip\":\"VPN Disconnected\", \"class\":\"disconnected\"}"
