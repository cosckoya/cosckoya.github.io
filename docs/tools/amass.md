---
title: Amass
description: OWASP subdomain enumeration and asset discovery - the recon tool that finds what others miss
tags:
  - security
  - reconnaissance
  - subdomain-enumeration
  - osint
---

# Amass

OWASP's network mapping and attack surface discovery tool. Finds subdomains others miss using 100+ data sources. Slow but thorough. Bug bounty hunters' secret weapon for initial recon.

______________________________________________________________________

## Quick Hits

=== "🎯 Essential Commands"

    ```bash
    # Basic subdomain enumeration
    amass enum -d target.com

    # Passive enumeration only (no DNS queries)
    amass enum -passive -d target.com

    # Active enumeration (DNS brute force + scraping)
    amass enum -active -d target.com

    # Output to file
    amass enum -d target.com -o subdomains.txt

    # Multiple domains
    amass enum -d target1.com,target2.com

    # Use config file (for API keys)
    amass enum -d target.com -config config.ini

    # Visualize results
    amass viz -d3 -d target.com

    # Track changes over time
    amass track -d target.com

    # Intel gathering on organization
    amass intel -org "Company Name"

    # Reverse WHOIS lookup
    amass intel -whois -d target.com
    ```

    **Real talk:**

    - Integrates with 100+ data sources (cert transparency, APIs, DNS)
    - Passive mode is stealthy, active mode is loud
    - Can take hours for large orgs
    - Best results with API keys configured

=== "⚡ Common Patterns"

    ```bash
    # Full recon with all techniques
    amass enum -active -brute -d target.com -o full-recon.txt

    # Passive recon with multiple sources
    amass enum -passive -src -d target.com

    # DNS brute force with custom wordlist
    amass enum -d target.com -brute -w /path/to/wordlist.txt

    # Enumerate with IP resolution
    amass enum -d target.com -ip -o subdomains-with-ips.txt

    # ASN discovery
    amass intel -asn 12345

    # CIDR range discovery
    amass intel -cidr 192.168.1.0/24

    # Use all available DNS resolvers
    amass enum -d target.com -rf resolvers.txt

    # Limit scope to specific subdomains
    amass enum -d target.com -include api.target.com,admin.target.com

    # Exclude specific subdomains
    amass enum -d target.com -exclude test.target.com

    # Increase verbosity for debugging
    amass enum -v -d target.com
    ```

=== "🔥 Pro Tips & Gotchas"

    - **API keys:** Configure API keys for better results (config.ini)
    - **Speed:** Passive is fast (minutes), active is slow (hours)
    - **Rate limiting:** Amass respects rate limits, don't be impatient
    - **Resolvers:** Use custom DNS resolvers for better success rate
    - **Integration:** Pipe output to httpx, nuclei, nmap for full recon
    - **Stealth:** Passive mode won't touch target infrastructure
    - **Database:** Amass stores results in local DB for tracking
    - **Visualization:** D3 graphs are cool but resource-intensive
    - **Accuracy:** Higher than subfinder, but slower
    - **When NOT to use:** Time-sensitive recon (use subfinder instead)

______________________________________________________________________

## Learning Paths

### 🎓 Free Resources

