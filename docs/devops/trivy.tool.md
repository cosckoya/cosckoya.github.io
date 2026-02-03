---
title: Trivy
description: Open-source security scanner - containers, IaC, filesystems, git repos, comprehensive vulnerability detection
---

# :fontawesome-solid-shield: Trivy

Open-source comprehensive security scanner by Aqua Security. Scans containers, filesystems, git repos, IaC, Kubernetes. Detects vulnerabilities, misconfigurations, secrets, licenses. Fast, accurate, free. No rate limits.

!!! tip "2026 Update"
    Trivy 0.50+ adds SBOM generation (CycloneDX, SPDX). Kubernetes operator for automated cluster scanning. VEX support for vulnerability filtering. Malware scanning in container images. Plugin system for custom checks.

______________________________________________________________________

## :fontawesome-solid-bolt-lightning: Quick Hits

=== ":fontawesome-solid-list-check: Essential Commands"

    ```bash
    # Installation
    brew install trivy                     # macOS
    apt-get install trivy                  # Debian/Ubuntu
    # Or download from https://github.com/aquasecurity/trivy/releases

    # Container image scanning
    trivy image nginx:latest               # Scan public image  # (1)!
    trivy image myapp:1.0.0                # Scan local image
    trivy image --severity HIGH,CRITICAL nginx:latest  # (2)!
    trivy image --ignore-unfixed nginx     # Ignore issues without fixes

    # Filesystem scanning
    trivy fs .                             # Scan current directory
    trivy fs /path/to/project              # Scan specific path
    trivy fs --security-checks vuln,secret .  # Vulns + secrets  # (3)!

    # Git repository scanning
    trivy repo https://github.com/user/repo
    trivy repo --branch develop .          # Scan specific branch

    # Infrastructure as Code scanning
    trivy config terraform/                # Scan Terraform
    trivy config k8s/*.yaml                # Scan Kubernetes manifests
    trivy config --severity HIGH,CRITICAL .

    # Kubernetes cluster scanning
    trivy k8s --report summary             # Scan entire cluster  # (4)!
    trivy k8s deployment/myapp             # Scan specific resource
    trivy k8s all --namespace production

    # SBOM generation
    trivy image --format cyclonedx nginx:latest > sbom.json  # (5)!
    trivy image --format spdx nginx:latest > sbom.spdx

    # Output formats
    trivy image --format json nginx > results.json
    trivy image --format sarif nginx > results.sarif  # (6)!
    trivy image --format template --template "@contrib/gitlab.tpl" nginx
    ```

    1. Downloads image if not present locally
    2. Focus on high/critical severities only (reduce noise)
    3. Multiple check types: vuln, config, secret, license
    4. Requires cluster access (kubectl configured)
    5. CycloneDX format for supply chain security
    6. SARIF format for GitHub Security tab integration

    **Real talk:**

    - Open source, no rate limits (unlike Snyk free tier)
    - Comprehensive: containers, IaC, secrets, misconfigurations, licenses
    - Fast: scans Docker images in seconds
    - Offline mode: download DB locally for air-gapped environments
    - Accurate: low false-positive rate

=== ":fontawesome-solid-bolt: Common Patterns"

    ```yaml
    # GitHub Actions integration (.github/workflows/trivy.yml)
    name: Trivy Security Scan

    on:
      push:
        branches: [main]
      pull_request:
        branches: [main]
      schedule:
        - cron: '0 0 * * 0'  # Weekly

    jobs:
      container-scan:
        runs-on: ubuntu-latest

        steps:
          - uses: actions/checkout@v4

          - name: Build Docker image
            run: docker build -t myapp:${{ github.sha }} .

          - name: Run Trivy vulnerability scanner
            uses: aquasecurity/trivy-action@master
            with:
              image-ref: 'myapp:${{ github.sha }}'
              format: 'sarif'
              output: 'trivy-results.sarif'
              severity: 'CRITICAL,HIGH'  # (1)!
              ignore-unfixed: true  # (2)!

          - name: Upload to GitHub Security
            uses: github/codeql-action/upload-sarif@v3
            with:
              sarif_file: 'trivy-results.sarif'

      iac-scan:
        runs-on: ubuntu-latest

        steps:
          - uses: actions/checkout@v4

          - name: Run Trivy IaC scanner
            uses: aquasecurity/trivy-action@master
            with:
              scan-type: 'config'  # (3)!
              scan-ref: '.'
              format: 'sarif'
              output: 'trivy-iac.sarif'
              severity: 'HIGH,CRITICAL'

          - name: Upload IaC results
            uses: github/codeql-action/upload-sarif@v3
            with:
              sarif_file: 'trivy-iac.sarif'

      secret-scan:
        runs-on: ubuntu-latest

        steps:
          - uses: actions/checkout@v4
            with:
              fetch-depth: 0  # Full history for secret scanning

          - name: Run Trivy secret scanner
            uses: aquasecurity/trivy-action@master
            with:
              scan-type: 'fs'
              scan-ref: '.'
              security-checks: 'secret'  # (4)!
              format: 'table'
    ```

    1. Fail build only on high/critical severities
    2. Ignore vulnerabilities without available fixes
    3. `config` scan type for IaC, `image` for containers, `fs` for filesystems
    4. Secret scanning looks for API keys, passwords, tokens in code

    ```yaml
    # trivy.yaml (configuration file)
    # Place in .trivy.yaml at project root
    severity:
      - CRITICAL
      - HIGH
    ignore-unfixed: true
    ignorefile: .trivyignore  # (1)!
    output: trivy-report.json
    format: json
    dependency-tree: true  # Show dependency chains  # (2)!
    ```

    1. `.trivyignore` file lists CVEs to ignore (like .gitignore)
    2. Dependency tree helps understand how vulnerability was introduced

    ```bash
    # .trivyignore (ignore specific vulnerabilities)
    # CVE-2023-12345 - False positive, not exploitable in our usage
    CVE-2023-12345

    # Ignore all npm vulnerabilities (example, not recommended)
    # CVE-*-* npm
    ```

    ```yaml
    # GitLab CI integration (.gitlab-ci.yml)
    trivy_scan:
      stage: test
      image: aquasec/trivy:latest
      script:
        - trivy image --exit-code 1 --severity CRITICAL,HIGH myapp:$CI_COMMIT_SHA  # (1)!
        - trivy config --exit-code 1 --severity CRITICAL,HIGH .
        - trivy fs --security-checks vuln,secret --exit-code 1 .
      artifacts:
        reports:
          container_scanning: gl-container-scanning.json  # (2)!
      only:
        - merge_requests
        - main
    ```

    1. `--exit-code 1` fails pipeline if vulnerabilities found
    2. GitLab native container scanning report format

    **Why this works:**

    - Multi-scanner: containers, IaC, secrets, filesystems in one tool
    - SARIF output integrates with GitHub Security tab
    - No API keys or rate limits (fully offline capable)
    - Ignore files version-controlled with code
    - Fast scans don't slow down CI significantly

