---
title: Purple Team & Security Engineering
description: Purple teaming, security architecture, detection engineering, security automation, DevSecOps
---

# :fontawesome-solid-people-group: Purple Team & Security Engineering

Bridge between offense and defense. Purple teamers combine red/blue skills to validate security controls. Security engineers build detection systems, automate responses, design security architecture. Detection engineers write rules, tune alerts, measure coverage. DevSecOps embeds security in engineering culture.

!!! tip "2026 Update"
    Purple teaming standard practice (not just red vs. blue). Detection-as-Code (version-controlled rules). Security chaos engineering (break security to improve it). Platform engineering includes security. Continuous validation replaces annual pentests. Security engineering career path distinct from SOC analyst.

______________________________________________________________________

## :fontawesome-solid-bolt-lightning: Quick Hits

=== ":fontawesome-solid-list-check: Core Disciplines"

    **Purple Teaming:**
    ```markdown
    ## Purple Team Exercise Workflow

    ### 1. Planning (Pre-Exercise)
    - **Objective:** Test detection of lateral movement (Pass-the-Hash)
    - **Scope:** Windows domain, 50 servers, 500 endpoints
    - **Red Team:** Simulate PtH using Mimikatz
    - **Blue Team:** Detect via Windows Event Logs (4624, 4625, 4768)
    - **Duration:** 4 hours  # (1)!

    ### 2. Execution (Red Team Attack)
    ```bash
    # Red: Extract credentials from LSASS
    mimikatz.exe "privilege::debug" "sekurlsa::logonpasswords" "exit"  # (2)!

    # Red: Pass-the-Hash lateral movement
    crackmapexec smb 10.0.0.0/24 -u Administrator -H <NTLM_HASH> --shares
    ```

    ### 3. Detection (Blue Team)
    ```python
    # Blue: SIEM detection rule (Splunk)
    index=windows EventCode=4624
    Logon_Type=3  # Network logon
    Authentication_Package="NTLM"
    | stats count by src_ip, dest_host, Account_Name
    | where count > 5  # Rapid lateral movement  # (3)!
    ```

    ### 4. Validation (Purple Team)
    - ✅ **Detected:** 8/10 PtH attempts (80% detection rate)
    - ❌ **Missed:** 2 attempts (NTLM logging disabled on 2 hosts)
    - **Improvement:** Enable NTLM auditing on all hosts  # (4)!

    ### 5. Iteration (Re-test)
    - Red repeats attack after blue improvements
    - Measure detection improvement (80% → 95%)
    ```

    1. Purple team exercises time-boxed (focused testing)
    2. Red team uses real attacker tools (not simulations)
    3. Blue team validates detection rules (not just theory)
    4. Purple team collaboration identifies gaps (immediate feedback loop)

    **Detection Engineering:**
    ```yaml
    # Sigma rule (universal SIEM format)
    title: Suspicious PowerShell Encoded Command
    id: 36210e0d-5b19-485d-a087-c096088885f0
    status: stable
    description: Detects PowerShell with base64-encoded commands
    author: Detection Engineer
    date: 2026-01-15
    tags:
      - attack.execution
      - attack.t1059.001  # MITRE ATT&CK T1059.001  # (1)!
    logsource:
      product: windows
      service: powershell
    detection:
      selection:
        EventID: 4104  # PowerShell script block logging
      filter:
        ScriptBlockText|contains:
          - '-enc'
          - '-EncodedCommand'
          - 'FromBase64String'  # (2)!
      condition: selection and filter
    falsepositives:
      - Legitimate admin scripts (whitelist known scripts)
    level: high
    ```

    1. MITRE ATT&CK mapping for technique tracking
    2. Detection logic: EventID 4104 + base64 encoding indicators

    **Converting Sigma to Splunk:**
    ```bash
    # Sigmac (Sigma converter)
    sigmac -t splunk rule.yml  # (3)!

    # Output (Splunk SPL)
    EventCode=4104 (ScriptBlockText="*-enc*" OR ScriptBlockText="*-EncodedCommand*" OR ScriptBlockText="*FromBase64String*")
    ```

    3. Sigma rules convert to 20+ SIEM platforms (portability)

    **Security Architecture:**
    ```python
    # Zero Trust Architecture principles
    zero_trust_tenets = {
        "1_verify_explicitly": {
            "authentication": "MFA + device trust + location",
            "authorization": "Least privilege, JIT access",
            "continuous": "Re-verify every request"  # (1)!
        },
        "2_least_privilege": {
            "rbac": "Role-based access control",
            "jit": "Just-in-time access (expire after use)",
            "jea": "Just-enough-access (minimal permissions)"
        },
        "3_assume_breach": {
            "segmentation": "Micro-segmentation (limit lateral movement)",
            "encryption": "End-to-end encryption (TLS everywhere)",
            "monitoring": "Logging + anomaly detection"  # (2)!
        }
    }

    # Security control validation (MITRE ATT&CK)
    # Coverage mapping
    attack_coverage = {
        "T1566.001": {  # Phishing: Spearphishing Attachment
            "preventive": ["Email gateway (Proofpoint)", "User training"],
            "detective": ["SIEM rule: suspicious attachments", "EDR: macro execution"],
            "coverage": "80%"  # (3)!
        },
        "T1059.001": {  # Command Scripting: PowerShell
            "preventive": ["AppLocker/WDAC", "Constrained Language Mode"],
            "detective": ["Sigma rule: encoded PowerShell", "EDR: suspicious commands"],
            "coverage": "90%"
        }
    }
    ```

    1. Zero Trust eliminates implicit trust (always verify)
    2. Assume breach mindset focuses on detection + response
    3. Coverage scoring identifies gaps (ATT&CK Navigator)

    **DevSecOps Pipeline:**
    ```yaml
    # .gitlab-ci.yml (security-focused pipeline)
    stages:
      - build
      - test
      - security
      - deploy

    build:
      stage: build
      script:
        - docker build -t myapp:$CI_COMMIT_SHA .

    sast:
      stage: security
      script:
        - semgrep --config=auto src/  # (1)!
        - snyk code test

    sca:
      stage: security
      script:
        - snyk test --severity-threshold=high  # (2)!
        - trivy image myapp:$CI_COMMIT_SHA

    dast:
      stage: security
      script:
        - docker run -t owasp/zap2docker-stable zap-baseline.py -t https://staging.example.com  # (3)!

    secrets:
      stage: security
      script:
        - gitleaks detect --source . --verbose

    deploy:
      stage: deploy
      script:
        - kubectl apply -f k8s/
      only:
        - main  # (4)!
    ```

    1. SAST finds code vulnerabilities (shift left)
    2. SCA fails pipeline on high/critical CVEs
    3. DAST tests running application (staging environment)
    4. Deploy only after passing security gates

    **Security Automation (SOAR):**
    ```python
    # Automated phishing response (Splunk SOAR example)
    def phishing_playbook(event):
        """Automated response to phishing alert."""
        # 1. Enrich email (VirusTotal, URL scan)
        email_hash = event['attachment_hash']
        vt_result = virustotal_scan(email_hash)  # (1)!

        # 2. Quarantine email (Exchange API)
        if vt_result['malicious'] > 5:
            exchange_quarantine(event['message_id'])  # (2)!

        # 3. Disable user account (Active Directory)
        if event['user_clicked']:
            ad_disable_account(event['username'])  # (3)!

        # 4. Create ticket (Jira)
        jira_create_ticket(
            summary=f"Phishing: {event['subject']}",
            description=f"User {event['username']} received phishing",
            priority="High"
        )  # (4)!

        # 5. Send Slack notification
        slack_notify(f"🚨 Phishing detected: {event['subject']}")
    ```

    1. Automated enrichment (VirusTotal, URLScan, Hybrid Analysis)
    2. Containment (quarantine email, block sender)
    3. Remediation (disable compromised account)
    4. Communication (ticket, notification, escalation)

    **Real talk:**

    - Purple team accelerates improvement (no more red vs. blue silos)
    - Detection engineering requires both red/blue skills (understand attacks to detect)
    - Security architecture prevents vulnerabilities at design phase
    - DevSecOps shifts security left (earlier in pipeline = cheaper to fix)
    - SOAR reduces analyst burnout (automate repetitive tasks)
    - Detection-as-Code enables version control, testing, peer review

