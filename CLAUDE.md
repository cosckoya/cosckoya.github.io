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

# Build the site (output to site/ directory)
mkdocs build

# Build with strict mode (fails on warnings, recommended)
mkdocs build --strict
# or
make build

# Note: Pre-commit hooks build to test/ directory for validation
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

1. Caches pip and MkDocs Material dependencies for faster builds
2. Installs Python dependencies from requirements.txt
3. Builds the site with `mkdocs build --strict` to catch any errors
4. Runs `mkdocs gh-deploy --force` to publish to the gh-pages branch

Manual deployment: `mkdocs gh-deploy --force` or `make deploy`

**Important**: Always test locally with `mkdocs serve` and ensure pre-commit hooks pass before pushing to main.

## Architecture

### Site Configuration (mkdocs.yml)

- **Theme**: Material for MkDocs with slate color scheme and deep purple/teal accents
- **Navigation**: Uses literate-nav plugin with SUMMARY.md files for navigation structure
- **Plugins**: search, same-dir (allows index.md in subdirectories), tags, literate-nav, minify
- **Minification**: Enabled for HTML, JS, and CSS to optimize performance
- **SEO**: Generator attribution disabled, sitemap.xml auto-generated, robots.txt configured
- **Markdown Extensions**: Admonitions, tabbed content, code highlighting, magic links, and more
- **Features**: Content tabs linking, code copy buttons enabled in theme configuration

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

The site uses the literate-nav plugin which reads `SUMMARY.md` files to build navigation. Each SUMMARY.md uses bullet lists with markdown links:

```markdown
* [Page Title](path/to/file.md)
* [Section Title](section/)
  * [Nested Page](nested.md)
```

**IMPORTANT CONVENTIONS:**

1. **SUMMARY.md is MANDATORY**: Every first-level content directory MUST have a `SUMMARY.md` file
   - ✅ Required: `sysadmin/`, `cloud/`, `containers/`, `code/`, `monitoring/`, `security/`
   - ✅ Exception: Only `resources/` may omit SUMMARY.md (it contains assets, not content)

2. **Consistent Linking in Top-Level SUMMARY.md**: The `/docs/SUMMARY.md` file should link to directories, not directly to `index.md` files:
   - ✅ Correct: `* [SysAdmin](sysadmin/)`
   - ❌ Incorrect: `* [SysAdmin](sysadmin/index.md)`
   - This allows literate-nav to automatically find and use the section's SUMMARY.md

3. **Section SUMMARY.md Structure**: Each section's SUMMARY.md should start with its overview:

   ```markdown
   * [Section Name Overview](index.md)
   * [Subtopic 1](subtopic1.md)
   * [Subtopic 2](subtopic2.md)
   ```

4. **Nested Navigation**: Subdirectories can have their own SUMMARY.md for hierarchical navigation. The top-level `docs/SUMMARY.md` controls the main navigation menu.

**Why these conventions matter:**

- Predictable structure for contributors
- Scalability as content grows
- Consistent behavior across all sections
- Clear pattern for adding new content

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

### Available Markdown Features

Material for MkDocs extensions enabled in this project:

- **Admonitions**: `!!! note`, `!!! warning`, `!!! tip`, `!!! danger`, etc. (collapsible with `???`)
- **Code blocks**: Syntax highlighting with language specification, inline code with `pymdownx.inlinehilite`
- **Tabbed content**: Use `=== "Tab Title"` for content tabs that can link across the site
- **Tables**: Standard markdown tables with alignment
- **Definition lists**: For glossary-style content
- **Magic links**: Auto-linking for URLs, email addresses
- **Snippets**: Include external code files in documentation (base path: docs/)
- **Permalinks**: Automatic heading anchors for direct linking
