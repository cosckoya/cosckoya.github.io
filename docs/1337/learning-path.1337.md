---
title: Cybersecurity Learning Path
description: From zero to hired — realistic 12-18 month cybersecurity career path with phases, budgets, and action plans
---

# :lucide-graduation-cap: Cybersecurity Learning Path

From zero to hired — a realistic 12-18 month path into cybersecurity. No shortcuts, no "learn hacking in 30 days" bullshit. This is what actually works.

!!! tip "2026 Update"
    The cybersecurity job market is competitive at entry-level (everyone wants to be a hacker). SOC analyst roles are your best bet for first job. Cloud security is the fastest-growing specialization. AI/ML security is emerging. Remote entry-level roles are scarce — prioritize in-person opportunities.

---

## Quick Hits

=== ":lucide-list-check: Learning Phases"

    **Phase 0: Foundation (1-3 months)**
    ```bash
    # Prerequisites - Computer literacy baseline
    # Goal: Comfortable with command line, basic scripting, networking concepts

    # Linux fundamentals (Ubuntu/Kali)
    # Install VM (VirtualBox/VMware)
    wget https://releases.ubuntu.com/22.04/ubuntu-22.04-desktop-amd64.iso

    # Essential Linux commands
    ls -la                  # List files (detailed)
    cd /var/log            # Change directory
    cat syslog             # View file contents
    grep "error" syslog    # Search in files
    chmod 755 script.sh    # Change permissions
    ps aux | grep apache   # Process management

    # Networking basics (learn by doing)
    ping google.com        # Test connectivity
    traceroute google.com  # View route
    netstat -tuln          # View listening ports
    nslookup example.com   # DNS lookup
    curl -I https://example.com  # HTTP headers

    # Python basics (security automation)
    # Example: Port scanner
    import socket

    def scan_port(host, port):
        """Basic port scanner."""
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        sock.settimeout(1)
        result = sock.connect_ex((host, port))
        sock.close()
        return result == 0  # True if port open

    # Scan common ports
    for port in [21, 22, 80, 443, 3306, 8080]:
        if scan_port("192.168.1.1", port):
            print(f"Port {port}: OPEN")
    ```

    **Free resources:**
    - **Linux:** Linux Journey website, TryHackME "Linux Fundamentals"
    - **Networking:** Professor Messer Network+ (YouTube, free)
    - **Python:** "Automate the Boring Stuff with Python" (free book)

    **Time commitment:** 1-2 hours daily

    ---

    **Phase 1: Security Fundamentals (3-6 months)**
    See **[security-fundamentals.1337.md](security-fundamentals.1337.md)** — Core concepts, Security+ prep, essential tools.

    **Phase 2: Choose Specialization (6-12 months)**

    | Path | Focus | Entry Difficulty | Salary Range |
    |------|-------|-----------------|--------------|
| :material-crosshairs-gps: **[Offensive (Red Team)](offensive-security.1337.md)** | Pentesting, AD attacks, exploit dev | Hard | $60-150k+ |
| :lucide-shield: **[Defensive (Blue Team)](defensive-security.1337.md)** | SOC, SIEM, incident response | Easiest | $50-120k+ |
| :lucide-scale: **[GRC](grc.1337.md)** | Compliance, risk, policy | Moderate | $55-130k+ |

    **Recommended path for most people:**

    Start with **Blue Team (SOC Analyst)** path because:
    - Easiest to get first job (SOC roles abundant)
    - Learn both offense + defense (investigate attacks)
    - Can pivot to red team later (understand defense first)
    - Steady learning curve (not overwhelming)
    - Clear certification progression

