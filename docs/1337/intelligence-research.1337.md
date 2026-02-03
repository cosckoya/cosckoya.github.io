---
title: Threat Intelligence & Security Research
description: Threat intelligence, OSINT, vulnerability research, malware reverse engineering, security research methodologies
---

# :fontawesome-solid-magnifying-glass: Threat Intelligence & Security Research

Know your adversary. Collect, analyze, and operationalize threat intelligence. OSINT for reconnaissance. Vulnerability research finds 0-days. Malware reverse engineering understands attacker tools. Intelligence-driven security prioritizes defenses against real threats, not theoretical ones.

!!! tip "2026 Update"
    AI-powered threat hunting (GPT-4 analyzes IOCs). Dark web monitoring automated. OSINT tools evolved (GraphQL APIs, blockchain intel). Vulnerability research democratized (bug bounties paying millions). Nation-state TTPs publicly documented. Threat intel sharing via STIX/TAXII standard.

______________________________________________________________________

## :fontawesome-solid-bolt-lightning: Quick Hits

=== ":fontawesome-solid-list-check: Core Disciplines"

    **Threat Intelligence Lifecycle:**
    ```python
    # 1. Planning & Direction (requirements)
    requirements = {
        "priority_threats": ["Ransomware", "APT groups", "Supply chain attacks"],
        "intelligence_types": ["Strategic", "Tactical", "Operational"],
        "consumers": ["CISO", "SOC", "Incident Response"]
    }  # (1)!

    # 2. Collection (sources)
    sources = {
        "open_source": ["Twitter, blogs, news, public reports"],
        "commercial": ["Recorded Future, Mandiant, CrowdStrike"],
        "communities": ["ISAC, threat intel platforms"],
        "internal": ["SIEM logs, honeypots, IR findings"]
    }

    # 3. Processing (normalize, deduplicate)
    # STIX 2.1 format (Structured Threat Information eXpression)
    {
      "type": "indicator",
      "spec_version": "2.1",
      "id": "indicator--8e2e2d2b-17d4-4cbf-938f-98ee46b3cd3f",
      "created": "2026-01-15T08:00:00.000Z",
      "modified": "2026-01-15T08:00:00.000Z",
      "name": "Malicious IP",
      "pattern": "[ipv4-addr:value = '192.0.2.1']",  # (2)!
      "valid_from": "2026-01-15T08:00:00.000Z",
      "labels": ["malicious-activity"]
    }

    # 4. Analysis (contextualize, prioritize)
    # Diamond Model of Intrusion Analysis
    diamond_model = {
        "adversary": "APT29 (Cozy Bear)",
        "capability": "Sunburst backdoor",
        "infrastructure": "C2 domain: avsvmcloud.com",
        "victim": "SolarWinds customers (18,000+)"
    }  # (3)!

    # 5. Dissemination (share with stakeholders)
    # TLP (Traffic Light Protocol) for sharing
    # TLP:RED - No sharing outside organization
    # TLP:AMBER - Limited sharing (need-to-know)
    # TLP:GREEN - Community sharing
    # TLP:CLEAR - Public sharing  # (4)!

    # 6. Feedback (evaluate effectiveness)
    ```

    1. Requirements drive collection (what intelligence do we need?)
    2. STIX standardizes threat data (machine-readable)
    3. Diamond Model maps adversary to infrastructure
    4. TLP controls information sharing (prevent leaks)

    **Open Source Intelligence (OSINT):**
    ```bash
    # Domain/subdomain enumeration
    amass enum -d example.com -o subdomains.txt  # (1)!
    subfinder -d example.com -silent
    assetfinder --subs-only example.com

    # Email harvesting
    theHarvester -d example.com -b all  # (2)!

    # Social media intelligence
    # Twitter: Search for company mentions, breaches, leaks
    # LinkedIn: Employee enumeration, org structure
    # GitHub: Search for secrets, internal tools

    # WHOIS/DNS reconnaissance
    whois example.com
    dig example.com ANY
    dnsenum example.com  # (3)!

    # Google dorking
    site:example.com filetype:pdf  # Find PDFs on domain
    site:example.com inurl:admin    # Find admin panels
    site:example.com ext:sql        # Find SQL files (potential leaks)

    # Shodan (search engine for internet-connected devices)
    shodan search "org:Example Corp"  # (4)!
    shodan host 93.184.216.34

    # Have I Been Pwned (breach data)
    curl https://haveibeenpwned.com/api/v3/breachedaccount/test@example.com
    ```

    1. Amass comprehensive subdomain discovery (active + passive)
    2. theHarvester aggregates emails from search engines
    3. dnsenum DNS enumeration (zone transfers, brute force)
    4. Shodan finds exposed services (databases, webcams, ICS)

    **Vulnerability Research:**
    ```python
    # CVE (Common Vulnerabilities and Exposures)
    # Format: CVE-YYYY-NNNNN
    # Example: CVE-2021-44228 (Log4Shell)

    # Vulnerability scoring (CVSS v3.1)
    # Base Score: 0.0-10.0
    # Severity: None (0), Low (0.1-3.9), Medium (4.0-6.9), High (7.0-8.9), Critical (9.0-10.0)

    cvss_vector = "CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:C/C:H/I:H/A:H"  # (1)!
    # AV:N - Network (remotely exploitable)
    # AC:L - Low complexity (easy to exploit)
    # PR:N - No privileges required
    # UI:N - No user interaction
    # S:C - Scope changed (affects other components)
    # C:H - High confidentiality impact
    # I:H - High integrity impact
    # A:H - High availability impact
    # Score: 10.0 (Critical)  # (2)!

    # Exploit development workflow
    # 1. Identify vulnerability (fuzzing, code review, reverse engineering)
    # 2. Develop proof-of-concept (PoC)
    # 3. Test in controlled environment
    # 4. Responsible disclosure (vendor notification)
    # 5. Public disclosure (90-day timeline)

    # Fuzzing (AFL, libFuzzer)
    # American Fuzzy Lop (AFL)
    afl-fuzz -i input/ -o output/ -- ./target_binary @@  # (3)!
    ```

    1. CVSS vector encodes vulnerability characteristics
    2. Log4Shell scored 10.0 (remote code execution, no auth)
    3. AFL fuzzes binaries to find crashes (potential vulnerabilities)

    **Malware Reverse Engineering:**
    ```bash
    # Static analysis (no execution)
    file malware.bin                    # Identify file type
    strings malware.bin | less          # Extract strings
    objdump -d malware.elf | less      # Disassemble Linux binary
    dumpbin /disasm malware.exe         # Disassemble Windows binary

    # Hash analysis
    md5sum malware.bin
    sha256sum malware.bin
    ssdeep malware.bin                  # Fuzzy hashing (similarity)  # (1)!

    # PE analysis (Windows executables)
    pefile malware.exe                  # Python library
    pestudio malware.exe                # GUI analysis tool

    # Decompilation
    # IDA Pro ($) - Industry standard disassembler
    # Ghidra (free) - NSA's reverse engineering tool  # (2)!
    # Binary Ninja ($) - Modern RE platform

    # Dynamic analysis (controlled execution)
    # 1. Snapshot VM (before execution)
    # 2. Run malware in sandbox
    # 3. Monitor behavior (procmon, wireshark, regshot)
    # 4. Analyze results (API calls, network traffic, registry changes)

    # Cuckoo Sandbox (automated analysis)
    cuckoo submit malware.exe  # (3)!
    cuckoo report 1            # View analysis report

    # Memory analysis (Volatility)
    volatility -f memory.dmp imageinfo  # Identify OS profile
    volatility -f memory.dmp --profile=Win10x64 pslist  # List processes
    volatility -f memory.dmp --profile=Win10x64 netscan  # Network connections
    ```

    1. ssdeep finds similar malware samples (malware families)
    2. Ghidra free alternative to expensive IDA Pro
    3. Cuckoo provides automated malware detonation + reporting

    **Real talk:**

    - Strategic intel for executives (trends, risk landscape)
    - Tactical intel for defenders (TTPs, IOCs for detection)
    - Operational intel for IR (active campaigns, attribution)
    - OSINT 80% of intelligence (public sources underestimated)
    - Commercial threat intel expensive ($50k-500k/year)
    - Most IOCs already stale (C2 infrastructure changes fast)
    - Vulnerability research high-value (bug bounties pay millions)

