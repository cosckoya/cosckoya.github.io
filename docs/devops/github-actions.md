# GitHub Actions

Automate workflows directly in GitHub repositories with event-driven CI/CD and task automation.

______________________________________________________________________

## Overview

### What is GitHub Actions?

GitHub Actions is GitHub's native CI/CD and workflow automation platform. It allows you to build, test, and deploy code directly from your repository using YAML-based workflows triggered by GitHub events.

**Key Features:**

- 🚀 **Native CI/CD** - Built into GitHub platform
- 🎯 **Event-Driven** - Trigger on pushes, PRs, issues, schedules, etc.
- 🔧 **Reusable Actions** - Pre-built actions from marketplace
- 🐧 **Multi-Platform** - Linux, Windows, macOS runners
- 🆓 **Free Tier** - 2,000 minutes/month for private repos, unlimited for public
- 🔒 **Secrets Management** - Built-in encrypted secrets

### Why Use GitHub Actions?

- ✅ **Integrated** - No external CI/CD tool needed
- ✅ **Flexible** - Automate any GitHub workflow
- ✅ **Marketplace** - Thousands of pre-built actions
- ✅ **Matrix Builds** - Test across multiple versions/platforms
- ✅ **Self-Hosted Runners** - Use your own infrastructure

______________________________________________________________________

## Getting Started

### Essential Guides

**Quickstart:**

