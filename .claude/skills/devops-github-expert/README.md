# DevOps GitHub Expert

**Modern CI/CD/CS pipeline automation specialist for GitHub Actions and Pages**

______________________________________________________________________

## Overview

This skill provides expertise in GitHub Actions workflows, GitHub Pages deployment, and modern DevOps practices following 2026 best practices. She embodies the principles of:

- **KISS** (Keep It Simple, Stupid)
- **DRY** (Don't Repeat Yourself)
- **Clean Code** (Readable, maintainable infrastructure)
- **Infrastructure as Code** (Everything versioned and reproducible)
- **Everything as Code** (Policies, security, configs as code)
- **Immutable Infrastructure** (Deploy-replace, never modify)
- **Continuous Everything** (CI/CD/CS automation)
- **You Build It, You Run It** (Operational responsibility)

______________________________________________________________________

## Core Expertise

### GitHub Actions

- Modern workflow design (2026 patterns)
- Security best practices (OIDC, SLSA, Sigstore)
- Performance optimization (caching, matrix strategies)
- Reusable workflows and composite actions

### GitHub Pages

- Immutable deployment patterns
- Build artifact optimization
- Caching strategies
- OIDC authentication

### Continuous Security (CS)

- Vulnerability scanning (Trivy)
- Secret detection (Gitleaks)
- SBOM generation (CycloneDX)
- Dependency management (Dependabot, Renovate)

### Infrastructure as Code

- Repository settings as code
- Branch protection rules
- Automated policy enforcement
- Environment configuration

______________________________________________________________________

## Quick Start

### Invoke the skill:

```bash
/devops-github-expert audit
/devops-github-expert optimize pages deployment
/devops-github-expert add security scanning
/devops-github-expert setup dependabot
```

______________________________________________________________________

## Example Workflows

### Modern GitHub Pages Deployment

```yaml
name: Deploy Docs

on:
  push:
    branches: [main]

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: false

jobs:
  build:
    runs-on: ubuntu-24.04
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v5
        with:
          python-version: '3.12'
          cache: 'pip'
      - run: pip install -e .
      - run: mkdocs build --strict
      - uses: actions/upload-pages-artifact@v3
        with:
          path: site/

  deploy:
    needs: build
    runs-on: ubuntu-24.04
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    steps:
      - uses: actions/deploy-pages@v4
        id: deployment
```

### Security Scanning

```yaml
name: Security Scan

on:
  push:
    branches: [main, develop]
  pull_request:
  schedule:
    - cron: '0 6 * * 1'  # Weekly Monday 6am

jobs:
  security:
    runs-on: ubuntu-24.04
    permissions:
      security-events: write
      contents: read
    steps:
      - uses: actions/checkout@v4

      - name: Trivy vulnerability scan
        uses: aquasecurity/trivy-action@master
        with:
          scan-type: 'fs'
          format: 'sarif'
          output: 'trivy-results.sarif'

      - name: Upload to Security tab
        uses: github/codeql-action/upload-sarif@v3
        with:
          sarif_file: 'trivy-results.sarif'

      - name: Gitleaks secret scan
        uses: gitleaks/gitleaks-action@v2
```

______________________________________________________________________

## Key Principles

### KISS (Keep It Simple)

- Workflows readable in 5 minutes
- Minimal dependencies
- Clear, single-purpose jobs

### DRY (Don't Repeat Yourself)

- Reusable workflows
- Composite actions
- Shared configuration

### Clean Code

- Comments explain WHY, not WHAT
- Descriptive job/step names
- Logical structure

### Immutable Infrastructure

- Build once, deploy everywhere
- No environment drift
- Easy rollback

### Security First

- Least-privilege permissions
- Pin actions to SHA
- OIDC for cloud auth
- Automated scanning

### Fast Feedback

- Critical path under 5 minutes
- Parallel job execution
- Aggressive caching

______________________________________________________________________

## Common Tasks

### Audit Existing Workflows

```bash
/devops-github-expert audit
```

Reviews:

- Security vulnerabilities
- Performance bottlenecks
- DRY violations
- Missing best practices

### Optimize GitHub Pages

```bash
/devops-github-expert optimize pages deployment
```

Implements:

- Separate build/deploy jobs
- Dependency caching
- Artifact upload optimization
- OIDC authentication

### Add Security Scanning

```bash
/devops-github-expert add security scanning
```

Configures:

- Trivy (vulnerability scanning)
- Gitleaks (secret detection)
- SBOM generation
- Security tab integration

### Setup Dependency Management

```bash
/devops-github-expert setup dependabot
```

Creates:

- `.github/dependabot.yml`
- Grouped updates
- Automated PR creation
- Review assignments

______________________________________________________________________

## Integration with Other Skills

### Works with Python Architect

Ensures workflows use Python 3.12+, pyproject.toml, and modern tooling (Ruff, pre-commit).

### Works with MkDocs Material Expert

Coordinates GitHub Pages deployment for MkDocs sites with Material theme.

### Works with All Projects

Universal CI/CD/CS expertise applicable to any GitHub repository.

______________________________________________________________________

## Anti-Patterns to Avoid

❌ **Hardcoded secrets** ✅ Use GitHub Secrets and OIDC

❌ **Mutable infrastructure** ✅ Deploy-replace pattern

❌ **Repeated setup code** ✅ Composite actions and reusable workflows

❌ **No caching** ✅ Cache dependencies and build artifacts

❌ **Broad permissions** ✅ Least-privilege principle

______________________________________________________________________

## Monitoring and Maintenance

### Workflow Health Checks

```yaml
- name: Check workflow efficiency
  run: |
    echo "Build time: ${{ github.event.workflow_run.timing.run_duration_ms }}ms"
    echo "Cache hit rate: Check Actions cache"
```

### Failure Notifications

```yaml
- name: Notify on failure
  if: failure()
  uses: slackapi/slack-github-action@v1
  with:
    webhook-url: ${{ secrets.SLACK_WEBHOOK }}
```

______________________________________________________________________

## Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [GitHub Pages Documentation](https://docs.github.com/en/pages)
- [OSSF Scorecard](https://github.com/ossf/scorecard)
- [SLSA Framework](https://slsa.dev/)
- [Sigstore](https://www.sigstore.dev/)

______________________________________________________________________

**Version:** 1.0.0 **Created:** 2026-01-26 **Maintainer:** DevOps GitHub Expert Skill
