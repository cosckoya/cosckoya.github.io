---
title: GitHub
description: Git hosting platform - code collaboration, CI/CD workflows, package registry, world's largest code repository
---

# :fontawesome-brands-github: GitHub

Git hosting and collaboration platform owned by Microsoft. 100M+ developers, de facto standard for open source. GitHub Actions for CI/CD, Dependabot for security, Projects for issue tracking. More than just git hosting.

!!! tip "2026 Update"
    GitHub Copilot integrates directly into workflows. Actions runners now support GPU workloads. Advanced Security includes AI-powered code scanning. GitHub Projects v2 is feature-complete. Codespaces supports team configurations.

______________________________________________________________________

## :fontawesome-solid-bolt-lightning: Quick Hits

=== ":fontawesome-solid-list-check: Essential Commands"

    ```bash
    # GitHub CLI (gh) - essential for automation
    gh auth login                          # Authenticate
    gh repo create myrepo --public         # Create repository
    gh repo clone owner/repo               # Clone repository

    # Pull requests
    gh pr create --title "Fix bug" --body "Description"  # (1)!
    gh pr list                             # List PRs
    gh pr view 123                         # View PR details
    gh pr checkout 123                     # Checkout PR locally
    gh pr merge 123 --squash               # Merge with squash

    # Issues
    gh issue create --title "Bug report"
    gh issue list --label bug
    gh issue close 456

    # GitHub Actions workflows
    gh workflow list                       # List workflows
    gh workflow view deploy.yml            # View workflow
    gh run list                            # List workflow runs
    gh run view 789                        # View run details
    gh run watch                           # Watch current run

    # Releases
    gh release create v1.0.0 --title "Release 1.0.0" \
      --notes "Release notes" ./binary     # (2)!
    gh release list
    gh release download v1.0.0

    # Repository management
    gh repo view owner/repo                # View repo info
    gh repo fork owner/repo                # Fork repository
    gh repo sync                           # Sync fork with upstream

    # Secrets management
    gh secret set API_KEY < api-key.txt    # (3)!
    gh secret list
    gh secret delete API_KEY

    # Gists
    gh gist create script.sh --public
    gh gist list
    ```

    1. PR created from current branch, pushes commits automatically
    2. Release with binary attachment, auto-generates changelog
    3. Secrets encrypted, available in GitHub Actions workflows

    **Real talk:**

    - GitHub CLI (`gh`) is faster than web UI for repetitive tasks
    - Actions free tier: 2000 minutes/month (3000 for Pro), then $0.008/minute
    - Dependabot auto-PRs are noisy, configure update schedules
    - GitHub Projects v2 finally competitive with Jira/Linear
    - Codespaces is VS Code in browser (60 hours/month free)

=== ":fontawesome-solid-bolt: Common Patterns"

    ```yaml
    # GitHub Actions workflow (.github/workflows/ci.yml)
    name: CI Pipeline

    on:
      push:
        branches: [main, develop]
      pull_request:
        branches: [main]

    jobs:
      test:
        runs-on: ubuntu-latest  # (1)!

        steps:
          - uses: actions/checkout@v4

          - name: Setup Node.js
            uses: actions/setup-node@v4
            with:
              node-version: '20'
              cache: 'npm'  # (2)!

          - name: Install dependencies
            run: npm ci  # (3)!

          - name: Run tests
            run: npm test

          - name: Upload coverage
            uses: codecov/codecov-action@v4
            with:
              token: ${{ secrets.CODECOV_TOKEN }}  # (4)!

      build:
        needs: test  # (5)!
        runs-on: ubuntu-latest

        steps:
          - uses: actions/checkout@v4

          - name: Build Docker image
            run: docker build -t myapp:${{ github.sha }} .

          - name: Push to registry
            run: |
              echo ${{ secrets.DOCKER_PASSWORD }} | docker login -u ${{ secrets.DOCKER_USERNAME }} --password-stdin
              docker push myapp:${{ github.sha }}
    ```

    1. `ubuntu-latest`, `windows-latest`, `macos-latest` available
    2. Cache npm packages for faster builds (saves 30-60 seconds)
    3. `npm ci` is faster and more reliable than `npm install` in CI
    4. Secrets stored in repository settings, never in code
    5. Build only runs if tests pass

    ```yaml
    # Dependabot config (.github/dependabot.yml)
    version: 2
    updates:
      - package-ecosystem: "npm"
        directory: "/"
        schedule:
          interval: "weekly"  # (1)!
          day: "monday"
          time: "09:00"
        open-pull-requests-limit: 5  # (2)!
        reviewers:
          - "team-lead"
        labels:
          - "dependencies"
        commit-message:
          prefix: "chore"  # (3)!

      - package-ecosystem: "github-actions"
        directory: "/"
        schedule:
          interval: "monthly"
    ```

    1. Weekly updates less noisy than daily (default)
    2. Limit concurrent PRs to avoid spam
    3. Conventional commits for changelog generation

    ```yaml
    # Reusable workflow (.github/workflows/deploy.yml)
    name: Deploy

    on:
      workflow_call:  # (1)!
        inputs:
          environment:
            required: true
            type: string
        secrets:
          api_key:
            required: true

    jobs:
      deploy:
        runs-on: ubuntu-latest
        environment: ${{ inputs.environment }}  # (2)!

        steps:
          - uses: actions/checkout@v4

          - name: Deploy to ${{ inputs.environment }}
            run: ./deploy.sh
            env:
              API_KEY: ${{ secrets.api_key }}
    ```

    1. `workflow_call` makes workflow reusable from other workflows
    2. Environment protection rules (approvals, secrets) enforced

    **Why this works:**

    - Actions run on every push/PR automatically (no manual triggers)
    - Dependency caching speeds up builds significantly
    - Reusable workflows reduce duplication across repos
    - Environment protection rules prevent accidental production deploys
    - Matrix builds test multiple versions in parallel

