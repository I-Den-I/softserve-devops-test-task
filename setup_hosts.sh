#!/bin/bash

ARCH=$(uname -m)
if [[ "$ARCH" == "arm64" || "$ARCH" == "aarch64" ]]; then
    IP="127.0.0.1"
    DESC="ARM Architecture detected"
else
    IP="192.168.56.10"
    DESC="x86_64 Architecture detected"
fi

ENTRIES=("jenkins.local" "zabbix.local" "vault.local")
HOSTS_FILE="/etc/hosts"

echo "--- Configuring Hosts for $DESC ---"

for entry in "${ENTRIES[@]}"; do
    if grep -q "$entry" "$HOSTS_FILE"; then
        echo "[SKIP] $entry already exists."
    else
        echo "Adding $IP $entry"
        echo "$IP $entry" | sudo tee -a "$HOSTS_FILE" > /dev/null
    fi
done

echo "Done! Access your services at http://jenkins.local etc."