=== ":fontawesome-solid-bolt: Common Patterns"

    **MITRE ATT&CK Coverage Mapping:**
    ```python
    # ATT&CK Navigator layer (JSON)
    {
        "name": "Organization Detection Coverage",
        "versions": {
            "attack": "14",
            "navigator": "4.9.4",
            "layer": "4.5"
        },
        "domain": "enterprise-attack",
        "techniques": [
            {
                "techniqueID": "T1566.001",  # Phishing
                "score": 80,  # 80% coverage  # (1)!
                "color": "#ffaa00",
                "comment": "Detected by: Email gateway, SIEM rule, user training"
            },
            {
                "techniqueID": "T1059.001",  # PowerShell
                "score": 90,
                "color": "#00ff00",
                "comment": "Detected by: Sigma rules, EDR, script block logging"
            },
            {
                "techniqueID": "T1003.001",  # LSASS Memory
                "score": 50,  # Gap!
                "color": "#ff0000",
                "comment": "Partial detection: Only on 50% of endpoints"  # (2)!
            }
        ]
    }
    ```

    1. Coverage scoring identifies strong detections
    2. Gaps highlighted in red (prioritize improvement)

    **Atomic Red Team (Validation Framework):**
    ```bash
    # Atomic Red Team (automated ATT&CK testing)
    # Install
    Install-Module -Name invoke-atomicredteam  # (1)!

    # Test T1059.001 (PowerShell)
    Invoke-AtomicTest T1059.001  # (2)!

    # Output:
    # Executing: powershell.exe -enc <base64>
    # Check SIEM for alert...

    # Test multiple techniques
    Invoke-AtomicTest T1003.001,T1055,T1082  # (3)!

    # Continuous validation (cron job)
    # Run Atomic tests daily, report detection rate
    ```

    1. Atomic Red Team framework for ATT&CK technique testing
    2. Execute single technique (validate detection)
    3. Test multiple techniques (measure overall coverage)

    **Detection-as-Code Workflow:**
    ```bash
    # Git repository structure
    detection-rules/
    ├── sigma/
    │   ├── powershell/
    │   │   └── powershell_encoded_command.yml
    │   ├── lateral_movement/
    │   │   └── pass_the_hash.yml
    ├── tests/
    │   └── test_powershell_rules.py
    ├── .github/workflows/
    │   └── validate.yml  # CI/CD pipeline  # (1)!
    └── README.md

    # CI/CD pipeline (.github/workflows/validate.yml)
    name: Validate Detection Rules
    on: [push, pull_request]
    jobs:
      validate:
        runs-on: ubuntu-latest
        steps:
          - uses: actions/checkout@v4
          - name: Validate Sigma rules
            run: |
              pip install sigmac  # (2)!
              sigmac --target splunk sigma/**/*.yml
          - name: Run tests
            run: |
              pytest tests/  # (3)!
    ```

    1. Detection rules version-controlled (Git)
    2. CI validates syntax before merge
    3. Unit tests verify rule logic (test data)

    **Security Chaos Engineering:**
    ```python
    # Intentionally break security controls to test resilience
    import random
    import time

    def chaos_experiment_disable_waf():
        """Chaos experiment: Disable WAF, measure detection time."""
        print("🔥 Starting chaos experiment: Disabling WAF...")

        # 1. Disable WAF (controlled)
        waf_disable()  # (1)!
        start_time = time.time()

        # 2. Launch test attack (SQLi)
        attack_result = sqlmap_test_attack()

        # 3. Measure MTTD (Mean Time To Detect)
        if siem_alert_triggered():
            detection_time = time.time() - start_time
            print(f"✅ Detected in {detection_time:.2f} seconds")
        else:
            print("❌ NOT DETECTED - Blind spot identified!")  # (2)!

        # 4. Re-enable WAF
        waf_enable()

        # 5. Report findings
        return {
            "experiment": "WAF disabled",
            "detected": siem_alert_triggered(),
            "mttd": detection_time if siem_alert_triggered() else None
        }  # (3)!
    ```

    1. Controlled chaos (non-production environment)
    2. Identify blind spots (single point of failure)
    3. Measure resilience metrics (MTTD, MTTR)

    **Security Metrics & KPIs:**
    ```python
    # Security program effectiveness metrics
    security_metrics = {
        "detection": {
            "MTTD": "15 minutes",  # Mean Time To Detect  # (1)!
            "coverage": "85%",     # ATT&CK technique coverage
            "false_positive_rate": "5%"
        },
        "response": {
            "MTTR": "2 hours",     # Mean Time To Respond  # (2)!
            "MTTC": "4 hours",     # Mean Time To Contain
            "MTTR_full": "24 hours"  # Mean Time To Recover
        },
        "vulnerability_management": {
            "critical_sla": "7 days",    # Patch critical vulns in 7 days
            "high_sla": "30 days",
            "backlog": "12 critical, 45 high"  # (3)!
        },
        "security_posture": {
            "misconfigurations": "32",   # CSPM findings
            "patching_compliance": "92%",
            "mfa_adoption": "98%"
        }
    }
    ```

    1. MTTD measures detection speed (lower is better)
    2. MTTR measures response speed (containment + recovery)
    3. Vulnerability SLAs ensure timely patching

    **Why this works:**

    - Purple team validates controls work (theory vs. reality)
    - Detection engineering ensures coverage (no blind spots)
    - Security architecture prevents vulnerabilities at design
    - DevSecOps embeds security in engineering workflow
    - Automation scales security (humans don't scale)
    - Metrics measure effectiveness (can't improve what you don't measure)

=== ":fontawesome-solid-fire: Pro Tips & Gotchas"

    !!! success "Best Practices"
        - **Purple team regularly** - Quarterly exercises (not just annual)
        - **Detection-as-Code** - Version control, peer review, CI/CD
        - **MITRE ATT&CK mapping** - Map every detection to technique
        - **Atomic Red Team** - Continuous validation (automated testing)
        - **Metrics-driven** - Measure MTTD, MTTR, coverage
        - **Shift left** - Security in design phase (not afterthought)
        - **Automate toil** - SOAR for repetitive tasks (free analysts for hunting)

    !!! warning "Purple Team Reality"
        - **Culture clash** - Red/blue teams historically adversarial
        - **Skill gaps** - Purple team requires both offensive + defensive skills
        - **Time commitment** - Exercises require coordination (4-8 hours)
        - **Tool sprawl** - 10+ security tools to integrate
        - **Alert fatigue** - Tuning never ends (environments change)
        - **False sense of security** - Passing purple team ≠ secure
        - **Metrics gaming** - Teams optimize for metrics (not security)

    !!! tip "Essential Tools"
        - **Purple Team** - Atomic Red Team (free), Caldera (free), Vectr (free)
        - **Detection** - Sigma (free), Elastic Detection Rules (free), Splunk Security Content (free)
        - **SOAR** - Splunk SOAR ($), Palo Alto Cortex XSOAR ($), Shuffle (free)
        - **Validation** - MITRE ATT&CK Navigator (free), Atomic Red Team (free)
        - **DevSecOps** - Semgrep (free), Snyk ($), GitHub Advanced Security ($)
        - **Architecture** - MITRE ATT&CK (free), Threat modeling tools (free/paid)

    !!! danger "Gotchas"
        - **Detection gaps** - Single control failure = blind spot (defense in depth)
        - **Alert tuning** - Never-ending process (new apps, infrastructure changes)
        - **False negatives** - Missed detections worse than false positives
        - **Tool fatigue** - Too many security tools (integration nightmare)
        - **Sigma limitations** - Not all SIEM features supported (custom rules still needed)
        - **Atomic Red Team noise** - Some tests trigger too many alerts
        - **DevSecOps friction** - Security gates slow deployments (balance speed vs. security)

______________________________________________________________________

## :fontawesome-solid-graduation-cap: Learning & Certifications

### :fontawesome-solid-book-open: Certifications

- **[GIAC Certified Detection Analyst (GCDA)](https://www.giac.org/certifications/certified-detection-analyst-gcda/)** - $2499, detection engineering
- **[Certified Red Team Operator (CRTO)](https://www.zeropointsecurity.co.uk/red-team-ops)** - $550, red team operations
- **[AWS Certified Security - Specialty](https://aws.amazon.com/certification/certified-security-specialty/)** - $300, cloud security architecture
- **[SABSA](https://sabsa.org/)** - Varies, security architecture framework

### :fontawesome-solid-rocket: Practice

- **[Detection Lab](https://github.com/clong/DetectionLab)** - Free, purple team lab environment
- **[Atomic Red Team](https://github.com/redcanaryco/atomic-red-team)** - Free, ATT&CK technique testing
- **[Caldera](https://github.com/mitre/caldera)** - Free, automated adversary emulation

______________________________________________________________________

## :fontawesome-solid-wrench: Essential Toolkit

| Category | Tools | Purpose |
|----------|-------|---------|
| **Purple Team** | Atomic Red Team, Caldera, Vectr | Technique validation, collaboration |
| **Detection** | Sigma, Elastic Detection Rules, Splunk | Rule authoring, SIEM queries |
| **SOAR** | Splunk SOAR, Cortex XSOAR, Shuffle | Automation, orchestration |
| **Validation** | ATT&CK Navigator, Purple Knight | Coverage mapping, AD assessment |
| **DevSecOps** | Semgrep, Snyk, Trivy, Gitleaks | Pipeline security scanning |
| **Architecture** | Threat modeling tools, draw.io | Design security, threat models |

______________________________________________________________________

**Last Updated:** 2026-02-02 | **Vibe Check:** :fontawesome-solid-handshake: **Collaboration Wins** - Purple team eliminates red vs. blue silos. Detection engineering requires offensive + defensive skills. Security architecture prevents issues at design. DevSecOps culture shift difficult but necessary. SOAR reduces alert fatigue. Metrics measure effectiveness (MTTD, MTTR).

**Tags:** purple-team, detection-engineering, security-engineering, devsecops, security-automation, security-architecture
