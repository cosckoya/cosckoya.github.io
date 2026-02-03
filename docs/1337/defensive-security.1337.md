---
title: Defensive Security (Blue Team)
description: SOC operations, incident response, digital forensics, malware analysis, threat hunting, SIEM management
---

# :fontawesome-solid-shield-halved: Defensive Security (Blue Team)

The defenders. Monitor networks, respond to incidents, hunt threats, analyze malware. Less glamorous than hacking, but you're the reason companies don't get pwned daily. SOC analysts, incident responders, threat hunters, forensics experts. Sleep is optional during incidents.

!!! tip "2026 Update"
    AI-powered SIEM (GPT-4 writes detection rules). EDR mandatory (endpoints generate TB of telemetry). Cloud-native SOCs (Sentinel, Chronicle). SOAR automation reduces alert fatigue. Threat hunting proactive (not reactive). MDR (Managed Detection & Response) market exploding.

______________________________________________________________________

## :fontawesome-solid-bolt-lightning: Quick Hits

=== ":fontawesome-solid-list-check: Core Disciplines"

    **Security Operations (SOC):**
    ```bash
    # SIEM queries (Splunk example)
    index=windows EventCode=4625           # Failed logons
    | stats count by src_ip, user
    | where count > 10                      # Brute force detection  # (1)!

    index=proxy
    | eval domain=lower(url_domain)
    | search domain="*.exe" OR domain="*malware*"  # Malicious downloads

    # Elastic Security (ELK Stack)
    event.code: 4720 AND user.name: admin  # New user creation by admin
    process.name: powershell.exe AND process.command_line: *-enc*  # (2)!

    # Sigma rules (universal SIEM format)
    title: Suspicious PowerShell Execution
    detection:
      selection:
        EventID: 4688
        CommandLine|contains:
          - '-enc'
          - 'IEX'
          - 'downloadstring'
      condition: selection  # (3)!
    ```

    1. Threshold-based detection (adjust count for environment)
    2. Base64-encoded PowerShell commands (-enc flag)
    3. Sigma rules convert to Splunk/Elastic/QRadar/etc.

    **Incident Response:**
    ```bash
    # Triage (SANS 6-step process)
    # 1. Preparation
    # 2. Identification
    # 3. Containment
    # 4. Eradication
    # 5. Recovery
    # 6. Lessons Learned

    # Live response (Windows)
    wmic process list full                  # Running processes
    netstat -anob                           # Network connections with PIDs  # (1)!
    Get-WinEvent -LogName Security -MaxEvents 100  # Recent events
    Get-ScheduledTask | where {$_.State -ne "Disabled"}  # Scheduled tasks

    # Memory acquisition
    winpmem-3.3.exe mem.raw                 # Windows memory dump
    avml memory.lime                        # Linux memory dump (Azure tool)

    # Disk imaging
    dc3dd if=/dev/sda of=evidence.img hash=md5,sha256  # (2)!
    FTK Imager                              # GUI disk imaging (Windows)

    # Timeline analysis
    log2timeline.py timeline.plaso evidence.img  # Plaso timeline
    psort.py -o l2tcsv timeline.plaso -w timeline.csv
    ```

    1. netstat -anob shows process names (requires admin)
    2. dc3dd forensic-friendly dd (hashing built-in)

    **Malware Analysis:**
    ```bash
    # Static analysis
    file malware.exe                        # File type identification
    strings malware.exe | less              # Extract strings
    objdump -d malware.elf | less          # Disassemble Linux binary

    # Hash analysis
    md5sum malware.exe                      # MD5 hash
    sha256sum malware.exe                   # SHA256 (better)

    # VirusTotal
    curl --request POST \
      --url https://www.virustotal.com/api/v3/files \
      --header 'x-apikey: YOUR_API_KEY' \
      --form file=@malware.exe  # (1)!

    # Dynamic analysis (sandbox)
    cuckoo submit malware.exe               # Cuckoo Sandbox  # (2)!
    # Or use online: any.run, hybrid-analysis.com, joe sandbox

    # Detonation
    remnux                                   # REMnux Linux distro for malware analysis
    flare-vm                                 # FLARE-VM Windows VM with tools
    ```

    1. VirusTotal uploads file (don't upload sensitive malware)
    2. Cuckoo automated dynamic analysis (safe detonation)

    **Threat Hunting:**
    ```python
    # Hypothesis-driven hunting
    # Hypothesis: "Attackers using LOLBins for lateral movement"

    # Hunt for suspicious certutil usage (Windows)
    index=windows EventCode=4688
    CommandLine="*certutil*" AND CommandLine="*-urlcache*"  # (1)!

    # Hunt for WMI lateral movement
    index=windows EventCode=4688 ProcessName="*wmic.exe*"
    CommandLine="*/node:*" CommandLine="*process call create*"  # (2)!

    # Hunt for Kerberoasting
    index=windows EventCode=4769
    TicketOptions=0x40810000
    TicketEncryptionType=0x17  # (3)!
    ```

    1. certutil.exe downloads files (LOLBin abuse)
    2. WMI remote process creation (lateral movement)
    3. Kerberoasting signature (RC4 encryption, specific options)

    **Real talk:**

    - Alert fatigue is real (90% false positives initially)
    - Tuning takes months (know your environment)
    - Automation essential (SOAR platforms)
    - On-call rotation brutal (3AM incidents)
    - Threat intelligence overrated (most TI doesn't apply)
    - Blue team cert: GCIH, GMON, GCFA (SANS expensive but good)

=== ":fontawesome-solid-bolt: Common Patterns"

    **SIEM Detection Engineering:**
    ```yaml
    # Elastic Detection Rule (EQL)
    name: Suspicious PowerShell Download
    type: eql
    query: |
      process where process.name == "powershell.exe" and
      process.command_line matches (
        "*.DownloadString*",
        "*.DownloadFile*",
        "*Invoke-WebRequest*",
        "*wget *",
        "*curl *"
      )
    risk_score: 73
    severity: high
    tags:
      - "Defense Evasion"
      - "Execution"  # (1)!
    ```

    1. MITRE ATT&CK technique tagging

    ```python
    # Custom Python detection script
    import pandas as pd
    from datetime import datetime, timedelta

    def detect_brute_force(df, threshold=10, window_minutes=5):
        """Detect failed login brute force attempts."""
        now = datetime.now()
        window_start = now - timedelta(minutes=window_minutes)

        recent_failures = df[
            (df['event_id'] == 4625) &  # Failed logon
            (df['timestamp'] >= window_start)
        ]

        grouped = recent_failures.groupby(['src_ip', 'username']).size()
        alerts = grouped[grouped >= threshold]  # (1)!

        return alerts

    # Usage
    df = pd.read_csv('security_logs.csv')
    alerts = detect_brute_force(df, threshold=10, window_minutes=5)
    for (ip, user), count in alerts.items():
        print(f"ALERT: {count} failed logins from {ip} for user {user}")
    ```

    1. Threshold-based detection (tune per environment)

    **Incident Response Playbook:**
    ```markdown
    ## Ransomware Response Playbook

    ### 1. Identification (5 minutes)
    - [ ] Confirm ransomware (file encryption, ransom note)
    - [ ] Identify patient zero (first infected system)
    - [ ] Determine ransomware family (check ransom note IOCs)

    ### 2. Containment (15 minutes)
    - [ ] Isolate infected systems (network segmentation)
    - [ ] Disable compromised accounts (AD lockout)
    - [ ] Block C2 domains/IPs (firewall rules)
    - [ ] Snapshot VMs (before eradication)  # (1)!

    ### 3. Eradication (2-4 hours)
    - [ ] Identify all infected systems (EDR query)
    - [ ] Rebuild systems from clean backups
    - [ ] Reset all passwords (especially privileged)
    - [ ] Patch vulnerabilities exploited

    ### 4. Recovery (4-24 hours)
    - [ ] Restore from backups (test integrity first)
    - [ ] Verify decryption (if paying ransom - last resort)
    - [ ] Monitor for re-infection (7-14 days)

    ### 5. Lessons Learned (1 week post-incident)
    - [ ] Root cause analysis
    - [ ] Improve detections
    - [ ] Update runbooks
    ```

    1. Snapshots preserve forensic evidence

    **Malware Triage Workflow:**
    ```bash
    # 1. Static analysis (safe, no execution)
    file malware.bin
    strings malware.bin | grep -i http  # Extract URLs
    exiftool malware.bin                # Metadata
    pe-sieve malware.exe                # Check for process hollowing

    # 2. Hash check (known malware?)
    sha256sum malware.bin
    curl "https://www.virustotal.com/api/v3/files/SHA256" \
      -H "x-apikey: KEY"

    # 3. Yara rules (signature matching)
    yara -r rules/ malware.bin          # (1)!

    # 4. Sandbox (automated dynamic analysis)
    cuckoo submit malware.bin

    # 5. Manual dynamic analysis (if needed)
    # Boot FlareVM, take snapshot, run malware
    procmon.exe                          # Process Monitor
    wireshark                            # Network capture
    regshot                              # Registry changes
    ```

    1. Yara rules match malware patterns/families

    **Threat Hunting Query Library:**
    ```sql
    -- Hunt: Persistence via Registry Run Keys
    SELECT *
    FROM registry_changes
    WHERE path LIKE '%Run%' OR path LIKE '%RunOnce%'
    AND timestamp > datetime('now', '-1 hour');

    -- Hunt: Suspicious parent-child process relationships
    SELECT parent.name AS parent, child.name AS child, COUNT(*) as count
    FROM processes child
    JOIN processes parent ON child.parent = parent.pid
    WHERE (parent.name = 'winword.exe' AND child.name = 'powershell.exe')
       OR (parent.name = 'excel.exe' AND child.name = 'cmd.exe')
    GROUP BY parent.name, child.name
    HAVING count > 1;  # (1)!
    ```

    1. Office spawning shells suspicious (macro malware)

    **Why this works:**

    - Layered defense (prevention, detection, response)
    - Automation reduces analyst burnout (SOAR)
    - Threat hunting finds bypassed detections
    - Forensics provides attribution and IOCs
    - Incident response limits damage

=== ":fontawesome-solid-fire: Pro Tips & Gotchas"

    !!! success "Best Practices"
        - **Tuning is key** - 90% false positives kill SOCs (tune aggressively)
        - **Automation** - SOAR for common tasks (enrichment, ticketing)
        - **Threat intel** - Prioritize internal telemetry over external feeds
        - **Playbooks** - Document everything (3AM you needs runbooks)
        - **Tabletop exercises** - Practice IR before real incidents
        - **Metrics** - MTTD (Mean Time To Detect), MTTR (Mean Time To Respond)
        - **Purple teaming** - Test detection coverage with red team

    !!! warning "SOC Operations"
        - **Alert fatigue** - High false positive rate burns out analysts
        - **Tool sprawl** - 20+ security tools norm (integration nightmare)
        - **Skill gaps** - Junior analysts need training (MITRE ATT&CK framework)
        - **Shift work** - 24/7 SOC operations (burnout risk)
        - **Communication** - Update stakeholders during incidents
        - **Evidence preservation** - Chain of custody for legal cases

    !!! tip "Essential Tools"
        - **SIEM** - Splunk ($2k/GB/day), Elastic (free/paid), Sentinel (Azure)
        - **EDR** - CrowdStrike, SentinelOne, Microsoft Defender
        - **SOAR** - Splunk SOAR, Palo Alto Cortex XSOAR
        - **Forensics** - Autopsy (free), X-Ways, EnCase
        - **Malware** - IDA Pro ($1.8k), Ghidra (free), Cuckoo (free)
        - **Threat Intel** - MISP, OpenCTI, Anomali

    !!! danger "Gotchas"
        - **Log retention** - Compliance requires 1+ year (storage $$$)
        - **Time sync** - NTP critical for timeline analysis
        - **Encryption** - HTTPS/TLS hides malicious traffic
        - **Cloud visibility** - Cloud logging expensive (AWS CloudTrail, Azure Monitor)
        - **Insider threats** - DLP and UEBA detect (hard to prevent)
        - **Legal holds** - Preserve evidence for litigation
        - **Ransomware** - Backups useless if compromised (test regularly)

______________________________________________________________________

## :fontawesome-solid-graduation-cap: Learning Paths

### :fontawesome-solid-book-open: Certifications

- **[GCIH](https://www.giac.org/certifications/certified-incident-handler-gcih/)** - $2499, SANS incident handling
- **[GCFA](https://www.giac.org/certifications/certified-forensic-analyst-gcfa/)** - $2499, forensics
- **[GMON](https://www.giac.org/certifications/continuous-monitoring-certification-gmon/)** - $2499, SOC operations
- **[BTL1](https://www.securityblue.team/courses/blue-team-level-1/)** - $499, affordable blue team cert
- **[CEH](https://www.eccouncil.org/train-certify/certified-ethical-hacker-ceh/)** - $1199, entry-level (controversial)

### :fontawesome-solid-rocket: Practice Platforms

- **[CyberDefenders](https://cyberdefenders.org/)** - Free blue team challenges
- **[LetsDefend](https://letsdefend.io/)** - $10/month, SOC analyst training
- **[BOSS of the SOC](https://www.splunk.com/en_us/blog/conf-splunklive/boss-of-the-soc-splunk-security-dataset-project.html)** - Free Splunk SIEM competition dataset

______________________________________________________________________

## :fontawesome-solid-wrench: Essential Toolkit

| Category | Tools | Purpose |
|----------|-------|---------|
| **SIEM** | Splunk, Elastic, Microsoft Sentinel | Log aggregation, correlation |
| **EDR** | CrowdStrike, Carbon Black, Defender | Endpoint detection/response |
| **Forensics** | Autopsy, Volatility, FTK Imager | Disk/memory analysis |
| **Malware** | IDA Pro, Ghidra, Cuckoo, REMnux | Reverse engineering, sandboxing |
| **IR** | Velociraptor, GRR, KAPE | Live response, artifact collection |
| **Network** | Wireshark, Zeek, Suricata | Packet analysis, IDS |

______________________________________________________________________

**Last Updated:** 2026-02-02 | **Vibe Check:** :fontawesome-solid-shield: **Always On Defense** - Thankless job until breach prevented. Alert fatigue real. Automation essential. Incident response stressful. SOC work 24/7 shifts. Blue team certs expensive (SANS). Career stable (always need defenders).

**Tags:** defensive-security, blue-team, soc, incident-response, forensics