- **[Amass Official Docs](https://github.com/owasp-amass/amass/blob/master/doc/user_guide.md)** - Comprehensive user guide
- **[OWASP Amass Page](https://owasp.org/www-project-amass/)** - Project overview
- **[The Cyber Mentor Tutorial](https://www.youtube.com/watch?v=mEQnVkSG19M)** - Practical walkthrough
- **[Bug Bounty Recon with Amass](https://www.youtube.com/watch?v=eNo0_66hD2U)** - Real-world usage
- **[Amass Scripting Guide](https://github.com/owasp-amass/amass/blob/master/doc/scripting.md)** - Advanced automation

### 🧪 Interactive Labs

- **[TryHackMe Recon Room](https://tryhackme.com/)** - Subdomain enumeration practice
- **[HackTheBox](https://www.hackthebox.com/)** - Use on HTB targets
- **[PentesterLab](https://pentesterlab.com/)** - Web recon exercises

### 🚀 Projects to Build

- **Beginner:** Enumerate bug bounty target, compare with subfinder results
- **Intermediate:** Build automated recon pipeline (amass → httpx → nuclei → report)
- **Advanced:** Create monitoring system that tracks new subdomains daily

______________________________________________________________________

## Community Pulse

### 🐦 Who to Follow

**Twitter/X:**

- [@jeff_foley](https://twitter.com/jeff_foley) - Amass creator
- [@owasp_amass](https://twitter.com/owasp_amass) - Official OWASP account
- [@TomNomNom](https://twitter.com/TomNomNom) - Recon tools expert
- [@jhaddix](https://twitter.com/jhaddix) - Bug bounty methodology
- [@nahamsec](https://twitter.com/nahamsec) - Recon automation expert

**YouTube:**

- [The Cyber Mentor](https://www.youtube.com/c/TheCyberMentor) - Pentesting courses
- [Nahamsec](https://www.youtube.com/c/Nahamsec) - Bug bounty recon
- [STÖK](https://www.youtube.com/c/STOKfredrik) - Web security
- [InsiderPhD](https://www.youtube.com/c/InsiderPhD) - Bug bounty tutorials

### 💬 Active Communities

- **[r/bugbounty](https://reddit.com/r/bugbounty)** - Bug bounty community
- **[OWASP Slack](https://owasp.org/slack/invite)** - #project-amass channel
- **[Bug Bounty Forum](https://bugbountyforum.com/)** - Recon discussions
- **[Amass GitHub Discussions](https://github.com/owasp-amass/amass/discussions)** - Technical Q&A

### 🎙️ Podcasts & Newsletters

- **[Critical Thinking Podcast](https://www.criticalthinkingpodcast.io/)** - Bug bounty interviews
- **[Darknet Diaries](https://darknetdiaries.com/)** - Security stories
- **[Intigriti Bug Bytes](https://blog.intigriti.com/category/bugbytes/)** - Weekly newsletter
- **[Pentester Land](https://pentester.land/)** - Bug bounty writeups

______________________________________________________________________

## Worth Checking

<div class="grid cards" markdown>

- 📚 __Official Stuff__

    ______________________________________________________________________

    [Amass GitHub](https://github.com/owasp-amass/amass)

    [User Guide](https://github.com/owasp-amass/amass/blob/master/doc/user_guide.md)

    [OWASP Project Page](https://owasp.org/www-project-amass/)

    [API Integration Guide](https://github.com/owasp-amass/amass/blob/master/doc/api.md)

- 🧪 __Hands-on__

    ______________________________________________________________________

    [Amass Tutorial](https://www.youtube.com/watch?v=mEQnVkSG19M)

    [Bug Bounty Recon](https://www.youtube.com/watch?v=eNo0_66hD2U)

    [TryHackMe](https://tryhackme.com/)

- 💻 __Real Examples__

    ______________________________________________________________________

    [Recon Automation Scripts](https://github.com/nahamsec/bbht)

    [Amass + Subfinder Comparison](https://github.com/topics/subdomain-enumeration)

    [Bug Bounty Methodology](https://github.com/jhaddix/tbhm)

- 🔥 __Deep Dives__

    ______________________________________________________________________

    [Amass Scripting](https://github.com/owasp-amass/amass/blob/master/doc/scripting.md)

    [Advanced Recon Techniques](https://www.youtube.com/watch?v=F9SHy2p1R1E)

    [Asset Discovery Guide](https://blog.projectdiscovery.io/)

- 🛠️ __Related Tools__

    ______________________________________________________________________

    [subfinder](https://github.com/projectdiscovery/subfinder)

    [assetfinder](https://github.com/tomnomnom/assetfinder)

    [httpx](https://github.com/projectdiscovery/httpx)

    [dnsx](https://github.com/projectdiscovery/dnsx)

- 📰 __Updates__

    ______________________________________________________________________

    [Amass Releases](https://github.com/owasp-amass/amass/releases)

    [r/bugbounty](https://reddit.com/r/bugbounty)

    [OWASP News](https://owasp.org/news/)

</div>

______________________________________________________________________

## Installation & Setup

### Install Amass

```bash
# Precompiled binary (recommended)
# Download from: https://github.com/owasp-amass/amass/releases

# Linux
wget https://github.com/owasp-amass/amass/releases/download/v4.x.x/amass_Linux_amd64.zip
unzip amass_Linux_amd64.zip
sudo mv amass /usr/local/bin/

# macOS (Homebrew)
brew install amass

# Go install
go install -v github.com/owasp-amass/amass/v4/...@master

# Docker
docker pull caffix/amass
docker run caffix/amass enum -d target.com

# Verify installation
amass -version
```

### Configuration (API Keys)

```bash
# Create config file
mkdir -p ~/.config/amass
vim ~/.config/amass/config.ini
```

```ini
# Example config.ini with API keys

[data_sources]
# Free APIs (no key required)
[data_sources.AlienVault]

[data_sources.Censys]
[data_sources.Censys.Credentials]
apikey = YOUR_API_KEY
secret = YOUR_SECRET

[data_sources.SecurityTrails]
[data_sources.SecurityTrails.Credentials]
apikey = YOUR_API_KEY

[data_sources.Shodan]
[data_sources.Shodan.Credentials]
apikey = YOUR_API_KEY

[data_sources.VirusTotal]
[data_sources.VirusTotal.Credentials]
apikey = YOUR_API_KEY

# GitHub (for github.io subdomains)
[data_sources.GitHub]
[data_sources.GitHub.accountname]
apikey = YOUR_GITHUB_TOKEN

# More data sources available:
# - BinaryEdge
# - BufferOver
# - C99
# - Cloudflare
# - Facebook
# - FullHunt
# - Hunter
# - PassiveTotal
# - Spyse
# - URLScan
# - WhoisXML
# - ZoomEye
```

### Custom Resolvers

```bash
# Create resolvers file
curl https://public-dns.info/nameservers.txt -o resolvers.txt

# Use with Amass
amass enum -d target.com -rf resolvers.txt
```

______________________________________________________________________

## Common Workflows

### Basic Subdomain Enumeration

```bash
# 1. Passive recon (stealth)
amass enum -passive -d target.com -o passive-subs.txt

# 2. Active recon (more thorough)
amass enum -active -d target.com -o active-subs.txt

# 3. Combine results
cat passive-subs.txt active-subs.txt | sort -u > all-subs.txt
```

### Full Recon Pipeline

```bash
# 1. Subdomain enumeration
amass enum -active -brute -d target.com -config ~/.config/amass/config.ini -o subs.txt

# 2. Resolve to IPs
amass enum -d target.com -ip -o subs-with-ips.txt

# 3. Probe for live hosts
httpx -l subs.txt -o live-hosts.txt

# 4. Scan with nuclei
nuclei -l live-hosts.txt -t cves/ -severity critical,high -o findings.txt
```

### ASN & CIDR Discovery

```bash
# 1. Find organization's ASNs
amass intel -org "Target Company" -o asns.txt

# 2. Enumerate domains from ASN
amass intel -asn 12345 -o domains-from-asn.txt

# 3. Get IP ranges
amass intel -asn 12345 -cidr
```

### Continuous Monitoring

```bash
# Initial scan
amass enum -d target.com -config ~/.config/amass/config.ini

# Track changes (run daily/weekly)
amass track -d target.com

# Visualize changes
amass viz -d3 -d target.com
```

### Bug Bounty Recon

```bash
# Step 1: Passive enum with all sources
amass enum -passive -src -d target.com -config ~/.config/amass/config.ini -o passive.txt

# Step 2: Active enum with brute force
amass enum -active -brute -w /usr/share/wordlists/subdomains.txt -d target.com -o active.txt

# Step 3: Merge and deduplicate
cat passive.txt active.txt | sort -u > all-subdomains.txt

# Step 4: Compare with previous scan
diff old-subdomains.txt all-subdomains.txt > new-subdomains.txt

# Step 5: Probe new subdomains
httpx -l new-subdomains.txt -silent -o new-live-hosts.txt

# Step 6: Screenshot and scan
cat new-live-hosts.txt | aquatone
nuclei -l new-live-hosts.txt -t cves/ -severity critical,high
```

______________________________________________________________________

**Last Updated:** 2026-01-14 **Vibe Check:** ✅ **Stable** - Amass is the gold standard for thorough subdomain enumeration. Not the fastest (that's subfinder), but finds what others miss. Essential for bug bounty recon.