- **[Quickstart Guide](https://docs.github.com/en/actions/quickstart)** - Create first workflow in 5 minutes
- **[Understanding GitHub Actions](https://docs.github.com/en/actions/learn-github-actions/understanding-github-actions)** - Core concepts
- **[Essential Features](https://docs.github.com/en/actions/learn-github-actions/essential-features-of-github-actions)** - Key features overview

**Tutorials:**

- **[Building and Testing](https://docs.github.com/en/actions/automating-builds-and-tests)** - CI workflows
- **[Deploying](https://docs.github.com/en/actions/deployment)** - CD workflows
- **[Publishing Packages](https://docs.github.com/en/actions/publishing-packages)** - Package registries

______________________________________________________________________

## Core Concepts

### Workflows

YAML files defining automated processes:

- **[Workflow Syntax](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions)** - Complete YAML reference
- **[Triggering Workflows](https://docs.github.com/en/actions/using-workflows/triggering-a-workflow)** - Event triggers
- **[Using Jobs](https://docs.github.com/en/actions/using-jobs)** - Job configuration
- **[Using Workflows](https://docs.github.com/en/actions/using-workflows)** - Complete guide

**Basic Workflow Example:**

```yaml
name: CI

on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4
      - name: Run tests
        run: npm test
```

### Actions

Reusable units of automation:

- **[Marketplace](https://github.com/marketplace?type=actions)** - Browse 20,000+ actions
- **[Creating Actions](https://docs.github.com/en/actions/creating-actions)** - Build custom actions
- **[Action Types](https://docs.github.com/en/actions/creating-actions/about-custom-actions)** - JavaScript, Docker, Composite

**Popular Actions:**

- `actions/checkout` - Check out repository
- `actions/setup-node` - Setup Node.js
- `actions/setup-python` - Setup Python
- `actions/cache` - Cache dependencies
- `actions/upload-artifact` - Save artifacts

### Runners

Execution environments:

- **[GitHub-Hosted Runners](https://docs.github.com/en/actions/using-github-hosted-runners)** - Managed by GitHub
- **[Self-Hosted Runners](https://docs.github.com/en/actions/hosting-your-own-runners)** - Your own infrastructure
- **[Runner Images](https://github.com/actions/runner-images)** - Available software

**Available Environments:**

- `ubuntu-latest`, `ubuntu-22.04`, `ubuntu-20.04`
- `windows-latest`, `windows-2022`, `windows-2019`
- `macos-latest`, `macos-13`, `macos-12`

______________________________________________________________________

## Common Workflows

### CI Workflow

```yaml
name: CI

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest

    strategy:
      matrix:
        node-version: [18.x, 20.x, 22.x]

    steps:
      - uses: actions/checkout@v4

      - name: Use Node.js ${{ matrix.node-version }}
        uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node-version }}

      - name: Install dependencies
        run: npm ci

      - name: Run tests
        run: npm test

      - name: Run linter
        run: npm run lint
```

### CD Workflow

```yaml
name: Deploy

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4

      - name: Deploy to production
        run: |
          # Deploy commands here
        env:
          API_KEY: ${{ secrets.API_KEY }}
```

**Learn More:**

- **[Starter Workflows](https://github.com/actions/starter-workflows)** - Template workflows
- **[Example Workflows](https://docs.github.com/en/actions/examples)** - Real-world examples

______________________________________________________________________

## Advanced Features

### Matrix Builds

Test across multiple configurations:

```yaml
strategy:
  matrix:
    os: [ubuntu-latest, windows-latest, macos-latest]
    python-version: ['3.10', '3.11', '3.12']
```

**Documentation:**

- **[Using a Matrix](https://docs.github.com/en/actions/using-jobs/using-a-matrix-for-your-jobs)** - Matrix strategies

### Reusable Workflows

Share workflows across repositories:

- **[Reusing Workflows](https://docs.github.com/en/actions/using-workflows/reusing-workflows)** - Call workflows
- **[Workflow Templates](https://docs.github.com/en/actions/using-workflows/creating-starter-workflows-for-your-organization)** - Organization templates

### Caching

Speed up workflows:

```yaml
- uses: actions/cache@v4
  with:
    path: ~/.npm
    key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}
```

**Documentation:**

- **[Caching Dependencies](https://docs.github.com/en/actions/using-workflows/caching-dependencies-to-speed-up-workflows)** - Cache guide

### Secrets & Variables

Secure sensitive data:

- **[Encrypted Secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets)** - Store secrets
- **[Variables](https://docs.github.com/en/actions/learn-github-actions/variables)** - Non-sensitive config
- **[Environments](https://docs.github.com/en/actions/deployment/targeting-different-environments)** - Environment-specific config

______________________________________________________________________

## Security

**Best Practices:**

- Pin actions to specific versions/SHAs
- Use `pull_request_target` carefully
- Limit GITHUB_TOKEN permissions
- Review third-party actions before use
- Use Dependabot for action updates

**Security Guides:**

- **[Security Hardening](https://docs.github.com/en/actions/security-guides/security-hardening-for-github-actions)** - Security best practices
- **[Using GITHUB_TOKEN](https://docs.github.com/en/actions/security-guides/automatic-token-authentication)** - Token permissions

______________________________________________________________________

## Monitoring & Debugging

**Workflow Monitoring:**

- **[Monitoring Workflows](https://docs.github.com/en/actions/monitoring-and-troubleshooting-workflows)** - View logs and status
- **[Workflow Notifications](https://docs.github.com/en/actions/monitoring-and-troubleshooting-workflows/notifications-for-workflow-runs)** - Get notified

**Debugging:**

- **[Enable Debug Logging](https://docs.github.com/en/actions/monitoring-and-troubleshooting-workflows/enabling-debug-logging)** - Verbose logs
- **[Using Workflow Commands](https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions)** - Debug outputs
- **[SSH Debugging](https://github.com/marketplace/actions/debugging-with-tmate)** - Interactive debugging

______________________________________________________________________

## Best Practices

**Workflow Design:**

- Use meaningful workflow and job names
- Fail fast with proper exit codes
- Use matrix builds for cross-platform testing
- Cache dependencies to reduce build time
- Use concurrency to cancel outdated runs

**Security:**

- Pin action versions to commit SHAs
- Use least privilege for GITHUB_TOKEN
- Store secrets in GitHub Secrets
- Review and approve third-party actions
- Enable Dependabot for action updates

**Performance:**

- Use self-hosted runners for heavy workloads
- Cache dependencies and build outputs
- Run jobs in parallel when possible
- Use `paths` filters to skip unnecessary runs
- Split large workflows into smaller ones

**Learn More:**

- **[Best Practices Guide](https://docs.github.com/en/actions/learn-github-actions/best-practices-for-github-actions)** - Official recommendations

______________________________________________________________________

## Resources & Links

### 🏠 Official

- **[GitHub Actions](https://github.com/features/actions)** - Product page
- **[Documentation](https://docs.github.com/en/actions)** - Complete docs
- **[Changelog](https://github.blog/changelog/label/actions/)** - What's new
- **[Roadmap](https://github.com/github/roadmap/projects/1?query=is%3Aopen+sort%3Aupdated-desc+label%3A%22area%3A+actions%22)** - Public roadmap

### 📚 Documentation

- **[Quickstart](https://docs.github.com/en/actions/quickstart)** - Get started fast
- **[Workflow Syntax](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions)** - Complete YAML reference
- **[Contexts](https://docs.github.com/en/actions/learn-github-actions/contexts)** - Available contexts
- **[Expressions](https://docs.github.com/en/actions/learn-github-actions/expressions)** - Syntax expressions
- **[Environment Variables](https://docs.github.com/en/actions/learn-github-actions/variables)** - Built-in variables

### 💻 Actions & Workflows

- **[Marketplace](https://github.com/marketplace?type=actions)** - 20,000+ actions
- **[Starter Workflows](https://github.com/actions/starter-workflows)** - Templates
- **[Official Actions](https://github.com/actions)** - GitHub-maintained actions
- **[Awesome Actions](https://github.com/sdras/awesome-actions)** - Curated list

### 🎓 Learning

- **[Skills: Introduction to GitHub Actions](https://github.com/skills/hello-github-actions)** - Interactive learning
- **[GitHub Actions Tutorial](https://github.com/marketplace/actions/github-actions-tutorial)** - Hands-on guide
- **[Video: GitHub Actions Tutorial](https://www.youtube.com/playlist?list=PLArH6NjfKsUhvGHrpag7SuPumMzQRhUKY)** - YouTube playlist

### 👥 Community

- **[GitHub Community](https://github.com/orgs/community/discussions/categories/actions)** - Discussions
- **[GitHub Actions Forum](https://github.community/c/github-actions/41)** - Q&A forum
- **[Stack Overflow](https://stackoverflow.com/questions/tagged/github-actions)** - Tagged questions
- **[r/github](https://reddit.com/r/github)** - Reddit community

### 🔧 Tools

- **[act](https://github.com/nektos/act)** - Run Actions locally
- **[GitHub CLI](https://cli.github.com/)** - Manage workflows from terminal
- **[VS Code Extension](https://marketplace.visualstudio.com/items?itemName=cschleiden.vscode-github-actions)** - IDE integration
- **[Action Validator](https://rhysd.github.io/actionlint/)** - Lint workflows

______________________________________________________________________

## Related Topics

- **[GitHub](github.md)** - Platform fundamentals
- **[Pre-Commit](pre-commit.md)** - Use together for code quality
- **[Azure DevOps](azure-devops.md)** - Alternative CI/CD platform
- **[Kubernetes](../containerization/kubernetes.md)** - Deploy to K8s clusters

______________________________________________________________________

**Last Updated:** 2026-01-13 **Status:** Active **Maintained by:** DocMaster Agent v2.0