=== ":fontawesome-solid-bolt: Common Patterns"

    **Threat Intel Platform (MISP):**
    ```python
    # MISP (Malware Information Sharing Platform)
    from pymisp import PyMISP

    misp_url = 'https://misp.example.com'
    misp_key = 'YOUR_API_KEY'
    misp = PyMISP(misp_url, misp_key, False)  # (1)!

    # Create event
    event = misp.new_event(
        distribution=1,  # Organization only
        threat_level_id=2,  # Medium
        analysis=1,  # Ongoing
        info="APT29 phishing campaign"
    )

    # Add indicators
    misp.add_attribute(
        event,
        type='ip-dst',
        value='192.0.2.1',
        comment='C2 server'
    )  # (2)!

    misp.add_attribute(
        event,
        type='sha256',
        value='e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855',
        comment='Malware hash'
    )

    # Search for IOCs
    results = misp.search(
        controller='attributes',
        type_attribute='ip-dst',
        value='192.0.2.1'
    )  # (3)!
    ```

    1. PyMISP Python library for MISP API
    2. Add IOCs (IPs, hashes, domains) to event
    3. Search for existing IOCs in MISP database

    **OSINT Automation:**
    ```bash
    # SpiderFoot (OSINT automation)
    spiderfoot -s example.com -m all  # (1)!

    # Maltego (visual link analysis)
    # GUI tool for mapping relationships
    # Entities: Domains, IPs, emails, people, companies

    # Recon-ng (modular OSINT framework)
    recon-ng
    marketplace install all  # Install modules
    workspaces create example_corp
    db insert domains example.com
    modules load recon/domains-hosts/bing_domain_web
    run  # (2)!

    # OSINT Framework (online resource)
    # https://osintframework.com/
    # Categorized OSINT tools and resources

    # Social media monitoring
    # Twint (Twitter scraping - no API key)
    twint -s "example.com data breach" --since 2026-01-01  # (3)!

    # LinkedIn enumeration
    # linkedin2username (generate username lists)
    python3 linkedin2username.py -c "Example Corp" -n 100
    ```

    1. SpiderFoot automates 200+ OSINT modules
    2. Recon-ng modular framework (like Metasploit for OSINT)
    3. Twint scrapes Twitter without API rate limits

    **Vulnerability Disclosure Program:**
    ```markdown
    ## Bug Bounty Program (HackerOne)

    ### Scope
    **In Scope:**
    - *.example.com (production domains)
    - api.example.com
    - mobile apps (iOS, Android)

    **Out of Scope:**
    - staging.example.com
    - Social engineering
    - Physical attacks
    - DoS/DDoS

    ### Rewards (CVSS-based)  # (1)!
    | Severity | CVSS Score | Bounty |
    |----------|------------|--------|
    | **Critical** | 9.0-10.0 | $5,000-$20,000 |
    | **High** | 7.0-8.9 | $1,000-$5,000 |
    | **Medium** | 4.0-6.9 | $500-$1,000 |
    | **Low** | 0.1-3.9 | $100-$500 |

    ### Disclosure Timeline
    1. **Day 0:** Report submission
    2. **Day 1-3:** Triage (validate, assign severity)
    3. **Day 4-30:** Develop fix
    4. **Day 31-90:** Deploy fix, verify
    5. **Day 90:** Public disclosure  # (2)!

    ### Hall of Fame
    - Top researchers listed publicly
    - Swag (t-shirts, stickers, recognition)
    ```

    1. CVSS scoring determines bounty amount
    2. 90-day disclosure standard (coordinated vulnerability disclosure)

    **Threat Hunting with Intelligence:**
    ```python
    # Hypothesis-driven hunting using threat intel
    # Hypothesis: "APT29 using Sunburst backdoor in our environment"

    # IOCs from threat intel (MISP, commercial feeds)
    sunburst_iocs = {
        "domains": [
            "avsvmcloud.com",
            "digitalcollege.org",
            "freescanonline.com"
        ],
        "file_hashes": [
            "32519b85c0b422e4656de6e6c41878e95fd95026267daab4215ee59c107d6c77"
        ],
        "registry_keys": [
            "HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run\\SolarWinds.BusinessLayerHost"
        ]
    }  # (1)!

    # Hunt in SIEM (Splunk example)
    splunk_query = """
    index=dns
    | search query IN (avsvmcloud.com, digitalcollege.org, freescanonline.com)
    | stats count by src_ip, query
    | where count > 0
    """  # (2)!

    # File hash hunt (EDR query)
    edr_query = """
    SELECT * FROM file_events
    WHERE sha256 = '32519b85c0b422e4656de6e6c41878e95fd95026267daab4215ee59c107d6c77'
    """  # (3)!
    ```

    1. IOCs derived from threat intel reports
    2. Hunt for malicious domains in DNS logs
    3. Hunt for malware hashes in file events

    **Why this works:**

    - Threat intel prioritizes defenses (focus on real threats)
    - OSINT reconnaissance finds attack surface
    - Vulnerability research finds issues before attackers
    - Reverse engineering understands attacker tools/TTPs
    - Intelligence sharing amplifies detection (community defense)

