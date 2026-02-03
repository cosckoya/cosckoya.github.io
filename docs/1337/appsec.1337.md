---
title: Application Security (AppSec)
description: Secure development, code review, SAST/DAST, DevSecOps, bug bounty, API security testing
---

# :fontawesome-solid-code: Application Security (AppSec)

Securing code before it ships. Static/dynamic analysis, secure coding, threat modeling, dependency scanning. Shift security left into CI/CD. Find vulnerabilities in code, dependencies, APIs. DevSecOps integration makes security everyone's problem, not just the security team's afterthought.

!!! tip "2026 Update"
    AI-powered code review (GPT-4 finds logic flaws). SAST/DAST in every pipeline. SCA (Software Composition Analysis) critical (87% apps use vulnerable dependencies). API security massive focus (APIs are 83% of web traffic). Supply chain attacks mainstream concern. DevSecOps standard practice.

______________________________________________________________________

## :fontawesome-solid-bolt-lightning: Quick Hits

=== ":fontawesome-solid-list-check: Core Disciplines"

    **Secure Development Lifecycle:**
    ```python
    # Threat Modeling (STRIDE framework)
    # S - Spoofing (authentication bypass)
    # T - Tampering (data manipulation)
    # R - Repudiation (deny actions taken)
    # I - Information Disclosure (data leaks)
    # D - Denial of Service (availability attacks)
    # E - Elevation of Privilege (privilege escalation)

    # Example: Login API threat model
    threats = {
        "Spoofing": "Weak password policy allows brute force",  # (1)!
        "Tampering": "No input validation on username field (SQLi)",
        "Repudiation": "No audit logging for failed login attempts",
        "Info Disclosure": "Error messages reveal user existence",
        "DoS": "No rate limiting on login endpoint",
        "Elevation": "Session token predictable (weak PRNG)"
    }

    # Mitigation strategies
    mitigations = {
        "Spoofing": "MFA, bcrypt password hashing (cost factor 12+)",
        "Tampering": "Parameterized queries, input validation",
        "Repudiation": "Centralized logging (ELK, Splunk)",
        "Info Disclosure": "Generic error messages",
        "DoS": "Rate limiting (10 attempts/5 min), CAPTCHA",
        "Elevation": "Cryptographically secure tokens (JWT HS256+)"
    }
    ```

    1. STRIDE helps systematically identify threats per component

    **Static Application Security Testing (SAST):**
    ```bash
    # Semgrep (open source, fast)
    semgrep --config=auto src/  # (1)!
    semgrep --config=p/owasp-top-ten src/

    # SonarQube (enterprise)
    sonar-scanner \
      -Dsonar.projectKey=myapp \
      -Dsonar.sources=src/ \
      -Dsonar.host.url=http://localhost:9000

    # Snyk Code (developer-friendly)
    snyk code test  # (2)!

    # Bandit (Python-specific)
    bandit -r src/ -f json -o bandit-report.json  # (3)!

    # CodeQL (GitHub Advanced Security)
    codeql database create db --language=javascript
    codeql database analyze db --format=sarif-latest --output=results.sarif
    ```

    1. Semgrep auto detects language, fast scanning (10k LoC in seconds)
    2. Snyk integrates with IDEs (real-time feedback while coding)
    3. Bandit finds Python security issues (SQL injection, hardcoded secrets)

    **Dynamic Application Security Testing (DAST):**
    ```bash
    # OWASP ZAP (free, automated scanning)
    docker run -t owasp/zap2docker-stable zap-baseline.py \
      -t https://target.com  # (1)!

    # Burp Suite Pro (manual + automated)
    # 1. Proxy traffic through Burp (localhost:8080)
    # 2. Spider/Crawl application
    # 3. Run active scan
    # 4. Review findings (SQLi, XSS, CSRF, etc.)

    # Nuclei (template-based scanning)
    nuclei -u https://target.com \
      -t cves/ -t vulnerabilities/ -t misconfigurations/  # (2)!

    # OWASP Dependency-Check (SCA)
    dependency-check.sh --project myapp --scan ./  # (3)!
    ```

    1. ZAP baseline scan safe for CI/CD (passive + some active)
    2. Nuclei 5000+ templates (CVEs, misconfigs, default creds)
    3. Dependency-Check finds vulnerable libraries (CVE database)

    **Secure Coding Patterns:**
    ```python
    # Input validation (whitelist approach)
    import re
    from typing import Optional

    def validate_email(email: str) -> Optional[str]:
        """Validate email with whitelist regex."""
        pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
        if re.match(pattern, email):
            return email
        raise ValueError("Invalid email format")  # (1)!

    # SQL injection prevention (parameterized queries)
    import sqlite3

    def get_user(username: str):
        conn = sqlite3.connect('users.db')
        cursor = conn.cursor()
        # ❌ VULNERABLE: cursor.execute(f"SELECT * FROM users WHERE username = '{username}'")
        # ✅ SAFE: Parameterized query
        cursor.execute("SELECT * FROM users WHERE username = ?", (username,))  # (2)!
        return cursor.fetchone()

    # XSS prevention (output encoding)
    from markupsafe import escape

    def render_comment(comment: str) -> str:
        """Escape HTML to prevent XSS."""
        return f"<div>{escape(comment)}</div>"  # (3)!

    # CSRF prevention (token validation)
    import secrets

    def generate_csrf_token() -> str:
        """Generate cryptographically secure token."""
        return secrets.token_urlsafe(32)  # (4)!
    ```

    1. Always validate input (never trust user data)
    2. Parameterized queries prevent SQL injection
    3. Output encoding prevents XSS (< becomes &lt;)
    4. CSRF tokens prevent cross-site request forgery

    **Real talk:**

    - SAST catches ~30% of issues (false positives high)
    - DAST finds runtime issues SAST misses (auth bugs, business logic)
    - SCA critical (87% apps use vulnerable dependencies)
    - Manual code review still necessary (tools miss logic flaws)
    - API security often overlooked (83% of web traffic now APIs)
    - Secrets in code common (GitHub scans find thousands daily)

