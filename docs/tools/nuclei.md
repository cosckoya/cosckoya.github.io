---
title: Nuclei
description: Template-based vulnerability scanner - modern, fast, community-driven
tags:
  - security
  - vulnerability-scanner
  - automation
  - pentesting
---

# Nuclei

Modern vulnerability scanner built on YAML templates. Fast as hell, community maintains 5000+ templates, finds real vulns. Part of ProjectDiscovery's suite. Nikto wishes it was this fast.

______________________________________________________________________

## Quick Hits

=== "🎯 Essential Commands"

    ```bash
    # Basic scan
    nuclei -u https://target.com

    # Scan multiple targets
    nuclei -l targets.txt

    # Scan with specific templates
    nuclei -u target.com -t cves/

    # Scan with severity filter
    nuclei -u target.com -severity critical,high

    # Update templates
    nuclei -update-templates

    # List available templates
    nuclei -tl

    # Search templates
    nuclei -tl -tags cve,rce

    # Run specific template
    nuclei -u target.com -t cves/2021/CVE-2021-44228.yaml

    # Output to file
    nuclei -u target.com -o results.txt

    # JSON output (for parsing)
    nuclei -u target.com -json -o results.json

    # Silent mode (only findings)
    nuclei -u target.com -silent
    ```

    **Real talk:**

    - 5000+ community templates (CVEs, misconfigs, exposed panels)
    - Updates daily - new CVEs get templates same day
    - Way faster than Nikto/OpenVAS
    - Low false positive rate

=== "⚡ Common Patterns"

    ```bash
    # Full CVE scan
    nuclei -u target.com -t cves/ -severity critical,high,medium

    # Scan for exposed panels
    nuclei -u target.com -t exposed-panels/

    # Misconfiguration check
    nuclei -u target.com -t misconfiguration/

    # Scan with custom headers
    nuclei -u target.com -H "Authorization: Bearer TOKEN"

    # Scan through proxy
    nuclei -u target.com -proxy http://127.0.0.1:8080

    # Rate limiting (requests per second)
    nuclei -u target.com -rate-limit 100

    # Scan with multiple workers
    nuclei -u target.com -c 50

    # Passive scan only (no intrusive checks)
    nuclei -u target.com -passive

    # Resume failed scans
    nuclei -u target.com -resume scan.txt

    # Exclude specific templates
    nuclei -u target.com -exclude-templates cves/2020/
    ```

=== "🔥 Pro Tips & Gotchas"

    - **Speed:** 50x faster than Nikto, uses Go concurrency
    - **Templates:** Update templates daily (`-update-templates`)
    - **Custom templates:** Write your own YAML templates for unique checks
    - **Rate limiting:** Use `-rate-limit` to avoid triggering WAF
    - **Integration:** Works with subfinder, httpx, other ProjectDiscovery tools
    - **CI/CD:** Perfect for automated security checks in pipelines
    - **False positives:** Way lower than Nikto, but still verify findings
    - **Template quality:** Community templates vary, test before production use
    - **Network noise:** Less noisy than Nikto but still detectable
    - **When NOT to use:** Compliance scans requiring specific standards (use Nessus)

______________________________________________________________________

## Learning Paths

### 🎓 Free Resources

```
- **[Nuclei Official Docs](https://nuclei.projectdiscovery.io/)** - Comprehensive documentation
```