=== ":fontawesome-solid-fire: Pro Tips & Gotchas"

    !!! success "Best Practices"
        - **Prioritize intelligence** - Not all IOCs equal (contextualize)
        - **Automate collection** - APIs, feeds, scrapers (reduce manual work)
        - **Structured data** - STIX/TAXII for machine-readable intel
        - **Threat modeling** - Map adversaries to assets (what do they want?)
        - **Attribution caution** - False flags common (don't jump to conclusions)
        - **OSINT OPSEC** - Use VPNs, burner accounts (adversaries watch back)
        - **Disclosure ethics** - Responsible disclosure protects users

    !!! warning "Intelligence Reality"
        - **Signal vs. noise** - 90% threat intel not relevant to your org
        - **IOC decay** - C2 infrastructure changes fast (IOCs stale in days)
        - **False positives** - Commercial feeds include benign IPs/domains
        - **Attribution hard** - Nation-states use false flags
        - **Sharing friction** - Legal concerns limit intel sharing
        - **Tool sprawl** - 20+ OSINT tools overwhelming
        - **Vulnerability hoarding** - Governments stockpile 0-days

    !!! tip "Essential Tools"
        - **Threat Intel** - MISP (free), OpenCTI (free), Anomali ($), Recorded Future ($$$)
        - **OSINT** - Maltego ($), SpiderFoot (free), Recon-ng (free), Shodan ($)
        - **Vulnerability** - Metasploit (free), Burp Suite Pro ($449/year), Nuclei (free)
        - **Reverse Engineering** - Ghidra (free), IDA Pro ($1,800), Binary Ninja ($$$)
        - **Malware Analysis** - Cuckoo (free), ANY.RUN ($), Joe Sandbox ($)
        - **Fuzzing** - AFL (free), libFuzzer (free), Peach Fuzzer ($)

    !!! danger "Gotchas"
        - **OSINT oversharing** - Companies leak too much info publicly
        - **GitHub secrets** - API keys, credentials in public repos
        - **Metadata leaks** - PDFs, images contain author info, paths
        - **DNS records** - TXT records reveal infrastructure (SPF, DKIM)
        - **Shodan exposure** - Databases, admin panels indexed
        - **LinkedIn intel** - Org structure, employee roles public
        - **Legal risks** - Vulnerability research can violate CFAA (get authorization)

______________________________________________________________________

## :fontawesome-solid-graduation-cap: Learning & Certifications

### :fontawesome-solid-book-open: Certifications

- **[GCTI](https://www.giac.org/certifications/cyber-threat-intelligence-gcti/)** - $2499, SANS threat intelligence
- **[GREM](https://www.giac.org/certifications/reverse-engineering-malware-grem/)** - $2499, malware reverse engineering
- **[OSINT](https://www.securityblue.team/courses/osint/)** - $499, Security Blue Team OSINT
- **[eJPT](https://elearnsecurity.com/product/ejpt-certification/)** - $200, entry-level pentesting

### :fontawesome-solid-rocket: Practice Platforms

- **[CyberDefenders](https://cyberdefenders.org/)** - Free, threat hunting challenges
- **[MalwareBazaar](https://bazaar.abuse.ch/)** - Free, malware samples for research
- **[Hack The Box](https://www.hackthebox.com/)** - $14/month, includes OSINT challenges

______________________________________________________________________

## :fontawesome-solid-wrench: Essential Toolkit

| Category | Tools | Purpose |
|----------|-------|---------|
| **Threat Intel** | MISP, OpenCTI, Anomali, Recorded Future | Aggregation, analysis, sharing |
| **OSINT** | Maltego, SpiderFoot, Recon-ng, Shodan | Reconnaissance, enumeration |
| **Vuln Research** | Metasploit, Burp Suite, Nuclei | Exploitation, testing |
| **Reverse Eng** | Ghidra, IDA Pro, Binary Ninja | Disassembly, decompilation |
| **Malware** | Cuckoo, Volatility, Yara | Sandboxing, memory analysis |
| **Fuzzing** | AFL, libFuzzer, Peach | Input generation, crash finding |

______________________________________________________________________

**Last Updated:** 2026-02-02 | **Vibe Check:** :fontawesome-solid-binoculars: **Intel is Power** - Threat intel prioritizes defenses. OSINT 80% of intel (public sources undervalued). Commercial feeds expensive ($50k-500k/year). Bug bounties pay millions for 0-days. Reverse engineering requires patience. Attribution hard (false flags common).

**Tags:** threat-intelligence, osint, vulnerability-research, malware-analysis, reverse-engineering
