---
paths:
  - docs/**/*.md
  - mkdocs.yml
  - '**/SUMMARY.md'
---

# MkDocs Documentation Guidelines

## Navigation System

- **Navigation is controlled by SUMMARY.md files** using the `mkdocs-literate-nav` plugin
- Main navigation: `docs/SUMMARY.md`
- Section navigation: `docs/<section>/SUMMARY.md`
- Format: `- [Link Text](relative/path.md)`
- For directory links use trailing slash: `- [Section](directory/)`
- **Maximum 3-level hierarchy** enforced

## Build Requirements

- All builds use `mkdocs build --strict` flag
- **Strict mode treats warnings as errors**
- Broken links cause build failure
- Missing files in navigation cause build failure
- Test changes with `make serve` before committing
- Run `make test` for full validation (pre-commit + strict build)

## Content Structure

Six main sections (the "Six Circles of Tech Hell"):

1. **SysAdmin** - `docs/sysadmin/` - Linux, networking, storage, fundamentals
1. **Cloud** - `docs/cloud/` - AWS, Azure, GCP with sub-sections
1. **DevOps** - `docs/devops/` - Git workflows, CI/CD, GitHub Actions
1. **Container** - `docs/containerization/` - Docker, Kubernetes, Helm
1. **Hack** - `docs/hack/` - OSINT, pentesting, security research
1. **Tools** - `docs/tools/` - CLI tools, editors, utilities

Each section must have:

- `index.md` - Section landing page
- `SUMMARY.md` - Section navigation structure

## Markdown Standards

- Use relative paths from the file location
- Images in `docs/resources/img/`
- Custom CSS in `docs/resources/stylesheets/` and `docs/stylesheets/`
- Available extensions (from mkdocs.yml):
    - Admonitions: `!!! note`, `!!! warning`, `!!! tip`, `!!! info`
    - Tabbed content: `=== "Tab Name"`
    - Code blocks with syntax highlighting and copy buttons
    - Table of contents with permalinks

## Quality Enforcement

Pre-commit hooks automatically enforce:

- Markdown formatting via `mdformat`
- Spell checking via `codespell`
- YAML validation via `yamllint`

Run before committing:

```bash
make test                          # Full validation
./scripts/docmaster-tools.sh full-maintenance  # Comprehensive checks
```

## Link Integrity

Use DocMaster Tools for validation:

```bash
./scripts/docmaster-tools.sh check-links          # Verify internal links
./scripts/docmaster-tools.sh find-orphans         # Find files not in nav
./scripts/docmaster-tools.sh validate-structure   # Check directory structure
```

Exit codes: 0 = success, 1 = issues detected

## Adding New Content Workflow

1. Create markdown file in appropriate section directory
1. Add entry to the section's `SUMMARY.md` file (relative path)
1. Test with `make serve` to verify navigation works
1. Run `make test` to validate build and hooks
1. Commit changes
