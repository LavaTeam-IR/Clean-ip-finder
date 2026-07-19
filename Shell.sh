#!/data/data/com.termux/files/usr/bin/bash

clear

echo "●●●●●●●●●●●●●●●●"
echo "●   clean ip finder     ●"
echo "●●●●●●●●●●●●●●●●"
echo "By @lavateam-IR [github]"
echo

pkg install -y curl iputils netcat >/dev/null 2>&1

read -p "Port (default 443): " PORT
PORT=${PORT:-443}

echo
echo "Enter IPs (one per line)."
echo "Press Ctrl+D when finished."
echo

IPS=()
while read ip; do
    IPS+=("$ip")
done

echo
echo "===== Result ====="

for ip in "${IPS[@]}"; do
    printf "%-16s" "$ip"

    if ping -c 1 -W 1 "$ip" >/dev/null 2>&1; then
        if nc -z -w2 "$ip" "$PORT" >/dev/null 2>&1; then
            echo "✅ CLEAN"
        else
            echo "⚠️ Ping OK | Port Closed"
        fi
    else
        echo "❌ Offline"
    fi
done

echo
echo "Done."
