# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Language Policy:** All Claude Code interactions must be conducted in English only.

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

Uses **PEP 621** via `pyproject.toml` - single source of truth for all dependencies.

```bash
pip install -e .          # Production dependencies
pip install -e .[dev]     # + development tools (mdformat, codespell, ruff)
```

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

Validate documentation integrity with these commands:

```bash
make build                    # Strict mode catches broken links and missing files
make test                     # Run pre-commit hooks + build validation
grep -r "\.md" docs/ | grep -v "site/"  # Find all markdown files
```

The strict build mode (`mkdocs build --strict`) will fail on:
- Broken internal links
- Missing files in navigation
- Orphaned pages not in SUMMARY.md files

### Code Quality and Style Guidelines

**Pre-commit hooks** enforce quality automatically (configured in `.pre-commit-config.yaml`):

```bash
make dev                      # Setup hooks
pre-commit run --all-files    # Run manually
```

**Automated checks:** Ruff (Python), mdformat (Markdown), codespell (spelling), yamllint (YAML), bandit (security)

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
1. Verify with `make serve` and `make build` (strict mode validates structure)

### Fixing Broken Links

1. Run `make build` to identify broken links (strict mode fails on errors)
1. Links must be relative to the file containing them
1. Directory links should point to directory with trailing slash or to `index.md`
1. Test with `make serve` to verify navigation works correctly

### Updating Dependencies

```bash
make update           # Updates all Python packages
make test            # Verify everything still works
# Review changes to requirements-lock.txt
```

Dependabot runs monthly to suggest dependency updates via pull requests.

## Available Skills

### `/mkdocs-material-expert` - MkDocs Material Theme Specialist

UX/UI designer for Material for MkDocs. Specializes in theme configuration, icon systems (loves octicons! :octicons-heart-16:), navigation, plugins, performance, and accessibility (WCAG 2.1 AA).

**Use for:** mkdocs.yml configuration, Material theme features, navigation/search UX, plugin setup, performance optimization, custom CSS.

### `/devops-github-expert` - CI/CD/CS Pipeline Automation Specialist

DevOps engineer for GitHub Actions, Pages, and modern CI/CD/CS. Follows KISS, DRY, Clean Code, IaC, Everything as Code, Immutable Infrastructure, Continuous Everything.

**Use for:** Workflow optimization, GitHub Pages deployment, security scanning (Trivy, Gitleaks, SBOM), Dependabot setup, reusable workflows, performance tuning.

### `/technical-writer` - DevSecOps Documentation Specialist

Professional technical writer for ANY technology following formal IEC/IEEE 82079-1 and ALCOA-C standards (superior to AWS docs). Integrates DevSecOps philosophies, Docs-as-Code, and AI optimization (GEO).

**Use for:** API docs (OpenAPI), ADRs, security docs (threat models), runbooks (RTO/RPO), infrastructure docs, quality metrics, automated validation.

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

### Assets and Images

- Logos/favicons: `docs/resources/img/`
- Custom CSS: `docs/resources/stylesheets/` and `docs/stylesheets/`
- Images should be referenced with relative paths from the markdown file

### Branch Strategy

- `main` - Production branch, auto-deploys to GitHub Pages
- `develop` - Development branch (based on git status)
- Feature branches - Create from develop, PR back to develop
- Only maintainer pushes to main trigger deployment

---

**Last Updated:** 2026-01-26
**Claude Code Version:** 2026.01
**Maintained By:** cosckoya + Claude Code