=== ":fontawesome-solid-bolt: Common Patterns"

    **DevSecOps Pipeline Integration:**
    ```yaml
    # GitHub Actions - Security Pipeline
    name: Security Scan

    on: [push, pull_request]

    jobs:
      sast:
        runs-on: ubuntu-latest
        steps:
          - uses: actions/checkout@v4

          # Semgrep SAST
          - name: Run Semgrep
            uses: returntocorp/semgrep-action@v1
            with:
              config: >-
                p/security-audit
                p/owasp-top-ten  # (1)!

          # Snyk Code SAST
          - name: Snyk Code Test
            uses: snyk/actions/node@master
            env:
              SNYK_TOKEN: ${{ secrets.SNYK_TOKEN }}
            with:
              command: code test

      sca:
        runs-on: ubuntu-latest
        steps:
          # Dependency vulnerability scanning
          - name: Snyk SCA
            uses: snyk/actions/node@master
            env:
              SNYK_TOKEN: ${{ secrets.SNYK_TOKEN }}
            with:
              command: test --severity-threshold=high  # (2)!

          # Trivy container scanning
          - name: Trivy Scan
            uses: aquasecurity/trivy-action@master
            with:
              image-ref: myapp:latest
              format: sarif
              output: trivy-results.sarif

      secrets:
        runs-on: ubuntu-latest
        steps:
          # Gitleaks secret scanning
          - name: Gitleaks
            uses: gitleaks/gitleaks-action@v2  # (3)!

      dast:
        runs-on: ubuntu-latest
        steps:
          # OWASP ZAP baseline scan
          - name: ZAP Scan
            uses: zaproxy/action-baseline@v0.7.0
            with:
              target: https://staging.example.com  # (4)!
    ```

    1. Semgrep rulesets for common vulnerabilities
    2. Fail build on high/critical severity vulnerabilities
    3. Gitleaks scans for hardcoded secrets (API keys, passwords)
    4. DAST runs against staging environment (not production)

    **API Security Testing:**
    ```bash
    # API fuzzing with ffuf
    ffuf -u https://api.example.com/v1/users/FUZZ \
      -w ids.txt -mc 200,401,403  # (1)!

    # REST API security checklist
    # 1. Authentication (JWT, OAuth 2.0)
    # 2. Authorization (RBAC, ABAC)
    # 3. Rate limiting (prevent abuse)
    # 4. Input validation (JSON schema)
    # 5. Output encoding (prevent XSS in JSON)
    # 6. HTTPS only (TLS 1.3+)
    # 7. CORS configuration (restrict origins)

    # OWASP API Security Top 10 (2023)
    # API1: Broken Object Level Authorization (BOLA/IDOR)
    curl https://api.example.com/v1/users/123/orders  # (2)!
    curl https://api.example.com/v1/users/456/orders  # Can I see other users?

    # API2: Broken Authentication
    # Test: Weak JWT secrets, no expiration, predictable tokens

    # API3: Broken Object Property Level Authorization
    # Test: Mass assignment, excessive data exposure

    # Testing with Postman + Newman
    newman run api-security-tests.json \
      --environment staging.json \
      --reporters cli,json  # (3)!
    ```

    1. Fuzz API endpoints to find hidden/unauthorized resources
    2. IDOR testing (can user A access user B's data?)
    3. Newman runs Postman collections in CI/CD

    **Vulnerability Disclosure Process:**
    ```markdown
    ## Responsible Disclosure Policy (security.txt)

    ### Reporting
    - **Email:** security@example.com (PGP key: https://example.com/pgp)
    - **Encrypted:** https://hackerone.com/example (Bug Bounty)
    - **Response Time:** 3 business days acknowledgment

    ### Scope
    **In Scope:**
    - example.com, *.example.com (production)
    - api.example.com
    - mobile.example.com

    **Out of Scope:**
    - staging.example.com (test environment)
    - Social engineering, physical attacks
    - DoS/DDoS attacks
    - Spam, brute force (rate limiting expected)

    ### Severity Levels  # (1)!
    | Severity | Examples | Response Time | Bounty |
    |----------|----------|---------------|--------|
    | **Critical** | RCE, Auth bypass, SQLi | 24 hours | $5,000-$20,000 |
    | **High** | XSS (stored), IDOR | 7 days | $1,000-$5,000 |
    | **Medium** | CSRF, XSS (reflected) | 30 days | $500-$1,000 |
    | **Low** | Info disclosure | 90 days | $100-$500 |

    ### Disclosure Timeline
    1. **Day 0:** Researcher submits report
    2. **Day 1-3:** Triage and acknowledgment
    3. **Day 4-90:** Develop fix, coordinate disclosure
    4. **Day 90:** Public disclosure (or coordinated earlier)  # (2)!
    ```

    1. CVSS scoring determines severity
    2. 90-day disclosure standard (Google Project Zero)

    **Secure Code Review Checklist:**
    ```python
    # Authentication & Session Management
    - [ ] Passwords hashed with bcrypt/Argon2 (cost factor 12+)
    - [ ] MFA available for privileged accounts
    - [ ] Session tokens cryptographically random (secrets.token_urlsafe)
    - [ ] Session timeout configured (15-30 min idle)
    - [ ] HTTPS only (secure flag on cookies)

    # Input Validation
    - [ ] All user input validated (whitelist approach)
    - [ ] Parameterized queries for SQL (no string concatenation)
    - [ ] File upload validation (type, size, content scanning)
    - [ ] JSON/XML parsers configured securely (no XXE)

    # Output Encoding
    - [ ] HTML output encoded (prevent XSS)
    - [ ] JSON responses properly escaped
    - [ ] Content-Type headers set correctly

    # Access Control
    - [ ] Authorization checks on every endpoint
    - [ ] Principle of least privilege enforced
    - [ ] Direct object references use UUIDs (not sequential IDs)  # (1)!
    - [ ] API rate limiting implemented

    # Cryptography
    - [ ] TLS 1.3 enforced (1.2 minimum)
    - [ ] Strong cipher suites only (no RC4, DES, MD5)
    - [ ] Secrets in environment variables (not code)
    - [ ] Key rotation policy defined

    # Error Handling
    - [ ] Generic error messages to users (no stack traces)
    - [ ] Detailed errors logged server-side only
    - [ ] No sensitive data in logs (passwords, tokens, PII)

    # Dependencies
    - [ ] All dependencies scanned (Snyk, Dependabot)
    - [ ] No known high/critical CVEs
    - [ ] Dependency pinning (lock files committed)
    ```

    1. UUIDs prevent IDOR (Insecure Direct Object Reference)

    **Why this works:**

    - Shift left finds issues early (cheaper to fix)
    - Automated scanning in CI/CD catches regressions
    - Multiple layers (SAST + DAST + SCA) cover different attack vectors
    - Secure coding standards prevent entire classes of bugs
    - Bug bounty programs leverage crowd-sourced security

=== ":fontawesome-solid-fire: Pro Tips & Gotchas"

    !!! success "Best Practices"
        - **Defense in depth** - Multiple security layers (WAF + input validation + output encoding)
        - **Fail securely** - Default deny, errors should not expose data
        - **Security by design** - Threat modeling during design phase
        - **Least privilege** - Minimal permissions, no hardcoded admin accounts
        - **Security champions** - Train developers in secure coding
        - **Automated testing** - SAST/DAST/SCA in every build
        - **Security.txt** - Publish disclosure policy (RFC 9116)

    !!! warning "AppSec Reality"
        - **False positives** - SAST tools 50%+ FP rate (requires triage)
        - **Tool fatigue** - Running 5+ security tools slows CI/CD
        - **Business logic** - Tools can't find logic flaws (manual review needed)
        - **Legacy code** - Fixing old code expensive (prioritize new code)
        - **Developer friction** - Security as blocker breeds workarounds
        - **Shifting blame** - Security team vs. dev team culture clash
        - **Compliance theater** - Checking boxes doesn't mean secure

    !!! tip "Essential Tools"
        - **SAST** - Semgrep (free), SonarQube ($), Snyk Code ($), CodeQL (free for open source)
        - **DAST** - OWASP ZAP (free), Burp Suite Pro ($449/year), Nuclei (free)
        - **SCA** - Snyk ($), Dependabot (free), Trivy (free), OWASP Dependency-Check (free)
        - **Secrets** - Gitleaks (free), TruffleHog (free), GitGuardian ($)
        - **API** - Postman/Newman (free/$), OWASP API Security Top 10, ffuf (free)
        - **Bug Bounty** - HackerOne, Bugcrowd, Synack

    !!! danger "Gotchas"
        - **Secrets in code** - GitHub scans public repos (instant exploitation)
        - **Dependency hell** - Transitive dependencies bring vulnerabilities
        - **API versioning** - Old API versions forgotten (not patched)
        - **Error messages** - Stack traces leak paths, versions, internals
        - **Default configs** - Frameworks ship insecure by default (harden!)
        - **Third-party scripts** - CDN scripts can be compromised (Subresource Integrity)
        - **Deserialization** - Java, Python, Ruby deserialization RCE common

______________________________________________________________________

## :fontawesome-solid-graduation-cap: Learning & Certifications

### :fontawesome-solid-book-open: Certifications

- **[CSSLP](https://www.isc2.org/Certifications/CSSLP)** - $749, Certified Secure Software Lifecycle Professional
- **[GWAPT](https://www.giac.org/certifications/web-application-penetration-tester-gwapt/)** - $2499, SANS web app pentesting
- **[OSWE](https://www.offensive-security.com/awae-oswe/)** - $1649, web app exploitation expert-level
- **[BSCP](https://portswigger.net/web-security/certification)** - $99, Burp Suite Certified Practitioner

### :fontawesome-solid-rocket: Practice Platforms

- **[PortSwigger Academy](https://portswigger.net/web-security)** - Free, web security learning
- **[PentesterLab](https://pentesterlab.com/)** - $20/month, web exploitation exercises
- **[HackTheBox](https://www.hackthebox.com/)** - $14/month, includes web challenges

______________________________________________________________________

## :fontawesome-solid-wrench: Essential Toolkit

| Category | Tools | Purpose |
|----------|-------|---------|
| **SAST** | Semgrep, SonarQube, Snyk Code, Bandit | Static code analysis |
| **DAST** | OWASP ZAP, Burp Suite, Nuclei | Dynamic runtime testing |
| **SCA** | Snyk, Dependabot, Trivy, Grype | Dependency vulnerability scanning |
| **Secrets** | Gitleaks, TruffleHog, GitGuardian | Secret detection in code |
| **API** | Postman, ffuf, OWASP ZAP API scan | API security testing |
| **Fuzzing** | ffuf, wfuzz, Burp Intruder | Input fuzzing |

______________________________________________________________________

**Last Updated:** 2026-02-02 | **Vibe Check:** :fontawesome-solid-shield: **Shift Left** - Security in CI/CD now standard. SAST false positives annoying. API security critical (83% of traffic). SCA finds vulnerable dependencies (87% apps affected). Bug bounties democratized vuln research. DevSecOps culture shift painful but necessary.

**Tags:** appsec, secure-coding, sast, dast, sca, devsecops, api-security