=== ":fontawesome-solid-fire: Pro Tips & Gotchas"

    !!! success "Best Practices"
        - **Branch protection** - Require PR reviews, status checks before merge
        - **CODEOWNERS file** - Auto-assign reviewers based on file paths
        - **Action caching** - Cache dependencies (npm, pip, maven) for faster builds
        - **Self-hosted runners** - Free compute for private repos, but manage security
        - **Composite actions** - DRY principle for repeated workflow steps
        - **Environments** - Use for staging/production with approval gates
        - **GitHub Apps** - Better than personal access tokens for automation

    !!! warning "Security"
        - **Enable 2FA** - Mandatory for organizations, should be for all accounts
        - **Secret scanning** - Auto-detects committed secrets (AWS keys, tokens)
        - **Dependabot alerts** - Enable for all repos, review weekly
        - **Branch protection** - Block force-push, require signed commits
        - **Actions permissions** - Restrict GITHUB_TOKEN to minimum needed
        - **Third-party Actions** - Pin to commit SHA, not tag (tags can be moved)
        - **Code scanning** - CodeQL finds security vulnerabilities in code

    !!! tip "Performance"
        - **Artifact caching** - `actions/cache` for dependencies
        - **Matrix builds** - Test multiple versions in parallel
        - **Concurrency groups** - Cancel outdated workflow runs
        - **Self-hosted runners** - Faster for large repos (no queue time)
        - **Sparse checkout** - Clone only needed directories (monorepos)

    !!! danger "Gotchas"
        - **Actions minutes** - Free tier runs out fast (2000 min/month)
        - **Secrets in forks** - Not available in PRs from forks (security)
        - **GITHUB_TOKEN** - Limited permissions, use PAT for cross-repo access
        - **Workflow triggers** - Recursive triggers disabled (workflow can't trigger itself)
        - **Rate limits** - 5000 API requests/hour (authenticated), 60/hour (unauthenticated)
        - **Large files** - Use Git LFS, not regular commits (100MB limit)
        - **Force push** - Can break branch protection if admin override enabled

______________________________________________________________________

## :fontawesome-solid-graduation-cap: Learning Resources

### :fontawesome-solid-book-open: Official Docs

- **[GitHub Docs](https://docs.github.com/)** - Comprehensive documentation
- **[GitHub CLI Manual](https://cli.github.com/manual/)** - gh command reference
- **[GitHub Actions Docs](https://docs.github.com/en/actions)** - Workflow syntax, examples
- **[GitHub Skills](https://skills.github.com/)** - Interactive tutorials

### :fontawesome-solid-rocket: Key Features

- **GitHub Actions** - CI/CD built into platform (free tier: 2000 min/month)
- **GitHub Copilot** - AI pair programmer ($10/month, $19/month for business)
- **Dependabot** - Automated dependency updates and security alerts
- **GitHub Projects** - Issue tracking, kanban boards (v2 is good)
- **GitHub Packages** - Container, npm, Maven registry
- **Codespaces** - Cloud dev environments (60 hours/month free)
- **GitHub Advanced Security** - Code scanning, secret scanning, dependency review

______________________________________________________________________

## :fontawesome-solid-star: Related Tools

- **[GitHub CLI](https://cli.github.com/)** - Official command-line tool
- **[act](https://github.com/nektos/act)** - Run GitHub Actions locally
- **[gh-dash](https://github.com/dlvhdr/gh-dash)** - Terminal dashboard for GitHub
- **[hub](https://hub.github.com/)** - Legacy CLI (superseded by gh)

______________________________________________________________________

**Last Updated:** 2026-02-02 | **Vibe Check:** :fontawesome-solid-crown: **Industry Standard** - GitHub is the default choice. Actions CI/CD is solid. Copilot changes development workflow. Free tier generous for open source. Microsoft ownership hasn't ruined it (yet).

**Tags:** github, devops, ci-cd, git, version-control
