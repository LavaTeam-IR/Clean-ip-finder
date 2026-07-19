#!/usr/bin/env python3

# Clean IP Finder - Python Version
# GitHub: @lavateam-IR

import subprocess
import requests
import socket
import threading
import time
import os
import sys
from concurrent.futures import ThreadPoolExecutor, as_completed
from colorama import init, Fore, Style

# Initialize colorama
init(autoreset=True)

# Colors
GREEN = Fore.GREEN
RED = Fore.RED
YELLOW = Fore.YELLOW
BLUE = Fore.BLUE
MAGENTA = Fore.MAGENTA
CYAN = Fore.CYAN
WHITE = Fore.WHITE
BOLD = Style.BRIGHT
RESET = Style.RESET_ALL

def clear_screen():
    os.system('cls' if os.name == 'nt' else 'clear')

def print_banner():
    print(f"{CYAN}╔════════════════════════════════════════════╗{RESET}")
    print(f"{CYAN}║{GREEN}{BOLD}     Clean IP Finder - Real Time       {RESET}{CYAN}║{RESET}")
    print(f"{CYAN}║{YELLOW}        @lavateam-IR                     {RESET}{CYAN}║{RESET}")
    print(f"{CYAN}╚════════════════════════════════════════════╝{RESET}")
    print()

def get_cloudflare_ips():
    try:
        response = requests.get('https://www.cloudflare.com/ips-v4', timeout=5)
        return set(response.text.strip().split('\n'))
    except:
        return set()

def get_domain_ips(domain):
    ips = []
    for dns in ['8.8.8.8', '1.1.1.1', '9.9.9.9']:
        try:
            cmd = f'dig +short @{dns} {domain}'
            result = subprocess.run(cmd, shell=True, capture_output=True, text=True, timeout=3)
            for ip in result.stdout.strip().split('\n'):
                if ip and '.' in ip and not ip.startswith(('127.', '192.168.', '10.', '172.16.')):
                    ips.append(ip)
        except:
            continue
    return list(set(ips))[:5]

def test_ip(ip, domain):
    try:
        response = requests.get(
            f'http://{ip}',
            headers={'Host': domain},
            timeout=2,
            allow_redirects=True
        )
        if response.status_code in [200, 301, 302, 403]:
            return True
    except:
        pass
    return False

def scan_domain(domain, cf_ips):
    print(f"{YELLOW}► {domain}{RESET}", end=' ')
    
    ips = get_domain_ips(domain)
    
    if not ips:
        print(f"{RED}✗ No IPs found{RESET}")
        return None
    
    for ip in ips:
        # Skip Cloudflare IPs
        if any(ip.startswith(cf_ip.replace('.', '.')) for cf_ip in cf_ips):
            continue
        
        if test_ip(ip, domain):
            print(f"{GREEN}✓ {ip}{RESET}")
            return ip
        time.sleep(0.1)
    
    print(f"{RED}✗ No working IP{RESET}")
    return None

def main():
    clear_screen()
    print_banner()
    
    # Check dependencies
    try:
        subprocess.run(['dig', '-v'], capture_output=True, check=True)
    except:
        print(f"{YELLOW}Installing dig...{RESET}")
        os.system('pkg install dig -y 2>/dev/null || apt install dnsutils -y 2>/dev/null')
    
    # Get Cloudflare IPs
    print(f"{BLUE}▶ Getting Cloudflare IP ranges...{RESET}")
    cf_ips = get_cloudflare_ips()
    print(f"{GREEN}✓ Done ({len(cf_ips)} IPs){RESET}")
    print()
    
    # Domains to scan
    domains = [
        'google.com',
        'youtube.com',
        'telegram.org',
        'instagram.com',
        'twitter.com',
        'aparat.com',
        'digikala.com',
        'github.com',
        'stackoverflow.com',
        'whatsapp.net'
    ]
    
    print(f"{CYAN}▶ Scanning {len(domains)} domains for real IPs...{RESET}")
    print()
    
    clean_ips = []
    domain_map = {}
    
    with ThreadPoolExecutor(max_workers=5) as executor:
        futures = {executor.submit(scan_domain, domain, cf_ips): domain for domain in domains}
        
        for future in as_completed(futures):
            domain = futures[future]
            result = future.result()
            if result:
                clean_ips.append(result)
                domain_map[result] = domain
    
    # Remove duplicates
    clean_ips = list(set(clean_ips))
    
    # Save to file
    with open('clean_ips.txt', 'w') as f:
        for ip in clean_ips:
            f.write(f'{ip}\n')
    
    # Show results
    print()
    print(f"{CYAN}╔════════════════════════════════════════════╗{RESET}")
    print(f"{CYAN}║{GREEN}{BOLD}         Live Clean IPs Found          {RESET}{CYAN}║{RESET}")
    print(f"{CYAN}╚════════════════════════════════════════════╝{RESET}")
    print()
    
    if clean_ips:
        for idx, ip in enumerate(clean_ips, 1):
            colors = [GREEN, CYAN, MAGENTA, BLUE, YELLOW]
            color = colors[idx % len(colors)]
            domain = domain_map.get(ip, 'Unknown')
            print(f"{color}  {idx}.{RESET} {WHITE}{ip}{RESET} → {YELLOW}{domain}{RESET}")
        
        print()
        print(f"{GREEN}✅ Total live IPs: {len(clean_ips)}{RESET}")
        print(f"{YELLOW}📁 Saved to: clean_ips.txt{RESET}")
    else:
        print(f"{RED}❌ No live IPs found!{RESET}")
        print(f"{YELLOW}Try again later{RESET}")
    
    print()
    print(f"{CYAN}────────────────────────────────────────────{RESET}")
    print(f"{YELLOW}📋 Copy: cat clean_ips.txt{RESET}")
    print(f"{BLUE}🔄 Last scan: {time.strftime('%H:%M:%S')}{RESET}")
    print(f"{CYAN}────────────────────────────────────────────{RESET}")
    print()

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print(f"\n{RED}❌ Cancelled by user{RESET}")
        sys.exit(0)