=== ":lucide-bolt: Career Paths & Jobs"

    **Phase 3: Get Your First Job (12-18 months)**
    ```python
    # Entry-level roles to target
    entry_roles = {
        "SOC Analyst Tier 1": {
            "difficulty": "Easiest",
            "salary": "$50-70k",
            "requirements": [
                "Security+ certification",
                "Basic SIEM knowledge (Splunk)",
                "Understanding of network protocols",
                "Incident triage experience (labs count)"
            ],
            "responsibilities": [
                "Monitor security alerts",
                "Triage incidents (true positive vs false positive)",
                "Escalate to Tier 2",
                "Document findings"
            ]
        },
        "Junior Security Analyst": {
            "difficulty": "Moderate",
            "salary": "$55-75k",
            "requirements": [
                "Security+ or equivalent",
                "Scripting (Python/PowerShell)",
                "Vulnerability scanning experience",
                "Log analysis"
            ]
        },
        "Junior Pentester": {
            "difficulty": "Hard",
            "salary": "$60-80k",
            "requirements": [
                "OSCP or equivalent",
                "Demonstrated pentesting (HTB profile, writeups)",
                "Web app + network testing",
                "Report writing skills"
            ]
        },
        "GRC Analyst": {
            "difficulty": "Moderate",
            "salary": "$55-70k",
            "requirements": [
                "Security+",
                "Understanding of frameworks (NIST, ISO 27001)",
                "Documentation skills",
                "Audit experience (internship counts)"
            ]
        }
    }
    ```

    **How to stand out (portfolio building):**
    ```bash
    # 1. GitHub portfolio (show your work)
    github-portfolio/
    ├── python-port-scanner/      # Security tool you built
    ├── vulnerable-app-audit/     # Security assessment writeup
    ├── homelab-documentation/    # SIEM setup, network diagram
    ├── ctf-writeups/            # TryHackMe/HTB solutions
    └── automation-scripts/       # PowerShell/Python security scripts

    # 2. Blog/website (demonstrate knowledge)
    # Write about:
    - What you learned this week
    - Walkthrough of HTB machine
    - Explanation of CVE you studied
    - Home lab setup guide
    # Host on: Medium, GitHub Pages, personal domain

    # 3. Certifications + platform stats
    Resume-worthy metrics:
    - Security+ certified
    - TryHackMe: Top 5% (50,000+ points)
    - HackTheBox: 20+ boxes pwned
    - PortSwigger Academy: All labs completed
    - GitHub: 10+ security projects

    # 4. Networking (most jobs never posted)
    # Attend:
    - Local OWASP chapter meetings
    - BSides conferences ($20-50, beginner-friendly)
    - Security meetups (Meetup.com)
    - Join Discord: TryHackMe, HackTheBox, InfoSec communities
    - LinkedIn: Connect with security professionals, engage with content
    ```

    **Resume tips for security roles:**
    ```markdown
    ## Security Analyst Resume (Entry-Level)

    **Certifications:**
    - CompTIA Security+ (2025)
    - Blue Team Level 1 (2026)

    **Technical Skills:**
    - **SIEM:** Splunk, Elastic Stack (home lab experience)
    - **Tools:** Wireshark, Nmap, Burp Suite, Metasploit
    - **Scripting:** Python (security automation), PowerShell
    - **Platforms:** TryHackMe (Top 5%, 50k+ points), HackTheBox (25 boxes)

    **Projects:**
    - **Home SOC Lab:** Built SIEM with Security Onion, generated synthetic attacks, created detection rules (GitHub link)
    - **Vulnerable App Security Audit:** Identified 15 vulnerabilities in OWASP Juice Shop, documented remediation (blog writeup)
    - **Python Port Scanner:** Created multi-threaded scanner with service detection (GitHub: 50+ stars)

    **Experience:** (if no security jobs yet)
    - **IT Support Specialist, ABC Company (2023-2025)**
      - Monitored security alerts (500+ tickets analyzed)
      - Assisted with vulnerability management (Nessus scans)
      - Documented security incidents (ticketing system)
      - Collaborated with security team on phishing campaigns

    **Use security keywords:**
    SIEM, IDS/IPS, SOC, incident response, threat intelligence, vulnerability assessment, penetration testing, MITRE ATT&CK, log analysis, network security, endpoint security, NIST CSF, ISO 27001
    ```

    **Salary expectations (US, 2026):**
    ```python
    entry_level_salaries = {
        "SOC Analyst Tier 1": {
            "Low cost area": "$45-55k",
            "Medium cost": "$55-70k",
            "High cost (SF/NYC)": "$70-90k",
            "Remote": "$50-65k"
        },
        "Junior Pentester": {
            "Low cost": "$55-70k",
            "Medium cost": "$65-85k",
            "High cost": "$80-100k",
            "Remote": "$60-80k"
        },
        "GRC Analyst": {
            "Low cost": "$50-65k",
            "Medium cost": "$60-75k",
            "High cost": "$70-90k"
        }
    }

    # Career progression (5-year outlook)
    progression = {
        "Years 1-2": "Entry-level ($50-70k)",
        "Years 3-4": "Mid-level ($70-100k)",
        "Years 5+": "Senior ($100-150k+)",
        "Years 10+": "Lead/Manager ($150-250k+)"
    }
    ```

    **Phase 4: Continuous Growth (18+ months)**
    ```bash
    # Year 2-3 goals (once employed)
    career_advancement = [
        "Get senior-level cert (OSCP, GCIH, CISSP)",
        "Specialize deeper (cloud security, malware analysis)",
        "Contribute to open-source security tools",
        "Speak at local meetups/conferences",
        "Mentor junior analysts",
        "Build professional network"
    ]

    # Specialization options (after generalist foundation)
    specializations = {
        "Cloud Security": "AWS/Azure/GCP security, CSPM tools, IAM",
        "Malware Analysis": "Reverse engineering, IDA Pro/Ghidra",
        "Threat Intelligence": "IOC analysis, OSINT, threat hunting",
        "Application Security": "Secure code review, SAST/DAST",
        "Red Team Operations": "Full-scope adversary simulation",
        "Security Architecture": "Design secure systems, threat modeling",
        "Digital Forensics": "Incident investigation, evidence preservation"
    }

    # Continuous learning (security never stops)
    stay_current = [
        "Daily: Read /r/netsec, security Twitter, blogs",
        "Weekly: Try new tool, complete CTF challenge",
        "Monthly: Read vulnerability disclosures, try new technique",
        "Quarterly: Attend conference, take online course",
        "Yearly: Get new certification, update skills"
    ]
    ```