- **[Nuclei Templates](https://github.com/projectdiscovery/nuclei-templates)** - All 5000+ templates with examples
- **[ProjectDiscovery YouTube](https://www.youtube.com/c/ProjectDiscovery)** - Official tutorials and demos
- **[Nuclei Template Guide](https://nuclei.projectdiscovery.io/templating-guide/)** - Learn to write templates
- **[Bug Bounty with Nuclei](https://www.youtube.com/watch?v=Y4_R6fAMFio)** - Real-world usage

### 🧪 Interactive Labs

- **[TryHackMe Nuclei Room](https://tryhackme.com/)** - Hands-on practice
- **[HackTheBox](https://www.hackthebox.com/)** - Use Nuclei on HTB boxes
- **[PortSwigger Academy](https://portswigger.net/web-security)** - Test Nuclei templates

### 🚀 Projects to Build

- **Beginner:** Scan bug bounty target, document findings
- **Intermediate:** Write custom Nuclei templates for your app stack
- **Advanced:** Build automated recon → Nuclei → Slack notification pipeline

______________________________________________________________________

## Community Pulse

### 🐦 Who to Follow

**Twitter/X:**

- [@pdiscoveryio](https://twitter.com/pdiscoveryio) - ProjectDiscovery official
- [@Ice3man543](https://twitter.com/Ice3man543) - Nuclei creator
- [@geekboy_x](https://twitter.com/geekboy_x) - ProjectDiscovery team
- [@TomNomNom](https://twitter.com/TomNomNom) - Recon tools creator
- [@jhaddix](https://twitter.com/jhaddix) - Bug bounty legend, uses Nuclei heavily

**YouTube:**

- [ProjectDiscovery](https://www.youtube.com/c/ProjectDiscovery) - Official channel
- [Nahamsec](https://www.youtube.com/c/Nahamsec) - Bug bounty with Nuclei
- [STÖK](https://www.youtube.com/c/STOKfredrik) - Web security and tooling
- [InsiderPhD](https://www.youtube.com/c/InsiderPhD) - Bug bounty tutorials

### 💬 Active Communities

- **[ProjectDiscovery Discord](https://discord.gg/projectdiscovery)** - 20k+ members, active support
- **[r/bugbounty](https://reddit.com/r/bugbounty)** - Bug bounty community
- **[Nuclei GitHub Discussions](https://github.com/projectdiscovery/nuclei/discussions)** - Technical Q&A
- **[Bug Bounty Forum](https://bugbountyforum.com/)** - Tool discussions

### 🎙️ Podcasts & Newsletters

- **[Critical Thinking](https://www.criticalthinkingpodcast.io/)** - Bug bounty podcast
- **[The Bug Bounty Podcast](https://anchor.fm/bugbountypodcast)** - Hunter interviews
- **[Intigriti Bug Bytes](https://blog.intigriti.com/category/bugbytes/)** - Weekly security newsletter
- **[Pentester Land Newsletter](https://pentester.land/)** - Bug bounty writeups

______________________________________________________________________

## Worth Checking

<div class="grid cards" markdown>

- 📚 __Official Stuff__

    ______________________________________________________________________

    [Nuclei GitHub](https://github.com/projectdiscovery/nuclei)

    [Nuclei Docs](https://nuclei.projectdiscovery.io/)

    [Template Repo](https://github.com/projectdiscovery/nuclei-templates)

    [ProjectDiscovery Blog](https://blog.projectdiscovery.io/)

- 🧪 __Hands-on__

    ______________________________________________________________________

    [Template Editor](https://nuclei.projectdiscovery.io/templating-guide/)

    [Nuclei Playground](https://nuclei.projectdiscovery.io/playground/)

    [DVWA](http://www.dvwa.co.uk/)

- 💻 __Real Examples__

    ______________________________________________________________________

    [Nuclei Templates](https://github.com/projectdiscovery/nuclei-templates)

    [Custom Templates Collection](https://github.com/topics/nuclei-templates)

    [Bug Bounty Automation](https://github.com/nahamsec/bbht)

- 🔥 __Deep Dives__

    ______________________________________________________________________

    [Writing Nuclei Templates](https://blog.projectdiscovery.io/writing-nuclei-templates-template-matchers/)

    [Nuclei + CI/CD](https://blog.projectdiscovery.io/nuclei-github-action/)

    [Bug Bounty Methodology](https://www.youtube.com/watch?v=Y4_R6fAMFio)

- 🛠️ __ProjectDiscovery Suite__

    ______________________________________________________________________

    [subfinder](https://github.com/projectdiscovery/subfinder)

    [httpx](https://github.com/projectdiscovery/httpx)

    [katana](https://github.com/projectdiscovery/katana)

    [naabu](https://github.com/projectdiscovery/naabu)

- 📰 __Updates__

    ______________________________________________________________________

    [Nuclei Releases](https://github.com/projectdiscovery/nuclei/releases)

    [Template Updates](https://github.com/projectdiscovery/nuclei-templates/releases)

    [ProjectDiscovery Blog](https://blog.projectdiscovery.io/)

</div>

______________________________________________________________________

## Installation & Setup

### Install Nuclei

```bash
# Linux/macOS (recommended)
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest

# Homebrew
brew install nuclei

# Docker
docker pull projectdiscovery/nuclei:latest
docker run projectdiscovery/nuclei -h

# Manual download
wget https://github.com/projectdiscovery/nuclei/releases/download/v3.x.x/nuclei_3.x.x_linux_amd64.zip
unzip nuclei_3.x.x_linux_amd64.zip
sudo mv nuclei /usr/local/bin/

# Verify installation
nuclei -version

# Install/update templates
nuclei -update-templates
```

### Configuration

````bash
# Config file location
~/.config/nuclei/config.yaml

# Example config:
```yaml
# Rate limiting
rate-limit: 150

# Timeout settings
timeout: 5
retries: 1

# Template settings
update-templates: true
templates-directory: ~/nuclei-templates

# Output
silent: false
verbose: false
json: false

# Network
proxy: ""
http-proxy: ""
````

### Template Structure

```yaml
# Example custom template
id: custom-check-example

info:
  name: Custom Security Check
  author: yourusername
  severity: high
  description: Checks for specific vulnerability
  tags: custom,webapp

requests:
  - method: GET
    path:
      - "{{BaseURL}}/admin/config.php"

    matchers-condition: and
    matchers:
      - type: status
        status:
          - 200

      - type: word
        words:
          - "database_password"
          - "api_key"
        condition: or
```

______________________________________________________________________

## Common Workflows

### Basic Vulnerability Scan

```bash
# 1. Update templates
nuclei -update-templates

# 2. Scan for critical/high severity
nuclei -u https://target.com -severity critical,high

# 3. Review findings
cat nuclei-output.txt
```

### Bug Bounty Recon Pipeline

```bash
# 1. Subdomain enumeration
subfinder -d target.com -o subdomains.txt

# 2. Probe for live hosts
httpx -l subdomains.txt -o live-hosts.txt

# 3. Nuclei scan
nuclei -l live-hosts.txt -t cves/ -t exposures/ -severity critical,high,medium -o findings.txt

# 4. Filter interesting findings
cat findings.txt | grep -E "\[critical\]|\[high\]"
```

### CI/CD Security Check

```bash
# GitHub Actions example
- name: Run Nuclei
  run: |
    nuclei -u ${{ secrets.STAGING_URL }} \
    -t cves/ \
    -severity critical,high \
    -json -o nuclei-results.json

    if [ -s nuclei-results.json ]; then
      echo "Vulnerabilities found!"
      exit 1
    fi
```

### Custom Template Scanning

```bash
# 1. Create custom template directory
mkdir ~/custom-templates

# 2. Write custom checks
vim ~/custom-templates/my-check.yaml

# 3. Scan with custom templates
nuclei -u target.com -t ~/custom-templates/

# 4. Or mix with community templates
nuclei -u target.com -t ~/custom-templates/ -t cves/
```

### Mass Scanning

```bash
# Scan multiple targets efficiently
nuclei -l targets.txt \
  -t cves/ -t exposures/ \
  -severity critical,high,medium \
  -c 100 \
  -rate-limit 300 \
  -json -o mass-scan-results.json
```

______________________________________________________________________

**Last Updated:** 2026-01-14 **Vibe Check:** 🔥 **Hyped** - Nuclei is the modern standard for automated vuln scanning. Fast, accurate, community-driven. ProjectDiscovery tools are dominating bug bounty and recon space.
