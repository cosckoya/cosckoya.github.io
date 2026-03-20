---
title: SonarCloud
description: Code quality and security platform - static analysis, code smells, bugs, vulnerabilities, technical debt tracking
---

# :fontawesome-solid-magnifying-glass-chart: SonarCloud

Cloud-based code quality and security platform by SonarSource. Static analysis for 30+ languages. Detects bugs, code smells, security vulnerabilities, duplications. Quality gates block merges. Free for open source.

!!! tip "2026 Update"
    AI-powered code suggestions for fixes. Pull request decoration shows quality metrics inline. Security hotspot detection improved. Free for public repos (unlimited). Supports monorepos with project separation.

______________________________________________________________________

## :fontawesome-solid-bolt-lightning: Quick Hits

=== ":fontawesome-solid-list-check: Essential Commands"

    ```bash
    # Installation (via npm for Node.js projects)
    npm install -D sonarqube-scanner

    # Or download CLI
    # https://docs.sonarcloud.io/advanced-setup/ci-based-analysis/sonarscanner-cli/

    # Scan project (requires sonar-project.properties)
    sonar-scanner \
      -Dsonar.organization=my-org \
      -Dsonar.projectKey=my-project \
      -Dsonar.sources=. \
      -Dsonar.host.url=https://sonarcloud.io \
      -Dsonar.token=$SONAR_TOKEN  # (1)!

    # JavaScript/TypeScript with coverage
    npm test -- --coverage  # Generate coverage
    sonar-scanner \
      -Dsonar.javascript.lcov.reportPaths=coverage/lcov.info  # (2)!

    # Java/Maven project
    mvn clean verify sonar:sonar \
      -Dsonar.projectKey=my-project \
      -Dsonar.organization=my-org \
      -Dsonar.host.url=https://sonarcloud.io \
      -Dsonar.token=$SONAR_TOKEN

    # .NET project
    dotnet sonarscanner begin \
      /k:"my-project" \
      /o:"my-org" \
      /d:sonar.host.url="https://sonarcloud.io" \
      /d:sonar.token="$SONAR_TOKEN"
    dotnet build
    dotnet sonarscanner end /d:sonar.token="$SONAR_TOKEN"  # (3)!
    ```

    1. Token generated in SonarCloud dashboard (Account → Security)
    2. LCOV format for test coverage integration
    3. Begin/build/end pattern for .NET projects

    **Real talk:**

    - Free for public repos (GitHub, Bitbucket, GitLab)
    - Paid for private repos: $10/month per 100k LOC
    - Quality gates can block PRs (configure thresholds)
    - PR decoration shows issues inline (better than separate tool)
    - 30+ languages: Java, C#, JS, Python, Go, PHP, C/C++, etc.

=== ":fontawesome-solid-bolt: Common Patterns"

    ```properties
    # sonar-project.properties (project root)
    sonar.projectKey=my-org_my-project
    sonar.organization=my-org

    # Source directories
    sonar.sources=src
    sonar.tests=tests

    # Exclusions (don't analyze)
    sonar.exclusions=**/*.test.js,**/vendor/**,**/node_modules/**  # (1)!

    # Coverage exclusions (don't measure coverage)
    sonar.coverage.exclusions=**/*.test.js,**/migrations/**

    # Language-specific settings
    sonar.javascript.lcov.reportPaths=coverage/lcov.info
    sonar.python.coverage.reportPaths=coverage.xml

    # Quality gate settings
    sonar.qualitygate.wait=true  # (2)!
    sonar.qualitygate.timeout=300
    ```

    1. Exclude test files, dependencies, generated code from analysis
    2. Wait for quality gate result before exiting (fails CI if gate fails)

    ```yaml
    # GitHub Actions integration (.github/workflows/sonarcloud.yml)
    name: SonarCloud Analysis

    on:
      push:
        branches: [main, develop]
      pull_request:
        types: [opened, synchronize, reopened]

    jobs:
      sonarcloud:
        runs-on: ubuntu-latest

        steps:
          - uses: actions/checkout@v4
            with:
              fetch-depth: 0  # Full history for blame info  # (1)!

          - name: Setup Node.js
            uses: actions/setup-node@v4
            with:
              node-version: '20'

          - name: Install dependencies
            run: npm ci

          - name: Run tests with coverage
            run: npm test -- --coverage  # (2)!

          - name: SonarCloud Scan
            uses: SonarSource/sonarcloud-github-action@master
            env:
              GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}  # (3)!
              SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}
            with:
              args: >
                -Dsonar.projectKey=my-org_my-project
                -Dsonar.organization=my-org
                -Dsonar.javascript.lcov.reportPaths=coverage/lcov.info
                -Dsonar.qualitygate.wait=true

          - name: Check Quality Gate
            run: |
              if [ "${{ job.status }}" != "success" ]; then
                echo "Quality gate failed!"
                exit 1
              fi
    ```

    1. Full git history needed for accurate blame and issue tracking
    2. Generate coverage report before SonarCloud scan
    3. GITHUB_TOKEN for PR decoration, SONAR_TOKEN for authentication

    ```yaml
    # GitLab CI integration (.gitlab-ci.yml)
    sonarcloud-check:
      stage: test
      image: sonarsource/sonar-scanner-cli:latest
      script:
        - npm test -- --coverage
        - sonar-scanner
          -Dsonar.projectKey=$SONAR_PROJECT_KEY
          -Dsonar.organization=$SONAR_ORGANIZATION
          -Dsonar.host.url=https://sonarcloud.io
          -Dsonar.token=$SONAR_TOKEN
          -Dsonar.javascript.lcov.reportPaths=coverage/lcov.info
          -Dsonar.qualitygate.wait=true
      only:
        - merge_requests
        - main
      cache:
        paths:
          - node_modules/
          - .scannerwork/  # (1)!
    ```

    1. Cache scanner work directory for faster subsequent scans

    **Why this works:**

    - PR decoration shows issues inline (developers see problems immediately)
    - Quality gates enforce standards (block merge if code quality degrades)
    - Coverage tracking shows untested code
    - Historical trends identify technical debt accumulation
    - Multi-language support in single platform

