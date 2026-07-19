#!/bin/bash

# Clean IP Finder - Auto Mode v3.0
# No input needed! Just run and get clean IPs

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${BLUE}========================================${NC}"
echo -e "${GREEN}   Clean IP Finder - Auto Mode v3.0   ${NC}"
echo -e "${BLUE}========================================${NC}"

# Install dependencies
for cmd in curl dig; do
    if ! command -v $cmd &> /dev/null; then
        echo -e "${YELLOW}Installing $cmd...${NC}"
        pkg install $cmd -y
    fi
done

# Pre-defined popular domains (کاربر هیچی وارد نمی‌کنه)
domains=(
    "google.com"
    "youtube.com"
    "telegram.org"
    "instagram.com"
    "twitter.com"
    "whatsapp.net"
    "aparat.com"
    "digikala.com"
    "github.com"
    "stackoverflow.com"
)

echo -e "${CYAN}📡 Scanning ${#domains[@]} popular domains...${NC}"
echo -e "${YELLOW}This may take 2-3 minutes...${NC}"
echo ""

# Get Cloudflare IP ranges (برای تشخیص)
cf_ips=$(curl -s https://www.cloudflare.com/ips-v4 2>/dev/null)

# Results file
> clean_ips.txt
> all_ips.txt

# Scan each domain
for domain in "${domains[@]}"; do
    echo -ne "${CYAN}► Checking $domain...${NC} "
    
    # Get IPs
    ips=$(dig +short $domain | grep -E '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$' | head -3)
    
    if [ -z "$ips" ]; then
        echo -e "${RED}✗ No IPs${NC}"
        continue
    fi
    
    # Test each IP
    found=0
    for ip in $ips; do
        # Check if Cloudflare IP
        if echo "$cf_ips" | grep -q "$ip"; then
            continue  # Skip Cloudflare IPs
        fi
        
        # Test if working
        response=$(curl -s -m 2 -o /dev/null -w "%{http_code}" -H "Host: $domain" http://$ip 2>/dev/null)
        
        if [ "$response" = "200" ] || [ "$response" = "301" ] || [ "$response" = "302" ]; then
            echo -e "${GREEN}✓ Found: $ip${NC}"
            echo "$ip # $domain" >> clean_ips.txt
            found=1
            break
        fi
    done
    
    if [ $found -eq 0 ]; then
        echo -e "${RED}✗ No clean IP${NC}"
    fi
done

# If no IPs found, use fallback method
if [ ! -s clean_ips.txt ]; then
    echo -e "${YELLOW}No IPs found with DNS. Trying alternative method...${NC}"
    
    # Try certificate logs for popular domains
    for domain in "${domains[@]}"; do
        echo -ne "${CYAN}► Searching $domain in certificate logs...${NC}"
        
        # Get IPs from crt.sh
        cert_ips=$(curl -s "https://crt.sh/?q=$domain&output=json" 2>/dev/null | grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | head -2)
        
        for ip in $cert_ips; do
            # Skip Cloudflare
            if echo "$cf_ips" | grep -q "$ip"; then
                continue
            fi
            
            # Test
            response=$(curl -s -m 2 -o /dev/null -w "%{http_code}" -H "Host: $domain" http://$ip 2>/dev/null)
            if [ "$response" = "200" ] || [ "$response" = "301" ] || [ "$response" = "302" ]; then
                echo -e "${GREEN}✓ Found: $ip${NC}"
                echo "$ip # $domain" >> clean_ips.txt
                break
            fi
        done
    done
fi

# Show results
echo -e "${BLUE}========================================${NC}"
echo -e "${GREEN}🎯 Results:${NC}"

if [ -s clean_ips.txt ]; then
    echo -e "${GREEN}✓ Found $(cat clean_ips.txt | wc -l) clean IPs:${NC}"
    cat clean_ips.txt | while read line; do
        ip=$(echo $line | cut -d'#' -f1 | xargs)
        domain=$(echo $line | cut -d'#' -f2 | xargs)
        echo -e "  ${GREEN}► $ip${NC} → ${CYAN}$domain${NC}"
    done
    
    # Save to file
    cp clean_ips.txt "clean_ips_$(date +%Y%m%d).txt"
    echo -e "${YELLOW}📁 Saved to: clean_ips_$(date +%Y%m%d).txt${NC}"
    
    # Show one-liner for copy
    echo ""
    echo -e "${CYAN}📋 Copy these IPs:${NC}"
    cat clean_ips.txt | cut -d'#' -f1 | xargs echo
else
    echo -e "${RED}✗ No clean IPs found${NC}"
    echo -e "${YELLOW}Try again later or check internet connection${NC}"
fi

echo -e "${BLUE}========================================${NC}"
