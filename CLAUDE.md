# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a personal technical documentation site built with MkDocs Material and hosted on GitHub Pages at https://cosckoya.github.io. The site serves as a comprehensive knowledge base covering six main technical domains: SysAdmin, Cloud, DevOps, Containerization, Security (Hack), and Tools.

## Build System and Commands

### Development Workflow

```bash
# First-time setup
make dev              # Creates venv, installs dependencies, sets up pre-commit hooks

# Local development
make serve            # Start live-reload server at localhost:8000

# Building and testing
make build            # Build site in strict mode (catches all warnings/errors)
make test             # Run pre-commit hooks + strict build validation

# Deployment
make deploy           # Deploy to GitHub Pages (rarely needed - CI handles this)

# Maintenance
make clean            # Remove build artifacts and Python cache files
make update           # Update dependencies to latest compatible versions
```

### Key Requirements

- All builds use `mkdocs build --strict` which treats warnings as errors
- Pre-commit hooks enforce markdown formatting, spell checking, and YAML validation
- Python virtual environment in `venv/` directory is used for dependency isolation

### Dependency Management

The project uses modern **PEP 621** standards via `pyproject.toml`:

- Single source of truth for all dependencies (KISS principle)
- Separates production and development dependencies
- Includes Ruff configuration for future Python code quality
- No need for `requirements.txt` or `requirements-lock.txt`

**Installation:**

```bash
pip install -e .          # Install production dependencies
pip install -e .[dev]     # Install with dev tools (mdformat, codespell, yamllint, ruff)
```

**Why pyproject.toml?**

- **KISS**: Single configuration file instead of multiple
- **DRY**: No duplication between setup.py, requirements.txt, etc.
- **Modern**: PEP 621 standard, supported by all modern Python tools
- **Clean**: Declarative format, easier to read and maintain

## Architecture

### Content Organization

The site uses **literate navigation** via `SUMMARY.md` files. Each major section has:

- `SUMMARY.md` - Defines navigation structure for that section
- `index.md` - Landing page for the section

Main sections:

- `docs/sysadmin/` - Linux, networking, storage, fundamentals
- `docs/cloud/` - AWS, Azure, GCP with sub-sections for each platform
- `docs/devops/` - Git workflows, CI/CD, GitHub Actions
- `docs/containerization/` - Docker, Kubernetes, Helm
- `docs/hack/` - OSINT, pentesting, security research
- `docs/tools/` - CLI tools, editors, utilities

### Navigation Structure

Navigation is controlled by `SUMMARY.md` files using the `mkdocs-literate-nav` plugin:

- Main navigation: `docs/SUMMARY.md`
- Section navigation: `docs/<section>/SUMMARY.md`
- Maximum 3-level hierarchy enforced
- All links must be relative paths from the SUMMARY.md location

### Theme and Styling

MkDocs Material theme (v9.7.0+) with:

- Slate color scheme with deep purple/teal accents
- Custom CSS in `docs/resources/stylesheets/` and `docs/stylesheets/`
- Features enabled: code copy buttons, navigation indexes, tabbed content
- HTML/JS/CSS minification for production builds

### Markdown Extensions

Available extensions in `mkdocs.yml`:

- **Admonitions** - Use `!!! note`, `!!! warning`, `!!! tip` for callouts
- **Tabbed content** - Use `=== "Tab Name"` syntax
- **Code highlighting** - Automatic syntax highlighting with copy buttons
- **Table of contents** - Auto-generated with permalinks
- **Superfences** - Nested code blocks and content blocks

## Development Guidelines

### Adding New Content

1. Create markdown file in appropriate section directory
1. Add entry to the section's `SUMMARY.md` file
1. Use relative paths from the SUMMARY.md location
1. Test with `make serve` to verify navigation works
1. Run `make test` before committing

### Modifying Navigation

- Navigation is defined in `SUMMARY.md` files, not in `mkdocs.yml`
- Main nav: `docs/SUMMARY.md`
- Section nav: `docs/<section>/SUMMARY.md`
- Format: `- [Link Text](relative/path.md)`
- For directory links, use trailing slash: `- [Section](directory/)`

### Link Integrity

Use DocMaster Tools scripts for validation:

```bash
./scripts/docmaster-tools.sh check-links          # Verify all internal links
./scripts/docmaster-tools.sh find-orphans         # Find files not in navigation
./scripts/docmaster-tools.sh validate-structure   # Check directory structure
./scripts/docmaster-tools.sh full-maintenance     # Run all checks
```

Exit codes: 0 = success, 1 = issues detected

### Code Quality and Style Guidelines

The project uses **pre-commit hooks** to enforce code quality automatically. Hooks are configured in `.pre-commit-config.yaml` and integrated with `pyproject.toml`.

**First-time setup:**

```bash
make dev              # Installs pre-commit and all hooks automatically
```

**Manual operations:**

```bash
# Run all hooks on all files
pre-commit run --all-files

# Run specific hook
pre-commit run ruff --all-files
pre-commit run mdformat --all-files

# Update hooks to latest versions
pre-commit autoupdate

# Skip hooks temporarily (use sparingly)
git commit --no-verify
```

**Automated checks:**

- **Ruff** - Modern Python linter and formatter (replaces black, isort, flake8)
- **mdformat** - Markdown formatting with MkDocs support
- **codespell** - Spell checking for documentation
- **yamllint** - YAML file validation
- **bandit** - Python security vulnerability scanning
- **Standard hooks** - File checks, trailing whitespace, JSON/TOML/YAML syntax

**On every commit**, pre-commit automatically:

1. Formats Python code with Ruff
1. Formats Markdown files preserving MkDocs syntax
1. Checks spelling in all text files
1. Validates YAML configuration files
1. Prevents commits to protected branches (main/master)
1. Checks for large files, merge conflicts, private keys

## CI/CD Pipeline

GitHub Actions workflow (`.github/workflows/gh-pages.yml`):

- Triggers on push to `main` branch only
- Builds with `mkdocs build --strict`
- Deploys to `gh-pages` branch automatically
- Caches pip dependencies and MkDocs Material assets (weekly rotation)

**Important**: Only pushes to `main` trigger deployment. Development should happen in feature branches.

## Common Scenarios

### Adding a New Section

1. Create directory: `docs/newsection/`
1. Create `docs/newsection/index.md` with section overview
1. Create `docs/newsection/SUMMARY.md` with section navigation
1. Add section to main `docs/SUMMARY.md`: `- [New Section](newsection/)`
1. Verify with `make serve` and `./scripts/docmaster-tools.sh validate-structure`

### Fixing Broken Links

1. Run `./scripts/docmaster-tools.sh check-links` to identify issues
1. Links must be relative to the file containing them
1. Directory links should point to directory with trailing slash or to `index.md`
1. Verify fix with `make build` (strict mode will catch broken links)

### Updating Dependencies

```bash
make update           # Updates all Python packages
make test            # Verify everything still works
# Review changes to requirements-lock.txt
```

Dependabot runs monthly to suggest dependency updates via pull requests.

## Available Skills

### `/mkdocs-material-expert` - MkDocs Material Theme Specialist

A UX/UI documentation designer specializing in Material for MkDocs. She's passionate about beautiful, accessible documentation and loves octicons! :octicons-heart-16:

**Core Expertise**:

- Material theme configuration (colors, typography, icons)
- Icon systems (Octicons, FontAwesome, Material Design Icons)
- UX/UI optimization (navigation, search, breadcrumbs, social cards)
- Plugin ecosystem (search, tags, blog, social, offline, minify)
- Performance optimization and accessibility (WCAG 2.1 AA)
- Advanced features (annotations, code blocks, admonitions, tabs)

**Use when**:

- Enhancing mkdocs.yml configuration
- Adding new Material theme features
- Improving navigation and search UX
- Configuring plugins (social cards, git-committers, blog)
- Optimizing site performance
- Ensuring accessibility compliance
- Adding custom CSS/styling

**Example invocations**:

- `/mkdocs-material-expert audit` - Review current setup and suggest improvements
- `/mkdocs-material-expert add octicons` - Configure octicon icons
- `/mkdocs-material-expert improve navigation` - Enhance navigation UX
- `/mkdocs-material-expert enable social cards` - Setup OG image generation

### `/devops-github-expert` - CI/CD/CS Pipeline Automation Specialist

A DevOps engineer specializing in GitHub Actions, GitHub Pages, and modern CI/CD/CS practices. She follows KISS, DRY, and Clean Code principles, embracing Infrastructure as Code, Everything as Code, Immutable Infrastructure, and Continuous Everything philosophies.

**Core Expertise**:

- GitHub Actions workflows (CI/CD/CS pipelines)
- GitHub Pages deployment (modern 2026 patterns)
- Security scanning (Trivy, Gitleaks, SBOM generation)
- Performance optimization (caching, parallel jobs, matrix strategies)
- Infrastructure as Code (Dependabot, Renovate, repository settings)
- Reusable workflows and composite actions (DRY principle)
- Immutable deployments (build once, deploy everywhere)

**Use when**:

- Auditing or optimizing GitHub Actions workflows
- Implementing or improving GitHub Pages deployment
- Adding security scanning (vulnerability detection, secret scanning)
- Setting up dependency management (Dependabot/Renovate)
- Creating reusable workflows or composite actions
- Improving pipeline performance and efficiency
- Enforcing DevOps best practices and security policies

**Example invocations**:

- `/devops-github-expert audit` - Review workflows for security and performance issues
- `/devops-github-expert optimize pages deployment` - Modernize GitHub Pages workflow
- `/devops-github-expert add security scanning` - Implement Trivy, Gitleaks, SBOM
- `/devops-github-expert setup dependabot` - Configure automated dependency updates
- `/devops-github-expert create reusable workflow` - Design DRY composite actions

## Project-Specific Notes

### Virtual Environment

The project uses a Python virtual environment in `venv/`. Always activate it before manual operations:

```bash
source venv/bin/activate
```

Make targets handle this automatically.

### Strict Mode Enforcement

All builds use `--strict` flag. This means:

- Warnings are treated as errors
- Broken links cause build failure
- Missing files in navigation cause build failure
- Invalid markdown extensions cause build failure

This is intentional and ensures high quality documentation.

### DocMaster Tools Integration

The `scripts/docmaster-tools.sh` script provides automated maintenance:

- **check-links** - Scan for broken internal links
- **find-orphans** - Find markdown files not in navigation
- **validate-structure** - Check directory structure conventions
- **cleanup-empty** - Remove empty directories
- **audit-freshness** - Find stale content and TODO markers
- **validate-build** - Run build in strict mode
- **full-maintenance** - Run all checks in sequence

Use these tools before committing significant changes to ensure documentation integrity.

### Assets and Images

- Logos/favicons: `docs/resources/img/`
- Custom CSS: `docs/resources/stylesheets/` and `docs/stylesheets/`
- Images should be referenced with relative paths from the markdown file

### Branch Strategy

- `main` - Production branch, auto-deploys to GitHub Pages
- `develop` - Development branch (based on git status)
- Feature branches - Create from develop, PR back to develop
- Only maintainer pushes to main trigger deployment
