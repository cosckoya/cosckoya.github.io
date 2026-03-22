---
title: pre-commit
description: Git hook framework - automate code quality checks, run linters/formatters before commits, prevent bad code from entering repo
---

# :fontawesome-solid-shield-halved: pre-commit

Framework for managing git hooks. Runs linters, formatters, security scanners before commits. Language-agnostic (Python, Go, Node.js, Rust). Prevents bad commits (syntax errors, secrets, formatting issues). Hooks defined in `.pre-commit-config.yaml`. Fast parallel execution. Integrates with CI/CD.

!!! tip "2026 Update"
    pre-commit 3.x brings performance improvements (30% faster). Native support for Ruff, Biome. Docker hooks no longer experimental. Remote hooks cached locally. Auto-update via `pre-commit autoupdate`. GitHub Actions integration official. 200+ hooks in community registry.

______________________________________________________________________

## :fontawesome-solid-bolt: Quick Hits

=== ":fontawesome-solid-list-check: Essential Commands"

    ```bash
    # Installation
    pip install pre-commit              # Python (recommended)
    brew install pre-commit             # macOS
    # Or: pipx install pre-commit       # Isolated install

    # Install hooks in repository
    pre-commit install                  # Install git hooks  # (1)!
    pre-commit install --hook-type commit-msg  # Commit message hooks
    pre-commit install --hook-type pre-push    # Pre-push hooks

    # Run hooks manually (without committing)
    pre-commit run --all-files          # Run on all files  # (2)!
    pre-commit run                      # Run on staged files only
    pre-commit run <hook-id>            # Run specific hook
    pre-commit run --files file1.py file2.py  # Run on specific files

    # Update hooks to latest versions
    pre-commit autoupdate               # Update .pre-commit-config.yaml  # (3)!

    # Uninstall hooks
    pre-commit uninstall                # Remove git hooks

    # Clean cache
    pre-commit clean                    # Remove unused hook environments

    # Validate configuration
    pre-commit validate-config          # Check .pre-commit-config.yaml syntax

    # Sample output (passing)
    # Trim Trailing Whitespace.......Passed
    # Fix End of Files................Passed
    # Check YAML.....................Passed
    # Black...........................Passed  # (4)!

    # Sample output (failing)
    # Black...........................Failed
    # - hook id: black
    # - files were modified by this hook
    #
    # reformatted app.py
    # 1 file reformatted.
    ```

    1. Installs hooks into `.git/hooks/pre-commit` automatically
    2. Useful for testing hooks before committing
    3. Updates hook versions to latest releases (safe upgrade)
    4. Hooks run in parallel (fast execution)

    **Real talk:**

    - First commit after install is slow (builds hook environments)
    - Subsequent commits are fast (environments cached)
    - Failed hooks prevent commit (fix issues, re-commit)
    - Some hooks auto-fix (formatters), others report (linters)
    - Skip hooks with `git commit --no-verify` (emergency only)