=== ":material-fire: Budget & Action Plan"

    **Budget breakdown (realistic costs):**
    ```python
    # Bare minimum (aggressive budget)
    minimum_path = {
        "Security+ exam": "$400",
        "TryHackMe subscription (1 year)": "$120",
        "Total": "$520"
    }

    # Recommended (balanced)
    recommended_path = {
        "Security+ (exam + materials)": "$500",
        "TryHackMe (1 year)": "$120",
        "BTL1 or eJPT": "$400-500",
        "Books/resources": "$100",
        "Total": "$1,120-1,220"
    }

    # Premium (fastest path)
    premium_path = {
        "Security+": "$500",
        "TryHackMe + HTB VIP": "$250/year",
        "OSCP": "$1,649",
        "Conference ticket (BSides)": "$50-200",
        "Total": "$2,449-2,599"
    }

    # Free alternatives (if budget constrained)
    free_resources = {
        "Certs": "Google Cybersecurity Certificate (Coursera - audit free)",
        "Practice": "TryHackMe free rooms, HackTheBox retired machines",
        "Learning": "Professor Messer (YouTube), Cybrary (free tier)",
        "Books": "Library, Anna's Archive, free online books",
        "VMs": "VirtualBox (free), VulnHub (free VMs)"
    }
    ```

    **Common mistakes to avoid:**
    ```bash
    # ❌ Certification hoarding without practice
    Wrong approach:
    - Get 5 certifications in 6 months
    - No hands-on lab work
    - Can't explain what SQL injection is
    - Resume looks good, can't pass technical interview

    ✅ Right approach:
    - 1 certification at a time
    - 100+ hours hands-on labs per cert
    - Build projects demonstrating knowledge
    - Can explain AND demonstrate

    # ❌ Tutorial hell (consuming content without doing)
    Wrong: Watch 50 hours of pentesting videos
    ✅ Right: Watch 5 hours, practice 45 hours

    # ❌ Trying to learn everything at once
    Wrong: Red team + blue team + GRC + cloud + forensics
    ✅ Right: Pick one path, go deep, add breadth later

    # ❌ Imposter syndrome paralysis
    Wrong: "I'm not ready to apply (after 2 years studying)"
    ✅ Right: "I meet 60% of requirements, applying anyway"
    # Reality: Job descriptions are wishlists, not requirements

    # ❌ Ignoring soft skills
    Technical skills: 50% of job
    Communication: 25% (writing reports, explaining to non-technical)
    Teamwork: 25% (security is collaborative)

    # ❌ Not networking
    Wrong: Only apply via job boards (10% success rate)
    ✅ Right: Network → referrals → interviews (60% success rate)

    # ❌ Giving up too early
    Reality: 12-18 months minimum to first job
    Common mistake: Give up at month 6
    Success: Consistent effort over 18 months
    ```

    **Day 1 action plan (start today):**
    ```bash
    # Hour 1: Create accounts and start learning
    - Create TryHackMe account (free)
    - Start "Pre Security" path
    - Complete first room (takes 30 mins)

    # Hour 2: Set up lab environment
    - Download VirtualBox (free)
    - Download Ubuntu ISO
    - Create first Linux VM
    - Install, update, familiarize

    # Hour 3: Linux basics
    - Open terminal
    - Learn 10 commands: ls, cd, pwd, cat, grep, chmod, ps, netstat, ping, curl
    - Create directories, files via command line
    - Practice navigating file system

    # This week (7 days):
    - 1 hour daily: TryHackMe (complete 2-3 rooms)
    - 30 mins daily: Linux practice (terminal commands)
    - 30 mins daily: Professor Messer Security+ (video 1-7)
    - Weekend: Set up Python environment, hello world

    # This month (30 days):
    - Complete "Pre Security" path on TryHackMe (20 rooms)
    - Comfortable in Linux terminal (50+ commands memorized)
    - Decide specialization (Red/Blue/GRC)
    - Start Security+ study plan (2-3 month timeline)
    - Join Discord communities (TryHackMe, HackTheBox)

    # Month 2-3:
    - Security+ focused study (1-2 hours daily)
    - TryHackMe "Jr Penetration Tester" or "SOC Level 1" path
    - Build first project (port scanner, log parser, etc.)
    - Start blog (document learning journey)

    # Month 4-6:
    - Pass Security+ exam
    - Complete 50+ TryHackMe rooms
    - 3-5 projects on GitHub
    - Start specialization path (offensive/defensive)

    # Month 7-12:
    - Advanced certification (BTL1, eJPT, or PNPT)
    - Build portfolio (projects, writeups, blog)
    - Network (meetups, conferences, Discord)
    - Apply to entry-level roles (even if feel unready)

    # Month 13-18:
    - Continuous applications (10-20 per week)
    - Interview practice (technical + behavioral)
    - Land first security job
    - Celebrate!
    ```

    **Why this path works:**
    - Start with foundations (don't skip basics)
    - Hands-on practice from day 1 (not just theory)
    - Certification validates knowledge (HR filters require it)
    - Portfolio demonstrates competence (projects > certs)
    - Networking accelerates job search (referrals work)
    - Specialization after generalist base (T-shaped skills)
    - Realistic timeline (no get-rich-quick promises)

---

## :lucide-graduation-cap: Recommended Learning Platforms

### :lucide-book-open: Hands-On Practice

- **[TryHackMe](https://tryhackme.com/)** — $10/month, best for beginners (structured paths)
- **[HackTheBox](https://www.hackthebox.com/)** — $14/month, more challenging (realistic machines)
- **[PentesterLab](https://pentesterlab.com/)** — $20/month, web exploitation focus
- **[Blue Team Labs Online](https://blueteamlabs.online/)** — $15/month, SOC analyst training
- **[LetsDefend](https://letsdefend.io/)** — $10/month, SOC simulator
- **[PortSwigger Academy](https://portswigger.net/web-security)** — Free, web security (excellent)

### :lucide-rocket: Free Resources

- **[Professor Messer](https://www.professormesser.com/)** — Free Security+ videos (YouTube)
- **[Cybrary](https://www.cybrary.it/)** — Free tier (courses, paths)
- **[CyberDefenders](https://cyberdefenders.org/)** — Free blue team challenges
- **[Linux Journey](https://linuxjourney.com/)** — Free Linux fundamentals
- **[OWASP](https://owasp.org/)** — Free resources (Top 10, guides, tools)

### :material-certificate: Certification Roadmaps

**Entry-Level (0-2 years):**
- CompTIA Security+ → CySA+ or BTL1 or eJPT

**Mid-Level (2-5 years):**
- OSCP (offensive) or GCIH (defensive) or CISA (GRC)

**Senior-Level (5+ years):**
- CISSP (management) or OSEP (advanced offensive) or GCFA (forensics)

---

**Last Updated:** 2026-02-02 | **Vibe Check:** :lucide-graduation-cap: **No Shortcuts** - 12-18 months to first job (realistic). Certifications required (HR filters). Hands-on projects mandatory (certs alone not enough). SOC easiest entry (pivot later). Junior pentester roles rare (start blue team). Portfolio + networking > 100 applications. Imposter syndrome normal (apply anyway). Budget $500-2,500 over 18 months.

**Tags:** learning-path, career, certifications, beginner, roadmap, cybersecurity-careers