=== ":fontawesome-solid-fire: Pro Tips & Gotchas"

    !!! success "Best Practices"
        - **Quality gates** - Set realistic thresholds (80% coverage, no critical issues)
        - **New code focus** - SonarCloud analyzes new code differently (stricter)
        - **Exclusions** - Exclude generated code, dependencies, migrations
        - **PR decoration** - Enable for inline feedback (GitHub, GitLab, Bitbucket)
        - **Security hotspots** - Review regularly, mark as safe or fix
        - **Custom rules** - Disable noisy rules, enable org-specific rules
        - **Branch analysis** - Analyze feature branches for early feedback

    !!! warning "Security"
        - **SONAR_TOKEN** - Store in CI secrets, read-only token sufficient for scans
        - **Security hotspots** - Not vulnerabilities, but risky patterns (review carefully)
        - **OWASP Top 10** - SonarCloud detects injection, XSS, insecure crypto
        - **Secrets detection** - Finds hardcoded passwords, API keys
        - **Third-party code** - Exclude vendor code from analysis

    !!! tip "Performance"
        - **Incremental analysis** - SonarCloud only analyzes changed files on PR
        - **Cache .scannerwork/** - Speeds up subsequent scans (CI cache)
        - **Parallel analysis** - Multi-module projects analyzed in parallel
        - **Shallow clone** - Use `fetch-depth: 0` only if needed (blame info)

    !!! danger "Gotchas"
        - **Free tier** - Only for public repos, private costs $10/100k LOC/month
        - **Quality gate timing** - `wait=true` increases CI time (up to 5 min)
        - **False positives** - Mark as "Won't fix" or disable rule
        - **Coverage not uploaded** - Ensure coverage generated before scan
        - **Branch naming** - Main branch must be configured in SonarCloud settings
        - **Language detection** - Auto-detected, but can miscategorize (configure explicitly)
        - **Large codebases** - Analysis can take 10+ minutes (optimize exclusions)

______________________________________________________________________

## :fontawesome-solid-graduation-cap: Learning Resources

### :fontawesome-solid-book-open: Official Docs

- **[SonarCloud Documentation](https://docs.sonarcloud.io/)** - Complete guide
- **[SonarSource Rules](https://rules.sonarsource.com/)** - All language rules explained
- **[Clean Code Guide](https://www.sonarsource.com/learn/clean-code/)** - Best practices

### :fontawesome-solid-rocket: Key Features

- **30+ languages** - Java, C#, JavaScript, Python, Go, PHP, C/C++, Kotlin, Ruby, etc.
- **Quality gates** - Enforce code quality standards, block PRs
- **PR decoration** - Inline comments on pull requests
- **Security analysis** - OWASP Top 10, CWE, SANS Top 25
- **Technical debt** - Estimates time to fix issues
- **Code smells** - Maintainability issues, duplications

______________________________________________________________________

## :fontawesome-solid-star: Alternatives

- **[SonarQube](https://www.sonarsource.com/products/sonarqube/)** - Self-hosted version (on-prem)
- **[CodeClimate](https://codeclimate.com/)** - Similar features, different pricing
- **[Codacy](https://www.codacy.com/)** - Code quality + security
- **[DeepSource](https://deepsource.io/)** - Modern alternative with auto-fix

______________________________________________________________________

**Last Updated:** 2026-02-02 | **Vibe Check:** :fontawesome-solid-chart-line: **Quality Standard** - Industry leader for code quality. Free for open source is generous. PR decoration is must-have. Quality gates enforce discipline. Can be noisy (configure exclusions). Worth the cost for private repos.

**Tags:** sonarcloud, code-quality, sast, static-analysis, security