=== ":fontawesome-solid-bolt: Common Patterns"

    **Configuration file (.pre-commit-config.yaml):**

    ```yaml
    # Python project example
    repos:
      # Built-in hooks (trailing whitespace, EOF, YAML, etc.)
      - repo: https://github.com/pre-commit/pre-commit-hooks
        rev: v4.5.0
        hooks:
          - id: trailing-whitespace  # (1)!
          - id: end-of-file-fixer
          - id: check-yaml
          - id: check-json
          - id: check-added-large-files
            args: ['--maxkb=500']
          - id: check-merge-conflict
          - id: detect-private-key  # (2)!

      # Python: Ruff (linter + formatter, fast)
      - repo: https://github.com/astral-sh/ruff-pre-commit
        rev: v0.1.14
        hooks:
          - id: ruff
            args: [--fix, --exit-non-zero-on-fix]
          - id: ruff-format  # (3)!

      # Python: mypy (type checking)
      - repo: https://github.com/pre-commit/mirrors-mypy
        rev: v1.8.0
        hooks:
          - id: mypy
            additional_dependencies: [types-requests]  # (4)!

      # Security: Gitleaks (secret scanning)
      - repo: https://github.com/gitleaks/gitleaks
        rev: v8.18.1
        hooks:
          - id: gitleaks  # (5)!

      # Markdown: markdownlint
      - repo: https://github.com/igorshubovych/markdownlint-cli
        rev: v0.39.0
        hooks:
          - id: markdownlint
            args: [--fix]

      # Shell: shellcheck
      - repo: https://github.com/shellcheck-py/shellcheck-py
        rev: v0.9.0.6
        hooks:
          - id: shellcheck
    ```

    1. Removes trailing whitespace from all files
    2. Prevents committing SSH keys, AWS credentials
    3. Ruff replaces Black + Flake8 + isort (50x faster)
    4. Additional dependencies for type stubs
    5. Scans for secrets in code and git history

    **JavaScript/TypeScript project:**

    ```yaml
    repos:
      - repo: https://github.com/pre-commit/pre-commit-hooks
        rev: v4.5.0
        hooks:
          - id: trailing-whitespace
          - id: end-of-file-fixer
          - id: check-json
          - id: check-yaml

      # Biome (linter + formatter, Rust-based)
      - repo: https://github.com/biomejs/pre-commit
        rev: v1.5.1
        hooks:
          - id: biome-check
            args: [--apply]  # (1)!

      # ESLint (alternative to Biome)
      - repo: https://github.com/pre-commit/mirrors-eslint
        rev: v9.0.0
        hooks:
          - id: eslint
            files: \.[jt]sx?$  # .js, .jsx, .ts, .tsx
            types: [file]
            additional_dependencies:
              - eslint@9.0.0
              - '@typescript-eslint/parser@7.0.0'

      # Prettier (formatter)
      - repo: https://github.com/pre-commit/mirrors-prettier
        rev: v4.0.0
        hooks:
          - id: prettier
            types_or: [javascript, jsx, ts, tsx, json, css]  # (2)!

      # Security: npm audit
      - repo: local
        hooks:
          - id: npm-audit
            name: npm audit
            entry: npm audit --audit-level=high
            language: system
            pass_filenames: false  # (3)!
    ```

    1. Biome auto-fixes issues (format + lint)
    2. types_or runs on multiple file types
    3. Local hooks run system commands

    **Go project:**

    ```yaml
    repos:
      - repo: https://github.com/pre-commit/pre-commit-hooks
        rev: v4.5.0
        hooks:
          - id: trailing-whitespace
          - id: end-of-file-fixer
          - id: check-yaml

      # Go: gofmt + goimports
      - repo: https://github.com/dnephin/pre-commit-golang
        rev: v0.5.1
        hooks:
          - id: go-fmt  # (1)!
          - id: go-imports
          - id: go-vet
          - id: go-mod-tidy

      # Go: golangci-lint (meta-linter)
      - repo: https://github.com/golangci/golangci-lint
        rev: v1.56.0
        hooks:
          - id: golangci-lint
            args: [--fix]  # (2)!

      # Go: govulncheck (vulnerability scanner)
      - repo: local
        hooks:
          - id: govulncheck
            name: govulncheck
            entry: govulncheck ./...
            language: system
            pass_filenames: false
    ```

    1. gofmt enforces Go formatting (mandatory)
    2. golangci-lint runs 50+ linters in parallel

    **Multi-language project:**

    ```yaml
    repos:
      # Universal checks
      - repo: https://github.com/pre-commit/pre-commit-hooks
        rev: v4.5.0
        hooks:
          - id: trailing-whitespace
          - id: end-of-file-fixer
          - id: check-yaml
          - id: check-json
          - id: check-merge-conflict
          - id: detect-private-key

      # Python
      - repo: https://github.com/astral-sh/ruff-pre-commit
        rev: v0.1.14
        hooks:
          - id: ruff
            args: [--fix]
          - id: ruff-format

      # JavaScript/TypeScript
      - repo: https://github.com/biomejs/pre-commit
        rev: v1.5.1
        hooks:
          - id: biome-check
            args: [--apply]
            files: \.[jt]sx?$

      # Go
      - repo: https://github.com/dnephin/pre-commit-golang
        rev: v0.5.1
        hooks:
          - id: go-fmt
          - id: go-imports
            files: \.go$

      # Docker
      - repo: https://github.com/hadolint/hadolint
        rev: v2.12.0
        hooks:
          - id: hadolint-docker  # (1)!

      # Security (all languages)
      - repo: https://github.com/gitleaks/gitleaks
        rev: v8.18.1
        hooks:
          - id: gitleaks
    ```

    1. Hadolint lints Dockerfiles (best practices)

    **CI/CD integration (GitHub Actions):**

    ```yaml
    # .github/workflows/pre-commit.yml
    name: pre-commit

    on:
      pull_request:
      push:
        branches: [main]

    jobs:
      pre-commit:
        runs-on: ubuntu-latest
        steps:
          - uses: actions/checkout@v4
          - uses: actions/setup-python@v5
          - uses: pre-commit/action@v3.0.0  # (1)!
    ```

    1. Official pre-commit GitHub Action

    **Why this works:**

    - Catches issues before code review (saves time)
    - Auto-fixes formatting (no manual formatting needed)
    - Prevents secrets from entering repository
    - Runs in parallel (fast execution)
    - Language-agnostic (works with any language)
    - CI integration ensures hooks run on all PRs

