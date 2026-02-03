---
title: Gitleaks
description: Secret scanner for git - finds API keys, passwords, tokens in git history, fast SAST tool for credentials
---

# :fontawesome-solid-key: Gitleaks

Fast secret scanner for git repositories. Detects API keys, passwords, tokens, credentials in code and git history. Open source. Scans commits, branches, files. Pre-commit hooks prevent secrets from being committed.

!!! tip "2026 Update"
    Gitleaks 8.x adds custom rule support with regex. SARIF output for GitHub Security integration. Baseline files to ignore existing secrets. GitLab native integration. 140+ built-in secret patterns.

______________________________________________________________________

## :fontawesome-solid-bolt-lightning: Quick Hits

=== ":fontawesome-solid-list-check: Essential Commands"

    ```bash
    # Installation
    brew install gitleaks                  # macOS
    # Or download from https://github.com/gitleaks/gitleaks/releases

    # Scan repository
    gitleaks detect --source .             # Scan current repo  # (1)!
    gitleaks detect --source /path/to/repo
    gitleaks detect --verbose              # Show more details

    # Scan specific branch/commit range
    gitleaks detect --log-opts="--since=2025-01-01"  # (2)!
    gitleaks detect --log-opts="main..develop"       # Compare branches

    # Scan uncommitted files
    gitleaks protect --staged              # Scan staged files only  # (3)!
    gitleaks protect                       # Scan all uncommitted changes

    # Output formats
    gitleaks detect --report-format json --report-path results.json
    gitleaks detect --report-format sarif --report-path results.sarif  # (4)!
    gitleaks detect --report-format csv --report-path results.csv

    # Baseline (ignore existing secrets)
    gitleaks detect --baseline-path .gitleaks-baseline.json  # (5)!
    gitleaks detect --report-path .gitleaks-baseline.json    # Generate baseline

    # Pre-commit hook installation
    # Add to .git/hooks/pre-commit:
    #!/bin/sh
    gitleaks protect --staged --verbose --redact --exit-code 1  # (6)!
    ```

    1. Scans entire git history by default (can be slow on large repos)
    2. `--log-opts` passes options directly to git log
    3. `protect` mode for pre-commit checks (fast, uncommitted only)
    4. SARIF format integrates with GitHub Security tab
    5. Baseline allows progressive rollout (ignore existing, catch new)
    6. `--redact` hides actual secrets in output, `--exit-code 1` fails commit

    **Real talk:**

    - Open source, no rate limits or cloud dependencies
    - 140+ built-in rules (AWS keys, GitHub tokens, Slack tokens, etc.)
    - Fast: scans 100k commits in seconds
    - Pre-commit hooks prevent secrets from entering repo
    - Baseline files let you fix secrets gradually

=== ":fontawesome-solid-bolt: Common Patterns"

    ```yaml
    # GitHub Actions integration (.github/workflows/gitleaks.yml)
    name: Gitleaks Secret Scan

    on:
      push:
        branches: [main, develop]
      pull_request:
        branches: [main]

    jobs:
      scan:
        runs-on: ubuntu-latest

        steps:
          - uses: actions/checkout@v4
            with:
              fetch-depth: 0  # Full history for comprehensive scan  # (1)!

          - name: Run Gitleaks
            uses: gitleaks/gitleaks-action@v2
            env:
              GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
              GITLEAKS_LICENSE: ${{ secrets.GITLEAKS_LICENSE }}  # (2)!

          - name: Upload SARIF report
            if: failure()  # Upload even on failure  # (3)!
            uses: github/codeql-action/upload-sarif@v3
            with:
              sarif_file: results.sarif
    ```

    1. Full history needed to scan all commits (omit for speed on large repos)
    2. License optional (free version fully functional)
    3. Upload results even when secrets found for visibility

    ```toml
    # .gitleaks.toml (custom configuration)
    title = "Gitleaks Configuration"

    [extend]
    useDefault = true  # Use built-in rules  # (1)!

    [[rules]]
    id = "company-api-key"
    description = "Company API Key"
    regex = '''COMPANY_API_[A-Za-z0-9]{32}'''  # (2)!
    tags = ["key", "company"]

    [[rules]]
    id = "aws-access-key"
    description = "AWS Access Key"
    regex = '''AKIA[0-9A-Z]{16}'''
    tags = ["aws", "access-key"]

    [allowlist]
    description = "Global allowlist"
    regexes = [
      '''example\.com''',  # Test domain
      '''FAKE_SECRET_\w+'''  # Test credentials  # (3)!
    ]
    paths = [
      '''\.gitleaks\.toml''',  # Don't scan config file
      '''tests/fixtures/'''  # Test data directory
    ]
    commits = [
      '''a1b2c3d4e5f6'''  # Specific commit to ignore  # (4)!
    ]
    ```

    1. `useDefault = true` includes all 140+ built-in rules
    2. Custom regex for company-specific secret patterns
    3. Allow test credentials (prefix with FAKE_, TEST_, EXAMPLE_)
    4. Ignore specific commits where secrets were already remediated

    ```yaml
    # Pre-commit hook config (.pre-commit-config.yaml)
    repos:
      - repo: https://github.com/gitleaks/gitleaks
        rev: v8.18.0
        hooks:
          - id: gitleaks  # (1)!
    ```

    1. Pre-commit framework integration (run `pre-commit install`)

    ```bash
    # GitLab CI integration (.gitlab-ci.yml)
    gitleaks:
      stage: test
      image:
        name: zricethezav/gitleaks:latest
        entrypoint: [""]  # (1)!
      script:
        - gitleaks detect --source . --report-format json --report-path gl-secret-detection.json --exit-code 1  # (2)!
      artifacts:
        reports:
          secret_detection: gl-secret-detection.json  # (3)!
      only:
        - merge_requests
        - main
    ```

    1. Override entrypoint to use gitleaks command directly
    2. Exit code 1 fails pipeline if secrets found
    3. GitLab native secret detection report format

    **Why this works:**

    - Pre-commit hooks prevent secrets from ever entering repo
    - GitHub Actions scan on every PR (catch before merge)
    - SARIF format shows secrets in GitHub Security tab
    - Baseline files allow incremental remediation
    - Custom rules catch company-specific secret formats

