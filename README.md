# 🚀 DNS Benchmark

A lightweight, portable Bash script that benchmarks **50 free public DNS providers** from your location and ranks them by speed. Find the fastest DNS server for your internet connection in under 3 minutes.

![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)
![Shell: Bash](https://img.shields.io/badge/Shell-Bash%20%2F%20Zsh-blue.svg)
![Platform: Linux | macOS](https://img.shields.io/badge/Platform-Linux%20%7C%20macOS-lightgrey.svg)

---

## ✨ Features

- Tests **50 public DNS servers** including Google, Cloudflare, Quad9, OpenDNS, AdGuard, Yandex, Neustar, NextDNS, Control D, and more
- Measures average response time over multiple attempts
- Color-coded results: 🟢 Fast (≤20ms) · 🟡 Medium (≤50ms) · 🔴 Slow (>50ms) / Failed
- Sorted ranking table from fastest to slowest
- Highlights your **Top 3 fastest** DNS servers
- Compatible with both **Bash** and **Zsh**
- Zero dependencies beyond `dig` (part of `dnsutils` / `bind-utils`)
- No installation required — single file, runs anywhere

---

## 📋 Prerequisites

The script requires the `dig` command-line tool.

| OS | Install Command |
|----|----------------|
| Ubuntu / Debian | `sudo apt install dnsutils` |
| CentOS / RHEL / Fedora | `sudo yum install bind-utils` |
| Arch Linux | `sudo pacman -S bind` |
| macOS (Homebrew) | `brew install bind` |
| macOS (built-in) | Usually pre-installed |

Verify it's available:

```bash
dig -v
```

---

## 🚀 Quick Start

### Option 1: Clone & Run

```bash
git clone https://github.com/YOUR_USERNAME/dns-benchmark.git
cd dns-benchmark
chmod +x dns_benchmark.sh
./dns_benchmark.sh
```

### Option 2: Download & Run

```bash
curl -O https://raw.githubusercontent.com/YOUR_USERNAME/dns-benchmark/main/dns_benchmark.sh
chmod +x dns_benchmark.sh
./dns_benchmark.sh
```

### Option 3: One-Liner

```bash
curl -sL https://raw.githubusercontent.com/YOUR_USERNAME/dns-benchmark/main/dns_benchmark.sh | bash
```

---

## 📖 Usage

```bash
./dns_benchmark.sh
```

The script takes approximately **2–3 minutes** to complete. It will:

1. Test each of the 50 DNS servers by resolving `google.com`
2. Send 3 queries per server and calculate the average response time
3. Display a sorted results table
4. Show your Top 3 fastest DNS providers

### Example Output

```
╔══════════════════════════════════════════════════════════╗
║         DNS BENCHMARK - 50 Free DNS Providers           ║
╠══════════════════════════════════════════════════════════╣
║  Test Domain : google.com                               ║
║  Attempts    : 3 per server (average)                   ║
║  Date        : 2026-02-05 20:45:18                      ║
╚══════════════════════════════════════════════════════════╝

╔══════════════════════════════════════════════════════════════════════════════╗
║                          RESULTS (Sorted by Speed)                         ║
╠═════╦════════════════╦══════════════════════════════════════╦═══════╦═══════╣
║ #   ║ IP             ║ Provider                             ║ Avg   ║ OK    ║
╠═════╬════════════════╬══════════════════════════════════════╬═══════╬═══════╣
║ 1   ║ 1.1.1.1        ║ Cloudflare (Primary)                 ║ 4 ms  ║ 3/3   ║
║ 2   ║ 1.0.0.1        ║ Cloudflare (Secondary)               ║ 5 ms  ║ 3/3   ║
║ 3   ║ 8.8.8.8        ║ Google Public DNS (Primary)          ║ 8 ms  ║ 3/3   ║
║ ... ║ ...            ║ ...                                  ║ ...   ║ ...   ║
╚═════╩════════════════╩══════════════════════════════════════╩═══════╩═══════╝

🏆 TOP 3 FASTEST DNS SERVERS FOR YOUR LOCATION:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  🥇  #1  1.1.1.1  (4 ms) - Cloudflare (Primary)
  🥈  #2  1.0.0.1  (5 ms) - Cloudflare (Secondary)
  🥉  #3  8.8.8.8  (8 ms) - Google Public DNS (Primary)
```

> **Note:** Results vary based on your ISP, geographic location, and network conditions. Run the test multiple times for more reliable results.

---

## 🌐 DNS Providers Tested (50)

| # | Provider | Primary | Secondary |
|---|----------|---------|-----------|
| 1 | Google Public DNS | `8.8.8.8` | `8.8.4.4` |
| 2 | Cloudflare | `1.1.1.1` | `1.0.0.1` |
| 3 | Cloudflare (Malware) | `1.1.1.2` | `1.1.1.3` |
| 4 | Quad9 | `9.9.9.9` | `149.112.112.112` |
| 5 | Quad9 (Unsecured) | `9.9.9.10` | `9.9.9.11` |
| 6 | OpenDNS | `208.67.222.222` | `208.67.220.220` |
| 7 | OpenDNS FamilyShield | `208.67.222.123` | `208.67.220.123` |
| 8 | AdGuard DNS | `94.140.14.14` | `94.140.15.15` |
| 9 | AdGuard (Family) | `94.140.14.15` | `94.140.14.140` |
| 10 | AdGuard (Old) | `176.103.130.130` | — |
| 11 | CleanBrowsing | `185.228.168.9` | `185.228.169.9` |
| 12 | Alternate DNS | `76.76.19.19` | `76.223.122.150` |
| 13 | Verisign | `64.6.64.6` | `64.6.65.6` |
| 14 | Comodo Secure | `8.26.56.26` | `8.20.247.20` |
| 15 | Yandex DNS | `77.88.8.8` | `77.88.8.1` |
| 16 | Yandex (Safe) | `77.88.8.88` | `77.88.8.7` |
| 17 | Neustar UltraDNS | `156.154.70.1` | `156.154.71.1` |
| 18 | Neustar (Threat) | `156.154.70.2` | `156.154.71.2` |
| 19 | Neustar (Family) | `156.154.70.3` | `156.154.71.3` |
| 20 | NextDNS | `45.90.28.0` | `45.90.30.0` |
| 21 | Control D | `76.76.2.0` | `76.76.10.0` |
| 22 | DNSlify | `185.253.5.0` | `185.253.5.1` |
| 23 | 114DNS (China) | `114.114.114.114` | `114.114.115.115` |
| 24 | AliDNS (China) | `223.5.5.5` | `223.6.6.6` |
| 25 | DNSPod (China) | `119.29.29.29` | — |
| 26 | 360 Secure (China) | `101.226.4.6` | — |
| 27 | Alternate DNS v2 | `198.101.242.72` | — |

---

## ⚙️ How to Apply Your Results

Once you've found the fastest DNS, set it on your device or router.

### Linux

```bash
# Temporary (resets on reboot)
sudo sh -c 'echo "nameserver 1.1.1.1" > /etc/resolv.conf'

# Permanent (NetworkManager)
nmcli con mod "YOUR_CONNECTION" ipv4.dns "1.1.1.1 1.0.0.1"
nmcli con mod "YOUR_CONNECTION" ipv4.ignore-auto-dns yes
nmcli con down "YOUR_CONNECTION" && nmcli con up "YOUR_CONNECTION"

# Permanent (systemd-resolved)
sudo nano /etc/systemd/resolved.conf
# Add: DNS=1.1.1.1 1.0.0.1
sudo systemctl restart systemd-resolved
```

### macOS

```
System Settings → Network → Wi-Fi (or Ethernet) → Details → DNS
```

Remove existing entries and add your fastest DNS IPs.

### Windows

```
Settings → Network & Internet → Wi-Fi → Hardware Properties → Edit DNS
```

Or via PowerShell (Admin):

```powershell
Set-DnsClientServerAddress -InterfaceAlias "Wi-Fi" -ServerAddresses ("1.1.1.1","1.0.0.1")
```

### Router (Recommended)

Applying DNS at the router level covers all devices on your network.

1. Open your router's admin panel (usually `192.168.1.1` or `192.168.0.1`)
2. Find **DNS Settings** (often under WAN, Internet, or DHCP settings)
3. Enter your Primary and Secondary DNS
4. Save and reboot the router

---

## 🔒 DNS Privacy: DoH & DoT

For added privacy, consider using encrypted DNS protocols. Most fast providers support them:

| Provider | DNS-over-HTTPS (DoH) | DNS-over-TLS (DoT) |
|----------|---------------------|---------------------|
| Cloudflare | `https://cloudflare-dns.com/dns-query` | `1dot1dot1dot1.cloudflare-dns.com` |
| Google | `https://dns.google/dns-query` | `dns.google` |
| Quad9 | `https://dns.quad9.net/dns-query` | `dns.quad9.net` |
| AdGuard | `https://dns.adguard-dns.com/dns-query` | `dns.adguard-dns.com` |
| NextDNS | `https://dns.nextdns.io` | `dns.nextdns.io` |

You can enable DoH directly in most modern browsers (Firefox, Chrome, Edge, Brave) under privacy/security settings.

---

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

- **Add more DNS providers** — edit the `DNS_SERVERS` array in the script
- **Improve compatibility** — test on different shells and platforms
- **Add features** — IPv6 support, custom test domains, CSV export, etc.

### Steps

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/add-new-dns`
3. Commit your changes: `git commit -m "Add XYZ DNS provider"`
4. Push to the branch: `git push origin feature/add-new-dns`
5. Open a Pull Request

---

## 📄 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

---

## ⭐ Show Your Support

If this tool helped you find a faster DNS, give it a ⭐ on GitHub!

---

<p align="center">
  Made with ❤️ for faster internet
</p>