=== ":fontawesome-solid-fire: Pro Tips & Gotchas"

    !!! success "Best Practices"
        - **Start simple** - Add hooks gradually (don't overwhelm team)
        - **Auto-fix hooks first** - Formatters before linters (less friction)
        - **Pin versions** - Use `rev` tag for reproducibility
        - **Run in CI** - Enforce hooks on pull requests (GitHub Actions)
        - **Document skipping** - Explain when `--no-verify` is acceptable
        - **Update regularly** - `pre-commit autoupdate` monthly
        - **Test before merge** - Run `--all-files` before committing config
        - **Cache in CI** - Use `pre-commit/action` with caching

    !!! warning "Performance"
        - **First run slow** - Builds environments (subsequent runs fast)
        - **Limit scope** - Use `files:` regex to target specific files
        - **Parallel execution** - Hooks run concurrently (fast by default)
        - **Skip heavy checks** - Move expensive checks to pre-push or CI
        - **Local hooks** - Use `repo: local` for system commands
        - **Cache environments** - pre-commit caches in `~/.cache/pre-commit`

    !!! tip "Advanced Usage"
        - **Commit message hooks** - `--hook-type commit-msg` (conventional commits)
        - **Pre-push hooks** - Expensive checks (tests, builds) before push
        - **Multiple stages** - `stages: [commit, push]` for different hooks
        - **Exclude files** - `exclude: ^migrations/` to skip directories
        - **Language version** - `language_version: python3.11` for specific version
        - **Pass filenames** - `pass_filenames: false` for repo-wide checks
        - **Docker hooks** - Run hooks in containers (isolation)

    !!! danger "Common Gotchas"
        - **Skipping hooks** - `--no-verify` bypasses all checks (dangerous in CI)
        - **Version conflicts** - Different hook versions between team members
        - **Slow hooks** - Heavy linters block commits (move to CI)
        - **Auto-fix loops** - Hook modifies files, triggers again (use `--fix`)
        - **Missing dependencies** - Hooks need runtime (e.g., Node.js for ESLint)
        - **Merge conflicts** - `.pre-commit-config.yaml` conflicts common
        - **Cache issues** - Corrupt cache fixed with `pre-commit clean`
        - **Windows compatibility** - Some hooks bash-specific (Docker alternative)

    !!! info "Popular Hook Collections"
        - **pre-commit-hooks** - Basic checks (whitespace, EOF, YAML, JSON)
        - **commitizen** - Conventional commit messages
        - **detect-secrets** - Yelp's secret scanner (alternative to Gitleaks)
        - **prettier** - Multi-language formatter
        - **hadolint** - Dockerfile linter
        - **terraform-docs** - Auto-generate Terraform documentation
        - **ansible-lint** - Ansible playbook linter

______________________________________________________________________

## :fontawesome-solid-box: Hook Categories

### Code Quality

**Python:**
- Ruff (linter + formatter, fastest)
- Black (formatter, opinionated)
- isort (import sorting)
- pylint (comprehensive linting)
- mypy (static type checking)

**JavaScript/TypeScript:**
- Biome (linter + formatter, Rust-based)
- ESLint (linter, configurable)
- Prettier (formatter, multi-language)
- TypeScript compiler (tsc --noEmit)

**Go:**
- gofmt (formatter, mandatory)
- goimports (import management)
- golangci-lint (meta-linter, 50+ linters)
- go vet (built-in static analysis)

### Security

- **Gitleaks** - Secret scanning (API keys, passwords, tokens)
- **detect-secrets** - Entropy-based secret detection
- **Bandit** - Python security linter
- **Safety** - Python dependency vulnerability scanner
- **npm audit** - JavaScript dependency scanner
- **Trivy** - Multi-purpose security scanner

### File Checks

- **trailing-whitespace** - Remove trailing spaces
- **end-of-file-fixer** - Ensure newline at EOF
- **check-yaml** - Validate YAML syntax
- **check-json** - Validate JSON syntax
- **check-added-large-files** - Prevent large files (default: 500KB)
- **check-merge-conflict** - Detect merge conflict markers
- **detect-private-key** - Prevent committing SSH keys

### Documentation

- **markdownlint** - Markdown linter
- **terraform-docs** - Auto-generate Terraform docs
- **godoc** - Go documentation checker

______________________________________________________________________

## :fontawesome-solid-book: Learning Resources

### :fontawesome-solid-graduation-cap: Official Resources

- **[pre-commit Documentation](https://pre-commit.com/)** - Official docs (comprehensive)
- **[Supported Hooks](https://pre-commit.com/hooks.html)** - Community hook registry
- **[Creating Hooks](https://pre-commit.com/#creating-new-hooks)** - Build custom hooks
- **[GitHub Action](https://github.com/pre-commit/action)** - Official CI integration

### :fontawesome-solid-code: Example Configurations

!!! example "Minimal Python Project"
    ```yaml
    repos:
      - repo: https://github.com/pre-commit/pre-commit-hooks
        rev: v4.5.0
        hooks:
          - id: trailing-whitespace
          - id: end-of-file-fixer
          - id: check-yaml

      - repo: https://github.com/astral-sh/ruff-pre-commit
        rev: v0.1.14
        hooks:
          - id: ruff
            args: [--fix]
          - id: ruff-format
    ```

!!! example "Full-Stack Project"
    ```yaml
    repos:
      # Universal
      - repo: https://github.com/pre-commit/pre-commit-hooks
        rev: v4.5.0
        hooks:
          - id: trailing-whitespace
          - id: end-of-file-fixer
          - id: check-yaml
          - id: check-json
          - id: detect-private-key

      # Backend (Python)
      - repo: https://github.com/astral-sh/ruff-pre-commit
        rev: v0.1.14
        hooks:
          - id: ruff
            args: [--fix]
          - id: ruff-format
            files: ^backend/

      # Frontend (TypeScript)
      - repo: https://github.com/biomejs/pre-commit
        rev: v1.5.1
        hooks:
          - id: biome-check
            args: [--apply]
            files: ^frontend/

      # Security
      - repo: https://github.com/gitleaks/gitleaks
        rev: v8.18.1
        hooks:
          - id: gitleaks
    ```

!!! example "DevOps/Infrastructure"
    ```yaml
    repos:
      - repo: https://github.com/pre-commit/pre-commit-hooks
        rev: v4.5.0
        hooks:
          - id: trailing-whitespace
          - id: end-of-file-fixer
          - id: check-yaml

      # Terraform
      - repo: https://github.com/antonbabenko/pre-commit-terraform
        rev: v1.86.0
        hooks:
          - id: terraform_fmt
          - id: terraform_validate
          - id: terraform_docs

      # Docker
      - repo: https://github.com/hadolint/hadolint
        rev: v2.12.0
        hooks:
          - id: hadolint-docker

      # Kubernetes
      - repo: https://github.com/Lucas-C/pre-commit-hooks
        rev: v1.5.4
        hooks:
          - id: insert-license
            files: \.yaml$
    ```

______________________________________________________________________

## :fontawesome-solid-star: Worth Checking

<div class="grid cards" markdown>

- :fontawesome-solid-book: __Official Docs__

    ______________________________________________________________________

    [pre-commit Documentation](https://pre-commit.com/)

    [Supported Hooks Registry](https://pre-commit.com/hooks.html)

    [GitHub Repository](https://github.com/pre-commit/pre-commit)

    [GitHub Action](https://github.com/pre-commit/action)

- :fontawesome-solid-wrench: __Popular Hooks__

    ______________________________________________________________________

    [pre-commit-hooks (official)](https://github.com/pre-commit/pre-commit-hooks)

    [Ruff](https://github.com/astral-sh/ruff-pre-commit)

    [Biome](https://github.com/biomejs/pre-commit)

    [Gitleaks](https://github.com/gitleaks/gitleaks)

    [golangci-lint](https://github.com/golangci/golangci-lint)

- :fontawesome-solid-code: __Alternative Tools__

    ______________________________________________________________________

    [Husky](https://typicode.github.io/husky/) (Node.js-specific)

    [Lefthook](https://github.com/evilmartians/lefthook) (Go-based alternative)

    [lint-staged](https://github.com/okonet/lint-staged) (Run on staged files only)

- :fontawesome-solid-users: __Community__

    ______________________________________________________________________

    [GitHub Discussions](https://github.com/pre-commit/pre-commit/discussions)

    [Stack Overflow [pre-commit]](https://stackoverflow.com/questions/tagged/pre-commit)

    [Reddit r/programming](https://reddit.com/r/programming)

</div>

______________________________________________________________________

**Last Updated:** 2026-02-02 | **Vibe Check:** :fontawesome-solid-shield-halved: **Essential** - pre-commit prevents bad commits (formatting, secrets, syntax errors). Auto-fixes save time. Language-agnostic (works with Python, Go, Node.js, etc.). First run slow (environment setup), subsequent fast. Integrate with CI (GitHub Actions). Team adoption requires discipline (`--no-verify` tempting but dangerous). 200+ hooks available.

**Tags:** pre-commit, git-hooks, code-quality, automation, linting
