#!/bin/bash
# ============================================
# DNS Benchmark Script - 50 Free DNS Providers
# Tests response time from your location
# Compatible with bash and zsh
# ============================================

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'
BOLD='\033[1m'

# Check for dig command
if ! command -v dig &> /dev/null; then
    echo -e "${RED}Error: 'dig' command not found.${NC}"
    echo "Install it with:"
    echo "  Ubuntu/Debian: sudo apt install dnsutils"
    echo "  CentOS/RHEL:   sudo yum install bind-utils"
    echo "  macOS:         brew install bind"
    exit 1
fi

# Domain to resolve
TEST_DOMAIN="google.com"
TRIES=3

# DNS Providers: "IP|Name"
DNS_SERVERS=(
    "8.8.8.8|Google Public DNS (Primary)"
    "8.8.4.4|Google Public DNS (Secondary)"
    "1.1.1.1|Cloudflare (Primary)"
    "1.0.0.1|Cloudflare (Secondary)"
    "9.9.9.9|Quad9 (Primary)"
    "149.112.112.112|Quad9 (Secondary)"
    "208.67.222.222|OpenDNS (Primary)"
    "208.67.220.220|OpenDNS (Secondary)"
    "94.140.14.14|AdGuard DNS (Primary)"
    "94.140.15.15|AdGuard DNS (Secondary)"
    "185.228.168.9|CleanBrowsing (Primary)"
    "185.228.169.9|CleanBrowsing (Secondary)"
    "76.76.19.19|Alternate DNS (Primary)"
    "76.223.122.150|Alternate DNS (Secondary)"
    "64.6.64.6|Verisign DNS (Primary)"
    "64.6.65.6|Verisign DNS (Secondary)"
    "8.26.56.26|Comodo Secure DNS (Primary)"
    "8.20.247.20|Comodo Secure DNS (Secondary)"
    "9.9.9.10|Quad9 Unsecured"
    "9.9.9.11|Quad9 ECS Support"
    "1.1.1.2|Cloudflare Malware Blocking"
    "1.1.1.3|Cloudflare Malware+Adult Block"
    "208.67.222.123|OpenDNS FamilyShield (Primary)"
    "208.67.220.123|OpenDNS FamilyShield (Sec)"
    "94.140.14.15|AdGuard Family Protection"
    "94.140.14.140|AdGuard Non-filtering"
    "77.88.8.8|Yandex DNS (Primary)"
    "77.88.8.1|Yandex DNS (Secondary)"
    "77.88.8.88|Yandex Safe DNS"
    "77.88.8.7|Yandex Family DNS"
    "156.154.70.1|Neustar UltraDNS (Primary)"
    "156.154.71.1|Neustar UltraDNS (Secondary)"
    "156.154.70.2|Neustar Threat Protection"
    "156.154.71.2|Neustar Threat Protect (Sec)"
    "156.154.70.3|Neustar Family Secure"
    "156.154.71.3|Neustar Family Secure (Sec)"
    "45.90.28.0|NextDNS (Primary)"
    "45.90.30.0|NextDNS (Secondary)"
    "76.76.2.0|Control D (Primary)"
    "76.76.10.0|Control D (Secondary)"
    "185.253.5.0|DNSlify (Primary)"
    "185.253.5.1|DNSlify (Secondary)"
    "114.114.114.114|114DNS China (Primary)"
    "114.114.115.115|114DNS China (Secondary)"
    "223.5.5.5|AliDNS (Primary)"
    "223.6.6.6|AliDNS (Secondary)"
    "119.29.29.29|DNSPod China"
    "101.226.4.6|360 Secure DNS China"
    "198.101.242.72|Alternate DNS v2"
    "176.103.130.130|AdGuard Old (Primary)"
)