=== ":fontawesome-solid-fire: Pro Tips & Gotchas"

    !!! success "Best Practices"
        - **Scan early** - Integrate in CI/CD from day one
        - **Severity filtering** - Start with CRITICAL only, then HIGH
        - **Ignore unfixed** - Focus on vulnerabilities you can actually fix
        - **Layer caching** - Scan base images separately (faster CI)
        - **SBOM generation** - Generate for supply chain compliance
        - **Scheduled scans** - Weekly scans catch new CVEs in old images
        - **Offline mode** - Download DB for air-gapped environments

    !!! warning "Security"
        - **Secrets in images** - Trivy finds hardcoded secrets in container layers
        - **Misconfigurations** - IaC scanning prevents security issues before deploy
        - **License compliance** - Detects GPL/LGPL dependencies
        - **Supply chain** - SBOM shows complete dependency tree
        - **Ignore responsibly** - Document why CVEs are ignored (.trivyignore comments)

    !!! tip "Performance"
        - **Cache DB** - Store vulnerability database between scans (--cache-dir)
        - **Skip DB update** - Use --skip-db-update if DB already current
        - **Parallel scans** - Scan multiple images/paths in parallel jobs
        - **Light mode** - Use --scanners vuln for faster scans (skip config/secret)

    !!! danger "Gotchas"
        - **DB updates** - First run downloads 100MB+ database (cache it)
        - **Alpine images** - Some vulnerabilities harder to fix (use distroless)
        - **Base image vulns** - Your code is fine, but nginx:latest has 50 vulns
        - **False positives** - Rare but possible (use .trivyignore with reason)
        - **Exit codes** - Default 0 even with vulns (use --exit-code 1 to fail CI)
        - **Secret scanning** - Scans git history (use fetch-depth: 0)
        - **Language support** - Best for Go, Java, Node, Python; others less complete

______________________________________________________________________

## :fontawesome-solid-graduation-cap: Learning Resources

### :fontawesome-solid-book-open: Official Docs

- **[Trivy Documentation](https://aquasecurity.github.io/trivy/)** - Complete guide
- **[Trivy GitHub](https://github.com/aquasecurity/trivy)** - Source code, issues
- **[Trivy Vulnerability DB](https://github.com/aquasecurity/trivy-db)** - CVE database

### :fontawesome-solid-rocket: Key Features

- **Container scanning** - Docker, OCI, tar archives
- **IaC scanning** - Terraform, CloudFormation, Kubernetes, Helm, Dockerfile
- **Secret scanning** - API keys, passwords, tokens in code/containers
- **License scanning** - Identify GPL/LGPL dependencies
- **SBOM generation** - CycloneDX, SPDX formats
- **Kubernetes operator** - Automated cluster scanning

______________________________________________________________________

## :fontawesome-solid-star: Alternatives

- **[Snyk](snyk.tool.md)** - Commercial, better UI/UX, auto-fix PRs
- **[Grype](https://github.com/anchore/grype)** - Open source, similar features
- **[Clair](https://github.com/quay/clair)** - Container-only, older project
- **[Anchore](https://anchore.com/)** - Commercial, policy enforcement

______________________________________________________________________

**Last Updated:** 2026-02-02 | **Vibe Check:** :fontawesome-solid-fire: **Open Source Champion** - Best free security scanner. No rate limits. Comprehensive coverage. Fast. Active development. Should be in every CI/CD pipeline. Commercial alternatives not significantly better.

**Tags:** trivy, security, containers, iac, vulnerability-scanning