=== ":fontawesome-solid-fire: Pro Tips & Gotchas"

    !!! success "Best Practices"
        - **Pre-commit hooks** - Install on developer machines (prevent accidents)
        - **Baseline files** - Commit baseline to ignore existing secrets, catch new
        - **Custom rules** - Add company-specific patterns (.gitleaks.toml)
        - **Redact output** - Use `--redact` to hide actual secrets in logs
        - **Allowlist carefully** - Test data, example configs, false positives only
        - **Scan branches** - Use `--log-opts` to scan feature branches
        - **Fast mode** - Use `protect` for uncommitted, `detect` for full history

    !!! warning "Security"
        - **Rotate found secrets** - Scanning is detection, not remediation
        - **Git history** - Removing from current code isn't enough (rewrite history)
        - **Baseline security** - Don't commit baseline with actual secret values
        - **CI logs** - Use `--redact` to prevent secrets in CI output
        - **Allowlist review** - Regularly audit allowlist (false positives become real)

    !!! tip "Performance"
        - **Shallow clone** - Use `--log-opts="--since=1.month.ago"` for faster scans
        - **Protect mode** - Pre-commit scans only staged files (sub-second)
        - **Parallel scans** - Large monorepos can scan subprojects in parallel
        - **Cache results** - Store baseline to avoid rescanning old commits

    !!! danger "Gotchas"
        - **Full history scan** - First run on large repo takes time (once)
        - **False positives** - Test data, example configs flagged (use allowlist)
        - **Entropy detection** - High-entropy strings flagged (base64, UUIDs)
        - **Secret rotation** - Gitleaks finds, you must rotate exposed secrets
        - **Git history rewrite** - Removing secrets requires `git filter-repo` or BFG
        - **Pre-commit bypass** - Developers can use `--no-verify` (educate team)
        - **Baseline drift** - Update baseline when fixing secrets (don't accumulate)

______________________________________________________________________

## :fontawesome-solid-graduation-cap: Learning Resources

### :fontawesome-solid-book-open: Official Docs

- **[Gitleaks Documentation](https://github.com/gitleaks/gitleaks)** - README and wiki
- **[Gitleaks Rules](https://github.com/gitleaks/gitleaks/blob/master/config/gitleaks.toml)** - Built-in secret patterns

### :fontawesome-solid-rocket: Key Features

- **140+ built-in rules** - AWS, GCP, Azure, GitHub, Slack, Stripe, etc.
- **Custom rules** - Regex-based patterns for company secrets
- **Pre-commit hooks** - Block secrets before commit
- **Baseline support** - Ignore existing secrets, catch new
- **Multiple outputs** - JSON, SARIF, CSV formats
- **Fast scanning** - Hundreds of thousands of commits per minute

______________________________________________________________________

## :fontawesome-solid-wrench: Secret Remediation

If Gitleaks finds secrets in git history:

1. **Rotate the secret immediately** - Assume compromised
2. **Remove from current code** - Update to use env vars/secrets manager
3. **Rewrite git history** - Use `git filter-repo` or BFG Repo-Cleaner:

```bash
# Install git-filter-repo
pip install git-filter-repo

# Remove file from all history
git filter-repo --path path/to/secret-file --invert-paths

# Replace secret in all history
git filter-repo --replace-text <(echo "OLD_SECRET==>REDACTED")

# Force push (coordinate with team)
git push --force --all
```

4. **Update baseline** - Generate new baseline after remediation

______________________________________________________________________

## :fontawesome-solid-star: Alternatives

- **[Trivy](../../devops/trivy.tool.md)** - Multi-purpose scanner (includes secret scanning)
- **[TruffleHog](https://github.com/trufflesecurity/trufflehog)** - Entropy-based detection
- **[detect-secrets](https://github.com/Yelp/detect-secrets)** - Yelp's secret scanner
- **[GitGuardian](https://www.gitguardian.com/)** - Commercial, real-time monitoring

______________________________________________________________________

**Last Updated:** 2026-02-02 | **Vibe Check:** :fontawesome-solid-lock: **Essential Tool** - Every repo needs this. Fast, accurate, free. Pre-commit hooks are lifesavers. Finding secrets is easy, rotating them is the hard part. Baseline files make adoption painless.

**Tags:** gitleaks, security, secrets, credentials, git
