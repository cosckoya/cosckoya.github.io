# Pre-Commit

Framework for managing and maintaining multi-language pre-commit hooks to ensure code quality before commits.

______________________________________________________________________

## Overview

### What is Pre-Commit?

Pre-commit is a framework for managing git hooks written in any language. It runs checks automatically before each
commit, catching issues early in the development process.

**Key Features:**

- 🎣 **Git Hooks Made Easy** - Simple YAML configuration
- 🔧 **Multi-Language** - Python, Node, Ruby, Go, Rust, etc.
- 📦 **Plugin Ecosystem** - Hundreds of ready-to-use hooks
- ⚡ **Fast** - Runs only on changed files
- 🔄 **CI Integration** - Run same checks in CI/CD

### Why Use Pre-Commit?

- ✅ **Catch Errors Early** - Before code review
- ✅ **Consistent Code Quality** - Enforce standards automatically
- ✅ **Save Time** - Automated formatting and linting
- ✅ **Easy Setup** - Single configuration file
- ✅ **Team-Wide Standards** - Same checks for everyone

______________________________________________________________________

## Getting Started

### Installation

**Official Guide:** **[Pre-Commit Installation](https://pre-commit.com/#install)**

```bash
# Using pip
pip install pre-commit

# Using Homebrew (macOS)
brew install pre-commit

# Using conda
conda install -c conda-forge pre-commit
```

### Quick Start

**1. Add configuration file** (`.pre-commit-config.yaml`):

```yaml
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.5.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-yaml
      - id: check-added-large-files
```

**2. Install hooks:**

```bash
pre-commit install
```

**3. Run on all files (optional):**

```bash
pre-commit run --all-files
```

**Learn More:**

- **[Quick Start Guide](https://pre-commit.com/#quick-start)** - Get running in 2 minutes
- **[Sample Configs](https://pre-commit.com/#usage-in-continuous-integration)** - Example configurations

______________________________________________________________________

## Core Concepts

### Hook Configuration

Understanding `.pre-commit-config.yaml`:

- **[Configuration Reference](https://pre-commit.com/#plugins)** - Full YAML schema
- **[Adding Plugins](https://pre-commit.com/#adding-pre-commit-plugins-to-your-project)** - How to add hooks
- **[Hook Arguments](https://pre-commit.com/#passing-arguments-to-hooks)** - Customize hook behavior

### Supported Languages

Pre-commit supports hooks in many languages:

- **[Supported Languages](https://pre-commit.com/#supported-languages)** - Complete list
- **[Creating Hooks](https://pre-commit.com/#creating-new-hooks)** - Write custom hooks
- **Language-specific:** Python, Node, Ruby, Go, Rust, Docker, System

### Running Hooks

Different execution modes:

```bash
pre-commit run                    # Run on staged files
pre-commit run --all-files        # Run on entire repo
pre-commit run <hook-id>          # Run specific hook
pre-commit run --files <file>     # Run on specific files
```

**Documentation:**

- **[Usage Guide](https://pre-commit.com/#usage)** - Running hooks
- **[Command Line Interface](https://pre-commit.com/#pre-commit-during-commits)** - CLI reference

______________________________________________________________________

## Popular Hooks

### General Hooks

**pre-commit-hooks** (official collection):

- **[Repository](https://github.com/pre-commit/pre-commit-hooks)** - Built-in hooks
- Trailing whitespace, EOF fixer, YAML/JSON check, merge conflicts, large files

### Python

- **[black](https://black.readthedocs.io/)** - Code formatter
- **[ruff](https://docs.astral.sh/ruff/)** - Fast linter
- **[mypy](http://mypy-lang.org/)** - Static type checker
- **[isort](https://pycqa.github.io/isort/)** - Import sorter

### JavaScript/TypeScript

- **[eslint](https://eslint.org/)** - Linter
- **[prettier](https://prettier.io/)** - Code formatter
- **[tsc](https://www.typescriptlang.org/)** - TypeScript compiler

### Markdown

- **[markdownlint](https://github.com/igorshubovych/markdownlint-cli)** - Markdown linter
- **[mdformat](https://mdformat.readthedocs.io/)** - Markdown formatter

### Security

- **[detect-secrets](https://github.com/Yelp/detect-secrets)** - Find secrets in code
- **[gitleaks](https://github.com/gitleaks/gitleaks)** - Scan for credentials
- **[trivy](https://github.com/aquasecurity/trivy)** - Vulnerability scanner

**Discover More:**

- **[Supported Hooks List](https://pre-commit.com/hooks.html)** - Official curated list

______________________________________________________________________

## CI Integration

### Run in CI/CD

Pre-commit can run in your CI pipeline:

```yaml
# GitHub Actions example
- uses: pre-commit/action@v3.0.0
```

**Documentation:**

- **[CI Integration Guide](https://pre-commit.com/#usage-in-continuous-integration)** - Setup for CI/CD
- **[GitHub Actions](https://github.com/pre-commit/action)** - Official action
- **[GitLab CI Example](https://pre-commit.com/#gitlab-ci-example)** - GitLab setup

______________________________________________________________________

## Best Practices

**Configuration:**

- Pin hook versions with `rev` for reproducibility
- Run `pre-commit autoupdate` regularly
- Use `pre-commit run --all-files` after updates
- Add `.pre-commit-config.yaml` to version control

**Team Workflow:**

- Document required setup in README
- Run hooks in CI to enforce standards
- Keep hook list focused (don't overwhelm developers)
- Use auto-fixers (black, prettier) for formatting

**Performance:**

- Hooks run only on changed files by default
- Use `files` regex to limit hook scope
- Consider `stages` for commit vs push hooks
- Profile with `pre-commit run --verbose`

**Learn More:**

- **[Advanced Features](https://pre-commit.com/#advanced-features)** - Power user guide
- **[Confining Hooks](https://pre-commit.com/#confining-hooks-to-run-at-certain-stages)** - Stage-specific hooks

______________________________________________________________________

## Resources & Links

### 🏠 Official

- **[Pre-Commit Website](https://pre-commit.com/)** - Official homepage
- **[Documentation](https://pre-commit.com/)** - Complete guide
- **[GitHub Repository](https://github.com/pre-commit/pre-commit)** - Source code
- **[Changelog](https://github.com/pre-commit/pre-commit/releases)** - Release notes

### 📚 Documentation

- **[Quick Start](https://pre-commit.com/#quick-start)** - Get started fast
- **[Configuration](https://pre-commit.com/#plugins)** - YAML reference
- **[Supported Languages](https://pre-commit.com/#supported-languages)** - Language support
- **[Creating Hooks](https://pre-commit.com/#creating-new-hooks)** - Write custom hooks
- **[CI Integration](https://pre-commit.com/#usage-in-continuous-integration)** - CI/CD setup

### 💻 Hooks & Plugins

- **[Supported Hooks](https://pre-commit.com/hooks.html)** - Curated list
- **[pre-commit-hooks](https://github.com/pre-commit/pre-commit-hooks)** - Official collection
- **[GitHub Topics](https://github.com/topics/pre-commit-hook)** - Community hooks

### 🎓 Learning

- **[Installation Guide](https://pre-commit.com/#install)** - Setup instructions
- **[Usage Examples](https://pre-commit.com/#usage)** - Common workflows
- **[Advanced Features](https://pre-commit.com/#advanced-features)** - Power user guide

### 👥 Community

- **[GitHub Discussions](https://github.com/pre-commit/pre-commit/discussions)** - Q&A forum
- **[GitHub Issues](https://github.com/pre-commit/pre-commit/issues)** - Bug reports
- **[Gitter Chat](https://gitter.im/pre-commit/Lobby)** - Real-time chat

### 🔧 Integrations

- **[GitHub Actions](https://github.com/pre-commit/action)** - Official action
- **[pre-commit.ci](https://pre-commit.ci/)** - Automated hook runner service
- **[IDE Plugins](https://pre-commit.com/#integration-with-ides)** - Editor support

______________________________________________________________________

## Related Topics

- **[GitHub](github.md)** - Git workflows and collaboration
- **[GitHub Actions](github-actions.md)** - CI/CD automation
- **[Claude Code](claude-code.md)** - Use hooks with AI-assisted development

______________________________________________________________________

**Last Updated:** 2026-01-13 **Status:** Active **Maintained by:** DocMaster Agent v2.0
