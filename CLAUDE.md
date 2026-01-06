# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a personal tech documentation site built with MkDocs Material. The site is hosted on GitHub Pages at <https://cosckoya.github.io> and contains technical notes and guides on topics like SysAdmin, Cloud, Containers, Code, Monitoring, and CyberSecurity.

## Development Commands

### Python Environment

This project requires **Python 3.12+**. It's recommended to use a virtual environment:

```bash
# Create and activate virtual environment
python3 -m venv venv
source venv/bin/activate  # On Linux/Mac
# or
venv\Scripts\activate  # On Windows

# Install dependencies
pip install -r requirements.txt
```

Alternatively, use the provided Makefile:

```bash
make dev  # Setup complete development environment
```

### Local Development

```bash
# Serve the site locally with live reload
mkdocs serve
# or
make serve

# Build the site (output to site/ directory by default)
mkdocs build

# Build with strict mode (fails on warnings)
mkdocs build --strict
# or
make build
```

### Other Makefile Commands

```bash
make help     # Show all available commands
make test     # Run pre-commit hooks and build
make clean    # Clean build artifacts
make update   # Update dependencies
```

### Pre-commit Hooks

```bash
# Install pre-commit hooks
pre-commit install

# Run hooks manually
pre-commit run --all-files
```

The pre-commit hooks will:

- Check for merge conflicts, trailing whitespace, and end-of-file issues
- Check for large files (max 500KB) and private keys
- Validate YAML and JSON files
- Lint markdown files with markdownlint (auto-fix enabled)
- Build the MkDocs site in strict mode to catch errors before commit

### Deployment

Deployment to GitHub Pages is automated via GitHub Actions when pushing to the `main` branch. The workflow:

1. Installs Python dependencies from requirements.txt
2. Runs `mkdocs gh-deploy --force` to build and publish to the gh-pages branch

Manual deployment: `mkdocs gh-deploy --force`

## Architecture

### Site Configuration (mkdocs.yml)

- **Theme**: Material for MkDocs with slate color scheme and deep purple/teal accents
- **Navigation**: Uses literate-nav plugin with SUMMARY.md files for navigation structure
- **Plugins**: search, same-dir (allows index.md in subdirectories), tags, literate-nav, minify
- **Minification**: Enabled for HTML, JS, and CSS to optimize performance
- **SEO**: Generator attribution disabled, sitemap.xml auto-generated, robots.txt configured
- **Markdown Extensions**: Admonitions, tabbed content, code highlighting, magic links, and more

### Content Structure (docs/)

The documentation is organized into topic-based directories:

- `docs/index.md` - Main landing page
- `docs/SUMMARY.md` - Top-level navigation structure
- `docs/sysadmin/` - System administration content
- `docs/cloud/` - Cloud platform guides
- `docs/containers/` - Container technology documentation
- `docs/code/` - Programming snippets and examples (has its own SUMMARY.md)
- `docs/monitoring/` - Monitoring and observability
- `docs/security/` - Cybersecurity topics
- `docs/resources/` - Images, stylesheets, and other assets

### Navigation Pattern

The site uses the literate-nav plugin which reads `SUMMARY.md` files to build navigation. Subdirectories like `code/` can have their own SUMMARY.md for nested navigation structures.

### Branches

- `main` - Production branch that triggers GitHub Pages deployment
- `develop` - Development branch (current)

## Quality and Best Practices

### Code Quality Tools

- **EditorConfig**: Configured for consistent formatting (.editorconfig)
- **Markdownlint**: Enforces markdown standards with auto-fix (.markdownlint.json)
- **Dependabot**: Automated dependency updates for Python packages and GitHub Actions

### CI/CD Pipeline

The GitHub Actions workflow (.github/workflows/gh-pages.yml):

- Caches pip dependencies for faster builds
- Builds site in strict mode to catch warnings
- Deploys automatically to GitHub Pages on push to main branch

### Dependency Management

- Dependencies are pinned in requirements.txt for reproducibility
- Dependabot creates monthly PRs for updates
- Pre-commit hooks validate the environment before commits

## Content Guidelines

When adding or modifying documentation:

- Place markdown files in the appropriate topical directory under docs/
- Update the relevant SUMMARY.md file to include new pages in navigation
- Use Material for MkDocs extensions for better formatting (admonitions, tabs, code blocks)
- Images and assets go in docs/resources/ (max 500KB per file)
- Add descriptive alt text to images for accessibility
- Test locally with `mkdocs serve` before committing
- Pre-commit hooks will validate the build, so fix any warnings/errors they report
- Follow the Contributing Guide (CONTRIBUTING.md) for detailed workflow
