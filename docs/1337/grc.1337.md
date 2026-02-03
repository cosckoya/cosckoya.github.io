---
title: GRC (Governance, Risk & Compliance)
description: Security governance, risk management, compliance auditing, frameworks (GDPR, HIPAA, PCI-DSS, SOC 2, ISO 27001)
---

# :fontawesome-solid-scale-balanced: GRC (Governance, Risk & Compliance)

The paperwork side of security. Policies, procedures, risk assessments, compliance audits. Not sexy, but keeps companies out of legal trouble and million-dollar fines. GRC teams ensure security aligns with business goals and regulatory requirements.

!!! tip "2026 Update"
    AI-powered risk assessments. Continuous compliance monitoring (no more annual audits). Privacy regulations expanding (50+ countries have GDPR equivalents). ESG (Environmental, Social, Governance) now includes cyber. Zero-trust architecture standard requirement.

______________________________________________________________________

## :fontawesome-solid-bolt-lightning: Quick Hits

=== ":fontawesome-solid-list-check: Core Areas"

    **Security Governance:**
    ```markdown
    ## Information Security Policy Framework

    ### 1. Organizational Policies (Board-level)
    - Information Security Policy (master policy)
    - Risk Management Policy
    - Data Classification Policy
    - Acceptable Use Policy

    ### 2. Standards (Mandatory requirements)
    - Password Standards (15+ chars, MFA required)  # (1)!
    - Encryption Standards (AES-256, TLS 1.3+)
    - Patch Management Standards (Critical: 7 days, High: 30 days)

    ### 3. Procedures (How-to guides)
    - Incident Response Procedures
    - Access Request Procedures
    - Change Management Procedures

    ### 4. Guidelines (Best practices)
    - Secure Coding Guidelines
    - Remote Work Guidelines
    - BYOD Guidelines
    ```

    1. NIST 800-63B: 8+ chars minimum, 15+ recommended

    **Risk Management:**
    ```python
    # Quantitative Risk Assessment
    # Formula: ALE = SLE × ARO
    # ALE (Annual Loss Expectancy)
    # SLE (Single Loss Expectancy)
    # ARO (Annualized Rate of Occurrence)

    asset_value = 1_000_000  # $ value of asset
    exposure_factor = 0.30    # 30% loss if compromised
    sle = asset_value * exposure_factor  # $300,000

    aro = 0.1  # 10% chance per year (once per 10 years)
    ale = sle * aro  # $30,000/year expected loss  # (1)!

    # Risk treatment decision
    if ale < 10_000:
        decision = "Accept risk"
    elif ale < 50_000:
        decision = "Mitigate risk (implement controls)"
    else:
        decision = "Transfer risk (insurance) or Avoid"  # (2)!
    ```

    1. ALE justifies security spending (spend < ALE)
    2. Risk treatment: Accept, Mitigate, Transfer, Avoid

    **Compliance Frameworks:**
    ```bash
    # GDPR (EU Data Protection)
    - Right to Access (Art. 15)
    - Right to Erasure (Art. 17) - "Right to be forgotten"
    - Data Breach Notification (Art. 33) - 72 hours  # (1)!
    - DPO required (> 250 employees or sensitive data)
    - Fines: 4% global revenue or €20M (whichever higher)

    # HIPAA (US Healthcare)
    - Privacy Rule (PHI protection)
    - Security Rule (safeguards: admin, physical, technical)
    - Breach Notification (60 days)  # (2)!
    - Business Associate Agreements (BAAs) required

    # PCI-DSS (Payment Card Industry)
    - 12 requirements, 6 control objectives
    - Quarterly vulnerability scans (ASV required)
    - Annual penetration testing
    - Encryption of cardholder data (at rest, in transit)
    - Fines: $5k-100k/month for non-compliance  # (3)!

    # SOC 2 (Service Organization Control)
    - Type I: Design effectiveness (point-in-time)
    - Type II: Operating effectiveness (6-12 months)
    - Trust Services Criteria: Security, Availability, Confidentiality, Processing Integrity, Privacy
    - Required for SaaS vendors

    # ISO 27001 (ISMS Certification)
    - 114 controls (Annex A)
    - Annual surveillance audits
    - 3-year recertification cycle
    - Global recognition (better than SOC 2 internationally)
    ```

    1. GDPR 72-hour breach notification strictest globally
    2. HIPAA 60-day notification (less strict than GDPR)
    3. PCI-DSS fines per merchant agreement (can be millions)

    **Real talk:**

    - Compliance ≠ security (check-box doesn't prevent breaches)
    - GDPR fines rare but massive (Google: €50M, Amazon: €746M)
    - SOC 2 Type II takes 6-12 months (expensive, $50k-150k)
    - ISO 27001 internationally recognized (SOC 2 US-centric)
    - Risk assessments often subjective (quantitative better than qualitative)

=== ":fontawesome-solid-bolt: Common Patterns"

    **Risk Assessment Matrix:**
    ```markdown
    ## Risk Scoring: Impact × Likelihood

    | Impact/Likelihood | Very Low (1) | Low (2) | Medium (3) | High (4) | Critical (5) |
    |-------------------|--------------|---------|------------|----------|--------------|
    | **Critical (5)**  | 5 (Low)      | 10 (Med)| 15 (High)  | 20 (Crit)| 25 (Crit)    |
    | **High (4)**      | 4 (Low)      | 8 (Med) | 12 (High)  | 16 (High)| 20 (Crit)    |
    | **Medium (3)**    | 3 (Low)      | 6 (Med) | 9 (Med)    | 12 (High)| 15 (High)    |
    | **Low (2)**       | 2 (Low)      | 4 (Low) | 6 (Med)    | 8 (Med)  | 10 (Med)     |
    | **Very Low (1)**  | 1 (Low)      | 2 (Low) | 3 (Low)    | 4 (Low)  | 5 (Low)      |

    ## Risk Response Thresholds
    - **Critical (16-25)**: Immediate action required
    - **High (12-15)**: Mitigate within 30 days
    - **Medium (6-11)**: Mitigate within 90 days
    - **Low (1-5)**: Accept or mitigate opportunistically
    ```

    **Compliance Checklist (SOC 2 Type II):**
    ```yaml
    SOC 2 Type II Readiness:

    Security Principle:
      - [ ] Multi-factor authentication enforced  # (1)!
      - [ ] Encryption at rest (AES-256)
      - [ ] Encryption in transit (TLS 1.2+)
      - [ ] Firewall rules documented
      - [ ] IDS/IPS deployed
      - [ ] Vulnerability scanning (monthly)
      - [ ] Penetration testing (annual)
      - [ ] Security awareness training (annual)
      - [ ] Incident response plan tested

    Availability:
      - [ ] 99.9% uptime SLA
      - [ ] Monitoring and alerting
      - [ ] Disaster recovery plan tested (annual)
      - [ ] Backup testing (quarterly)

    Confidentiality:
      - [ ] NDA with employees/vendors
      - [ ] Data classification policy
      - [ ] DLP (Data Loss Prevention) implemented

    Processing Integrity:
      - [ ] Change management process
      - [ ] Segregation of duties
      - [ ] Input validation

    Privacy (if applicable):
      - [ ] Privacy policy published
      - [ ] Data retention policy
      - [ ] Data subject rights procedures  # (2)!
    ```

    1. MFA critical control (auditors always check)
    2. GDPR-style rights (access, deletion, portability)

    **Policy Template:**
    ```markdown
    # Data Classification and Handling Policy

    ## Purpose
    Establish framework for classifying and protecting organizational data.

    ## Scope
    Applies to all employees, contractors, systems processing company data.

    ## Data Classification Levels

    ### Public (P0)
    - **Definition**: Information approved for public release
    - **Examples**: Marketing materials, press releases
    - **Handling**: No restrictions
    - **Retention**: Indefinite

    ### Internal (P1)
    - **Definition**: Information for internal use
    - **Examples**: Project plans, internal docs
    - **Handling**: Company network only, no public sharing
    - **Retention**: 7 years  # (1)!

    ### Confidential (P2)
    - **Definition**: Sensitive business information
    - **Examples**: Financial data, customer data, source code
    - **Handling**: Need-to-know, encrypted at rest/transit, MFA required
    - **Retention**: Varies by regulation (GDPR: minimize retention)

    ### Restricted (P3)
    - **Definition**: Highest sensitivity (legal/regulatory)
    - **Examples**: PII, PHI, PCI data, trade secrets
    - **Handling**: Strict access controls, encryption, audit logging, DLP
    - **Retention**: Minimum required by law

    ## Enforcement
    Violations result in disciplinary action up to termination.

    ## Review Cycle
    Annual review by CISO, approved by Board.

    ---
    **Approved by**: [CISO Name]
    **Effective Date**: 2026-01-01
    **Next Review**: 2027-01-01
    ```

    1. 7 years common for business records (Sarbanes-Oxley)

    **Audit Evidence Collection:**
    ```bash
    # SOC 2 audit evidence gathering
    mkdir -p soc2_evidence/{security,availability,confidentiality}

    # Security controls evidence
    # MFA enrollment report
    aws iam get-account-summary > soc2_evidence/security/mfa_report.txt

    # Access reviews (quarterly)
    aws iam list-users --output table > soc2_evidence/security/user_access_q1.txt

    # Vulnerability scan results (monthly)
    cp nessus_scan_2026-01.pdf soc2_evidence/security/vuln_scan_jan.pdf

    # Penetration test report (annual)
    cp pentest_report_2026.pdf soc2_evidence/security/pentest_2026.pdf

    # Security awareness training records
    cp knowbe4_training_completion.csv soc2_evidence/security/training_2026.csv

    # Availability evidence
    # Uptime reports (monthly)
    curl "https://api.pingdom.com/api/3.1/summary.average" > soc2_evidence/availability/uptime_jan.json

    # Backup logs
    cp backup_logs_2026_q1.txt soc2_evidence/availability/

    # DR test results (annual)
    cp dr_test_results_2026.pdf soc2_evidence/availability/  # (1)!
    ```

    1. Auditors want evidence controls operated throughout period

    **Why this works:**

    - Policies provide legal defensibility
    - Risk assessments prioritize security spending
    - Compliance reduces liability and fines
    - Frameworks provide structured approach
    - Audit evidence proves control effectiveness

=== ":fontawesome-solid-fire: Pro Tips & Gotchas"

    !!! success "Best Practices"
        - **Start with framework** - NIST CSF, ISO 27001, CIS Controls
        - **Risk-based approach** - Focus on highest risks first
        - **Continuous compliance** - Automate evidence collection (not annual scramble)
        - **Third-party risk** - Vendor security assessments required
        - **Board reporting** - Executives understand risk, not tech
        - **GRC tools** - OneTrust, Vanta, Drata automate compliance
        - **Gap analysis** - Assess current state vs. framework requirements

    !!! warning "Compliance Reality"
        - **Scope creep** - Start small (single product/service), expand later
        - **False sense of security** - Compliance ≠ secure (Target was PCI compliant)
        - **Cost** - SOC 2: $50k-150k, ISO 27001: $30k-100k, audits annually
        - **Time** - SOC 2 Type II: 6-12 months, ISO 27001: 6-18 months
        - **Consultant dependency** - First audit needs consultants ($$$)
        - **Continuous monitoring** - Annual audits outdated (move to continuous)

    !!! tip "GRC Tools"
        - **OneTrust** - Privacy/GRC platform ($$$)
        - **Vanta** - Automated SOC 2/ISO 27001 ($3k-10k/year)
        - **Drata** - Continuous compliance ($3k-10k/year)
        - **Secureframe** - Compliance automation ($3k-10k/year)
        - **NIST CSF** - Free framework (start here)
        - **CIS Controls** - Free, prioritized controls

    !!! danger "Gotchas"
        - **Checkbox compliance** - Passing audit doesn't mean secure
        - **Inherited risk** - Cloud providers (AWS/Azure) don't eliminate your risk
        - **Audit fatigue** - Multiple frameworks (SOC 2, ISO 27001, GDPR) overlap 80%
        - **Scope definition** - Narrower scope = cheaper audit (but less coverage)
        - **Continuous compliance** - Controls must operate entire period (not just audit week)
        - **Vendor dependencies** - Third-party breaches = your breach (supply chain)
        - **GDPR fines** - Rare but massive (intentional violations = 4% global revenue)

______________________________________________________________________

## :fontawesome-solid-graduation-cap: Learning & Certifications

### :fontawesome-solid-book-open: Certifications

- **[CISSP](https://www.isc2.org/Certifications/CISSP)** - $749, 5 years experience, management-focused
- **[CISM](https://www.isaca.org/credentialing/cism)** - $575, risk management focus
- **[CRISC](https://www.isaca.org/credentialing/crisc)** - $575, IT risk and compliance
- **[CGRC](https://www.eccouncil.org/train-certify/certified-in-governance-risk-and-compliance-cgrc/)** - $999, GRC-specific
- **[CIPP/E](https://iapp.org/certify/cipp/europe/)** - $550, privacy (GDPR focus)

### :fontawesome-solid-rocket: Frameworks

- **[NIST Cybersecurity Framework](https://www.nist.gov/cyberframework)** - Free, widely adopted
- **[CIS Controls](https://www.cisecurity.org/controls/)** - Free, prioritized security controls
- **[ISO 27001](https://www.iso.org/isoiec-27001-information-security.html)** - International standard
- **[COBIT](https://www.isaca.org/resources/cobit)** - IT governance framework

______________________________________________________________________

**Last Updated:** 2026-02-02 | **Vibe Check:** :fontawesome-solid-file-contract: **Necessary Evil** - Not glamorous but essential. Prevents million-dollar fines. Compliance ≠ security. Audit prep stressful. GRC tools expensive but worth it. CISSP gold standard cert. Job stable (regulations increasing).

**Tags:** grc, governance, risk-management, compliance, audit
