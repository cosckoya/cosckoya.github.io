---
title: Cybersecurity Learning Path (Zero to Hero)
description: Complete roadmap from beginner to professional - foundations, certifications, specializations, career paths
---

# :fontawesome-solid-road: Cybersecurity Learning Path (Zero to Hero)

The realistic path from zero technical knowledge to cybersecurity professional. No shortcuts, no BS. Expect 12-18 months to first job. Linux fundamentals, networking basics, security concepts, hands-on labs, certifications. Choose specialization: offensive (red team), defensive (blue team), or governance (GRC). Practice beats theory.

!!! tip "2026 Update"
    Entry-level market competitive (100+ applicants per SOC role). Certifications + hands-on projects mandatory. TryHackMe/HackTheBox expected on resume. Cloud security skills premium (AWS/Azure/GCP). AI-assisted learning tools (ChatGPT explains vulnerabilities). Remote-first security roles common. Junior pentester roles rare (start SOC, pivot later).

______________________________________________________________________

## :fontawesome-solid-bolt-lightning: Quick Hits

=== ":fontawesome-solid-list-check: Learning Phases"

    **Phase 0: Foundation (1-3 months)**
    ```bash
    # Prerequisites - Computer literacy baseline
    # Goal: Comfortable with command line, basic scripting, networking concepts

    # Linux fundamentals (Ubuntu/Kali)
    # Install VM (VirtualBox/VMware)
    wget https://releases.ubuntu.com/22.04/ubuntu-22.04-desktop-amd64.iso  # (1)!

    # Essential Linux commands
    ls -la                  # List files (detailed)
    cd /var/log            # Change directory
    cat syslog             # View file contents
    grep "error" syslog    # Search in files
    chmod 755 script.sh    # Change permissions
    ps aux | grep apache   # Process management  # (2)!

    # Networking basics (learn by doing)
    ping google.com        # Test connectivity
    traceroute google.com  # View route
    netstat -tuln          # View listening ports
    nslookup example.com   # DNS lookup
    curl -I https://example.com  # HTTP headers  # (3)!

    # Python basics (security automation)
    # Example: Port scanner
    import socket

    def scan_port(host, port):
        """Basic port scanner."""
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        sock.settimeout(1)
        result = sock.connect_ex((host, port))  # (4)!
        sock.close()
        return result == 0  # True if port open

    # Scan common ports
    for port in [21, 22, 80, 443, 3306, 8080]:
        if scan_port("192.168.1.1", port):
            print(f"Port {port}: OPEN")
    ```

    1. Ubuntu VM for practice (or dual boot)
    2. Understand processes, permissions, file system
    3. Networking: OSI model, TCP/IP, DNS, HTTP
    4. Python for security automation (scripting essential)

    **Free resources:**
    - **Linux:** Linux Journey website, TryHackMe "Linux Fundamentals"
    - **Networking:** Professor Messer Network+ (YouTube, free)
    - **Python:** "Automate the Boring Stuff with Python" (free book)

    **Time commitment:** 1-2 hours daily

    **Phase 1: Security Fundamentals (3-6 months)**
    ```python
    # Goal: Understand cybersecurity concepts, basic attacks, tools

    # Core concepts to master
    security_fundamentals = {
        "CIA_Triad": {
            "Confidentiality": "Prevent unauthorized access (encryption)",
            "Integrity": "Prevent unauthorized modification (hashing)",
            "Availability": "Ensure systems accessible (DDoS mitigation)"  # (1)!
        },
        "Authentication": {
            "Something you know": "Password",
            "Something you have": "Token, smart card",
            "Something you are": "Biometrics (fingerprint)"
        },
        "OWASP_Top_10": [
            "Broken Access Control",
            "Cryptographic Failures",
            "Injection (SQL, XSS, command)",
            "Insecure Design",
            "Security Misconfiguration"  # (2)!
        ],
        "Common_Attacks": {
            "Phishing": "Social engineering via email",
            "SQL Injection": "Database manipulation via input",
            "XSS": "Inject JavaScript into web pages",
            "MITM": "Intercept network traffic"
        }
    }

    # Hands-on practice (TryHackMe example)
    # Complete these paths:
    paths = [
        "Pre Security (free)",           # Basics  # (3)!
        "Introduction to Cyber Security (free)",
        "Jr Penetration Tester ($10/month)"
    ]

    # Essential tools to learn
    tools = {
        "nmap": "Network scanning (port discovery)",
        "Wireshark": "Packet analysis (network traffic)",
        "Burp Suite": "Web app testing (proxy, scanner)",
        "Metasploit": "Exploitation framework",
        "John the Ripper": "Password cracking"
    }  # (4)!
    ```

    1. CIA Triad foundation of all security decisions
    2. OWASP Top 10 roadmap for web vulnerabilities
    3. TryHackMe best for beginners (gamified, structured)
    4. Learn tools by using them (not just reading docs)

    **First certification: CompTIA Security+**
    ```bash
    # Why Security+?
    - Industry baseline (HR filters require it)
    - Covers all security domains (breadth over depth)
    - Makes you employable (entry-level requirement)
    - Study time: 2-3 months (1 hour daily)

    # Study resources
    - Professor Messer YouTube (free, excellent)
    - Jason Dion Udemy course ($15 on sale)
    - Practice exams (critical - do 5+ full exams)

    # Exam details
    - Cost: $400
    - Format: 90 questions, 90 minutes
    - Passing: 750/900 (83%)
    - Difficulty: Moderate (not technical deep-dive)  # (5)!
    ```

    5. Security+ opens doors (requirement for many DoD/gov jobs)

    **By end of Phase 1:**
    - ✅ Understand security concepts (CIA, AAA, defense in depth)
    - ✅ Know basic attack techniques (SQLi, XSS, phishing)
    - ✅ Completed 50+ TryHackMe rooms (hands-on practice)
    - ✅ Security+ certification obtained
    - ✅ Can explain MITM attack to non-technical person

    **Phase 2: Choose Specialization (6-12 months)**
    ```markdown
    ## Three Primary Paths

    ### Path A: Offensive Security (Red Team)
    **Best for:** Puzzle-solvers, people who like breaking things
    **Difficulty:** Hard to get first job (fewer openings)
    **Salary:** $60k-$150k+ (high ceiling)

    **Learning focus:**
    - Web app pentesting (PortSwigger Academy - free, excellent)
    - Network pentesting (Nmap, Metasploit mastery)
    - Active Directory attacks (Bloodhound, Mimikatz)
    - Privilege escalation (Linux, Windows)

    **Certifications (in order):**
    1. eJPT ($200) - Beginner-friendly
    2. PNPT ($400) - Practical focus
    3. OSCP ($1,649) - Gold standard (very hard)  # (1)!

    **Practice platforms:**
    - HackTheBox (start with "Easy" retired boxes)
    - TryHackMe "Offensive Pentesting" path
    - VulnHub vulnerable VMs

    ### Path B: Defensive Security (Blue Team)
    **Best for:** Analytical thinkers, threat hunters
    **Difficulty:** Easiest to get first job (high demand)
    **Salary:** $50k-$120k+

    **Learning focus:**
    - SIEM fundamentals (Splunk free training)
    - Threat detection (writing rules, IOC analysis)
    - Incident response (SANS 6-step process)
    - Log analysis (Windows Event Logs, syslog)

    **Certifications (in order):**
    1. Security+ (baseline)
    2. BTL1 ($499) - Blue Team Level 1 (practical)
    3. CySA+ ($400) - CompTIA Cybersecurity Analyst
    4. GCIH ($2,499) - Incident handling (expensive)  # (2)!

    **Practice platforms:**
    - Blue Team Labs Online (blueteamlabs.online)
    - CyberDefenders (free challenges)
    - LetsDefend ($10/month SOC simulator)

    ### Path C: GRC (Governance, Risk, Compliance)
    **Best for:** Process-oriented, policy writers
    **Difficulty:** Moderate (less competition)
    **Salary:** $55k-$130k+

    **Learning focus:**
    - Security frameworks (NIST CSF, ISO 27001, CIS)
    - Compliance standards (GDPR, HIPAA, PCI-DSS, SOC 2)
    - Risk assessment methodologies (qualitative, quantitative)
    - Audit processes (evidence collection, findings)

    **Certifications (in order):**
    1. Security+ (foundation)
    2. CISA ($575) - Auditing focus
    3. CRISC ($575) - Risk management
    4. CISSP ($749) - After 5 years experience  # (3)!

    **Reality check:**
    - Less technical (more documentation)
    - Stable work (predictable hours)
    - Can be dry for technical people
    ```

    1. OSCP hardest beginner cert (24h practical exam)
    2. BTL1 best value for blue team (practical, affordable)
    3. CISSP requires 5 years experience (management-level)

    **Recommended path for most people:**

    Start with **Blue Team (SOC Analyst)** path because:
    - ✅ Easiest to get first job (SOC roles abundant)
    - ✅ Learn both offense + defense (investigate attacks)
    - ✅ Can pivot to red team later (understand defense first)
    - ✅ Steady learning curve (not overwhelming)
    - ✅ Clear certification progression