TOTAL=${#DNS_SERVERS[@]}
RESULTS_FILE=$(mktemp)
SORTED_FILE=$(mktemp)

echo ""
echo -e "${CYAN}${BOLD}╔══════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}${BOLD}║         DNS BENCHMARK - $TOTAL Free DNS Providers          ║${NC}"
echo -e "${CYAN}${BOLD}╠══════════════════════════════════════════════════════════╣${NC}"
echo -e "${CYAN}${BOLD}║  Test Domain : $TEST_DOMAIN                               ║${NC}"
echo -e "${CYAN}${BOLD}║  Attempts    : $TRIES per server (average)                  ║${NC}"
echo -e "${CYAN}${BOLD}║  Date        : $(date '+%Y-%m-%d %H:%M:%S')                    ║${NC}"
echo -e "${CYAN}${BOLD}╚══════════════════════════════════════════════════════════╝${NC}"
echo ""

count=0
for entry in "${DNS_SERVERS[@]}"; do
    IP="${entry%%|*}"
    NAME="${entry##*|}"
    count=$((count + 1))

    printf "\r${YELLOW}[%d/%d] Testing: %-45s${NC}" "$count" "$TOTAL" "$NAME"

    total_time=0
    success=0

    for i in $(seq 1 $TRIES); do
        result=$(dig @"$IP" "$TEST_DOMAIN" +noall +stats +time=3 +tries=1 2>/dev/null | grep "Query time" | awk '{print $4}')
        if [ -n "$result" ]; then
            total_time=$((total_time + result))
            success=$((success + 1))
        fi
    done

    if [ "$success" -gt 0 ]; then
        avg=$((total_time / success))
        echo "${avg}|${IP}|${NAME}|${success}/${TRIES}" >> "$RESULTS_FILE"
    else
        echo "9999|${IP}|${NAME}|TIMEOUT" >> "$RESULTS_FILE"
    fi
done

echo ""
echo ""

# Sort results
sort -t'|' -k1 -n "$RESULTS_FILE" > "$SORTED_FILE"

# Print table header
echo -e "${CYAN}${BOLD}╔══════════════════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}${BOLD}║                          RESULTS (Sorted by Speed)                         ║${NC}"
echo -e "${CYAN}${BOLD}╠═════╦════════════════╦══════════════════════════════════════╦═══════╦═══════╣${NC}"
printf "${CYAN}${BOLD}║${NC} ${BOLD}%-3s${NC} ${CYAN}${BOLD}║${NC} ${BOLD}%-14s${NC} ${CYAN}${BOLD}║${NC} ${BOLD}%-36s${NC} ${CYAN}${BOLD}║${NC} ${BOLD}%-5s${NC} ${CYAN}${BOLD}║${NC} ${BOLD}%-5s${NC} ${CYAN}${BOLD}║${NC}\n" "#" "IP" "Provider" "Avg" "OK"
echo -e "${CYAN}${BOLD}╠═════╬════════════════╬══════════════════════════════════════╬═══════╬═══════╣${NC}"

# Print each row - read from file (not piped) to avoid subshell issues
rank=0
while IFS='|' read -r avg ip name ok_val; do
    rank=$((rank + 1))

    if [ "$avg" = "9999" ]; then
        color="$RED"
        avg_display="FAIL"
    elif [ "$avg" -le 20 ]; then
        color="$GREEN"
        avg_display="${avg} ms"
    elif [ "$avg" -le 50 ]; then
        color="$YELLOW"
        avg_display="${avg} ms"
    else
        color="$RED"
        avg_display="${avg} ms"
    fi

    printf "${CYAN}${BOLD}║${NC} ${color}%-3s${NC} ${CYAN}${BOLD}║${NC} ${color}%-14s${NC} ${CYAN}${BOLD}║${NC} ${color}%-36s${NC} ${CYAN}${BOLD}║${NC} ${color}%-5s${NC} ${CYAN}${BOLD}║${NC} ${color}%-5s${NC} ${CYAN}${BOLD}║${NC}\n" \
        "$rank" "$ip" "$name" "$avg_display" "$ok_val"
done < "$SORTED_FILE"

echo -e "${CYAN}${BOLD}╚═════╩════════════════╩══════════════════════════════════════╩═══════╩═══════╝${NC}"
echo ""

# Show top 3 fastest
echo -e "${GREEN}${BOLD}🏆 TOP 3 FASTEST DNS SERVERS FOR YOUR LOCATION:${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
toprank=0
while IFS='|' read -r avg ip name ok_val; do
    toprank=$((toprank + 1))
    if [ "$avg" != "9999" ]; then
        case $toprank in
            1) medal="🥇" ;;
            2) medal="🥈" ;;
            3) medal="🥉" ;;
        esac
        echo -e "${GREEN}  ${medal}  #${toprank}  ${BOLD}${ip}${NC}${GREEN}  (${avg} ms) - ${name}${NC}"
    else
        echo -e "${RED}  #${toprank}  ${ip}  (FAILED) - ${name}${NC}"
    fi
done < <(head -3 "$SORTED_FILE")

echo ""
echo -e "${CYAN}${BOLD}💡 How to set your DNS:${NC}"
echo -e "${CYAN}  Linux   : Edit /etc/resolv.conf or use nmcli${NC}"
echo -e "${CYAN}  macOS   : System Settings > Network > DNS${NC}"
echo -e "${CYAN}  Windows : Network adapter > IPv4 > DNS${NC}"
echo -e "${CYAN}  Router  : Change DNS in router admin panel${NC}"
echo ""

# Cleanup
rm -f "$RESULTS_FILE" "$SORTED_FILE"
