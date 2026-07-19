#!/bin/bash

# Clean IP Finder
# GitHub: @lavateam-IR

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
BOLD='\033[1m'
NC='\033[0m'

clear

echo -e "${CYAN}╔════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║${GREEN}${BOLD}       Clean IP Finder v1.0            ${NC}${CYAN}║${NC}"
echo -e "${CYAN}║${YELLOW}        @lavateam-IR                     ${NC}${CYAN}║${NC}"
echo -e "${CYAN}╚════════════════════════════════════════════╝${NC}"
echo ""

echo -e "${BLUE}▶ Fetching clean IPs...${NC}"
echo ""

# Source 1: vfarid
ips1=$(curl -s "https://raw.githubusercontent.com/vfarid/cf-clean-ips/main/ips.txt" 2>/dev/null | head -10)
if [ -n "$ips1" ]; then
    echo "$ips1" > /tmp/ips1.txt
    echo -e "${GREEN}🔻 server 1: ${#ips1} IPs${NC}"
fi

# Source 2: phamin2001
ips2=$(curl -s "https://raw.githubusercontent.com/phamin2001/cf-clean-ips/main/ips.txt" 2>/dev/null | head -10)
if [ -n "$ips2" ]; then
    echo "$ips2" > /tmp/ips2.txt
    echo -e "${GREEN}🔻 server 2: ${#ips2} IPs${NC}"
fi

# Source 3: Self scan
echo -e "${YELLOW}✓ Scanning domains...${NC}"
for domain in google.com youtube.com telegram.org github.com twitter.com; do
    ip=$(dig +short $domain 2>/dev/null | grep -E '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$' | head -1)
    if [ -n "$ip" ]; then
        echo "$ip" >> /tmp/ips3.txt
    fi
done

# Combine all
cat /tmp/ips*.txt 2>/dev/null | sort -u > clean_ips.txt
rm -f /tmp/ips*.txt

# Fallback
if [ ! -s clean_ips.txt ]; then
    cat > clean_ips.txt << EOF
142.250.185.78
142.250.185.110
149.154.167.99
104.244.42.193
185.89.219.11
172.217.16.78
EOF
fi

echo ""
echo -e "${CYAN}╔════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║${GREEN}${BOLD}           Clean IPs List               ${NC}${CYAN}║${NC}"
echo -e "${CYAN}╚════════════════════════════════════════════╝${NC}"
echo ""

counter=1
while IFS= read -r ip; do
    if [ -n "$ip" ]; then
        colors=($GREEN $CYAN $MAGENTA $BLUE $YELLOW)
        color=${colors[$((counter % ${#colors[@]}))]}
        echo -e "${color}  $counter.${NC} ${WHITE}$ip${NC}"
        ((counter++))
    fi
done < clean_ips.txt

echo ""
echo -e "${GREEN}✅ Total: $(cat clean_ips.txt | wc -l) IPs${NC}"
echo -e "${YELLOW}📁 Saved to: clean_ips.txt${NC}"
echo ""
echo -e "${CYAN}────────────────────────────────────────────${NC}"
echo -e "${YELLOW}📋 Copy: cat clean_ips.txt${NC}"
echo -e "${CYAN}────────────────────────────────────────────${NC}"
echo ""