=== ":fontawesome-solid-bolt: Career Paths & Jobs"

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
        },  # (1)!
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
        },  # (2)!
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

    1. SOC Tier 1 easiest entry (high turnover = always hiring)
    2. Junior pentester rare (companies hire senior pentesters)

    **How to stand out (portfolio building):**
    ```bash
    # 1. GitHub portfolio (show your work)
    github-portfolio/
    ├── python-port-scanner/      # Security tool you built
    ├── vulnerable-app-audit/     # Security assessment writeup
    ├── homelab-documentation/    # SIEM setup, network diagram
    ├── ctf-writeups/            # TryHackMe/HTB solutions
    └── automation-scripts/       # PowerShell/Python security scripts  # (1)!

    # 2. Blog/website (demonstrate knowledge)
    # Write about:
    - What you learned this week
    - Walkthrough of HTB machine
    - Explanation of CVE you studied
    - Home lab setup guide
    # Host on: Medium, GitHub Pages, personal domain  # (2)!

    # 3. Certifications + platform stats
    Resume-worthy metrics:
    - Security+ certified
    - TryHackMe: Top 5% (50,000+ points)
    - HackTheBox: 20+ boxes pwned
    - PortSwigger Academy: All labs completed
    - GitHub: 10+ security projects  # (3)!

    # 4. Networking (most jobs never posted)
    # Attend:
    - Local OWASP chapter meetings
    - BSides conferences ($20-50, beginner-friendly)
    - Security meetups (Meetup.com)
    - Join Discord: TryHackMe, HackTheBox, InfoSec communities
    - LinkedIn: Connect with security professionals, engage with content  # (4)!
    ```

    1. Portfolio shows hands-on skills (certificates alone not enough)
    2. Blog demonstrates communication (security is 50% communication)
    3. Quantify everything (recruiters filter on numbers)
    4. Networking gets interviews (many jobs filled via referrals)

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
      - Collaborated with security team on phishing campaigns  # (1)!

    **Use security keywords:**
    SIEM, IDS/IPS, SOC, incident response, threat intelligence, vulnerability assessment, penetration testing, MITRE ATT&CK, log analysis, network security, endpoint security, NIST CSF, ISO 27001  # (2)!
    ```

    1. Reframe IT experience with security angle (legit if true)
    2. Keywords pass ATS (Applicant Tracking Systems)

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
    }  # (3)!

    # Career progression (5-year outlook)
    progression = {
        "Years 1-2": "Entry-level ($50-70k)",
        "Years 3-4": "Mid-level ($70-100k)",
        "Years 5+": "Senior ($100-150k+)",
        "Years 10+": "Lead/Manager ($150-250k+)"
    }
    ```

    3. Location hugely impacts salary (remote normalizing pay)

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
    ]  # (1)!

    # Specialization options (after generalist foundation)
    specializations = {
        "Cloud Security": "AWS/Azure/GCP security, CSPM tools, IAM",
        "Malware Analysis": "Reverse engineering, IDA Pro/Ghidra",
        "Threat Intelligence": "IOC analysis, OSINT, threat hunting",
        "Application Security": "Secure code review, SAST/DAST",
        "Red Team Operations": "Full-scope adversary simulation",
        "Security Architecture": "Design secure systems, threat modeling",
        "Digital Forensics": "Incident investigation, evidence preservation"
    }  # (2)!

    # Continuous learning (security never stops)
    stay_current = [
        "Daily: Read /r/netsec, security Twitter, blogs",
        "Weekly: Try new tool, complete CTF challenge",
        "Monthly: Read vulnerability disclosures, try new technique",
        "Quarterly: Attend conference, take online course",
        "Yearly: Get new certification, update skills"
    ]
    ```

    1. Continuous learning mandatory (threat landscape evolves daily)
    2. Specialize after 2-3 years (T-shaped skills: broad + deep)

=== ":fontawesome-solid-fire: Budget & Action Plan"

    **Budget breakdown (realistic costs):**
    ```python
    # Bare minimum (aggressive budget)
    minimum_path = {
        "Security+ exam": "$400",
        "TryHackMe subscription (1 year)": "$120",
        "Total": "$520"
    }  # (1)!

    # Recommended (balanced)
    recommended_path = {
        "Security+ (exam + materials)": "$500",
        "TryHackMe (1 year)": "$120",
        "BTL1 or eJPT": "$400-500",
        "Books/resources": "$100",
        "Total": "$1,120-1,220"
    }  # (2)!

    # Premium (fastest path)
    premium_path = {
        "Security+": "$500",
        "TryHackMe + HTB VIP": "$250/year",
        "OSCP": "$1,649",
        "Conference ticket (BSides)": "$50-200",
        "Total": "$2,449-2,599"
    }  # (3)!

    # Free alternatives (if budget constrained)
    free_resources = {
        "Certs": "Google Cybersecurity Certificate (Coursera - audit free)",
        "Practice": "TryHackMe free rooms, HackTheBox retired machines",
        "Learning": "Professor Messer (YouTube), Cybrary (free tier)",
        "Books": "Library, Anna's Archive, free online books",
        "VMs": "VirtualBox (free), VulnHub (free VMs)"
    }  # (4)!
    ```

    1. Minimum viable path ($520 gets you started)
    2. Recommended for most people ($1,200 over 12-18 months)
    3. Premium accelerates learning (not required)
    4. Free resources exist (budget not a blocker)

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
    - Can explain AND demonstrate  # (1)!

    # ❌ Tutorial hell (consuming content without doing)
    Wrong: Watch 50 hours of pentesting videos
    ✅ Right: Watch 5 hours, practice 45 hours

    # ❌ Trying to learn everything at once
    Wrong: Red team + blue team + GRC + cloud + forensics
    ✅ Right: Pick one path, go deep, add breadth later  # (2)!

    # ❌ Imposter syndrome paralysis
    Wrong: "I'm not ready to apply (after 2 years studying)"
    ✅ Right: "I meet 60% of requirements, applying anyway"
    # Reality: Job descriptions are wishlists, not requirements

    # ❌ Ignoring soft skills
    Technical skills: 50% of job
    Communication: 25% (writing reports, explaining to non-technical)
    Teamwork: 25% (security is collaborative)  # (3)!

    # ❌ Not networking
    Wrong: Only apply via job boards (10% success rate)
    ✅ Right: Network → referrals → interviews (60% success rate)

    # ❌ Giving up too early
    Reality: 12-18 months minimum to first job
    Common mistake: Give up at month 6
    Success: Consistent effort over 18 months  # (4)!
    ```

    1. Certs prove baseline knowledge (labs prove competence)
    2. T-shaped skills: Deep in one area, broad in others
    3. Communication critical (explain risks to executives)
    4. Persistence wins (most people quit too early)

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
    - Practice navigating file system  # (1)!

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
    - Join Discord communities (TryHackMe, HackTheBox)  # (2)!

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
    - Celebrate! 🎉  # (3)!
    ```

    1. Start immediately (don't wait for "perfect" moment)
    2. Consistency beats intensity (1 hour daily > 10 hours Sunday)
    3. Timeline realistic (12-18 months common for career switchers)

    **Why this path works:**
    - Start with foundations (don't skip basics)
    - Hands-on practice from day 1 (not just theory)
    - Certification validates knowledge (HR filters require it)
    - Portfolio demonstrates competence (projects > certs)
    - Networking accelerates job search (referrals work)
    - Specialization after generalist base (T-shaped skills)
    - Realistic timeline (no get-rich-quick promises)

______________________________________________________________________

## :fontawesome-solid-graduation-cap: Recommended Learning Platforms

### :fontawesome-solid-book-open: Hands-On Practice

- **[TryHackMe](https://tryhackme.com/)** - $10/month, best for beginners (structured paths)
- **[HackTheBox](https://www.hackthebox.com/)** - $14/month, more challenging (realistic machines)
- **[PentesterLab](https://pentesterlab.com/)** - $20/month, web exploitation focus
- **[Blue Team Labs Online](https://blueteamlabs.online/)** - $15/month, SOC analyst training
- **[LetsDefend](https://letsdefend.io/)** - $10/month, SOC simulator
- **[PortSwigger Academy](https://portswigger.net/web-security)** - Free, web security (excellent)

### :fontawesome-solid-rocket: Free Resources

- **[Professor Messer](https://www.professormesser.com/)** - Free Security+ videos (YouTube)
- **[Cybrary](https://www.cybrary.it/)** - Free tier (courses, paths)
- **[CyberDefenders](https://cyberdefenders.org/)** - Free blue team challenges
- **[Linux Journey](https://linuxjourney.com/)** - Free Linux fundamentals
- **[OWASP](https://owasp.org/)** - Free resources (Top 10, guides, tools)

### :fontawesome-solid-certificate: Certification Roadmaps

**Entry-Level (0-2 years):**
- CompTIA Security+ → CySA+ or BTL1 or eJPT

**Mid-Level (2-5 years):**
- OSCP (offensive) or GCIH (defensive) or CISA (GRC)

**Senior-Level (5+ years):**
- CISSP (management) or OSEP (advanced offensive) or GCFA (forensics)

______________________________________________________________________

**Last Updated:** 2026-02-02 | **Vibe Check:** :fontawesome-solid-graduation-cap: **No Shortcuts** - 12-18 months to first job (realistic). Certifications required (HR filters). Hands-on projects mandatory (certs alone not enough). SOC easiest entry (pivot later). Junior pentester roles rare (start blue team). Portfolio + networking > 100 applications. Imposter syndrome normal (apply anyway). Budget $500-2,500 over 18 months.

**Tags:** learning-path, career, certifications, beginner, roadmap, cybersecurity-careers
