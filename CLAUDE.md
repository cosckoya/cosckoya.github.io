# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Language Policy:** All Claude Code interactions must be conducted in English only.

Personal technical documentation site built with MkDocs Material and hosted on GitHub Pages at https://cosckoya.github.io. Focus on Cloud platforms and tools with template-based documentation generation.

## Build Commands

```bash
# Activate virtual environment (required)
source venv/bin/activate

# Local development
mkdocs serve              # Live-reload server at localhost:8000

# Build and validation
mkdocs build --strict     # Build with warnings as errors
```

**No Makefile exists** - use mkdocs commands directly.

## Architecture

### Content Structure

```
docs/
├── cloud/               # Cloud platforms (AWS) and tools (Terraform)
│   ├── aws.cloud.md
│   ├── SUMMARY.md
│   └── tools/
│       ├── terraform.tool.md
│       └── SUMMARY.md
├── templates/           # Documentation templates
│   ├── tech-reference.template.md
│   ├── tool-reference.template.md
│   └── README.md
├── index.md            # Home page
├── SUMMARY.md          # Main navigation
└── resources/
    ├── css/
    │   └── snape.css   # Custom styling
    └── img/            # Images and logos
```

### Navigation

- **Literate navigation:** Uses `mkdocs-literate-nav` plugin with `SUMMARY.md` files
- **No index.md pages:** Navigation uses `navigation.sections` + `navigation.expand`
- **3-level hierarchy maximum**
- **Relative links:** All links relative from SUMMARY.md location

### Theme Configuration

MkDocs Material 9.7.0+ with:
- **Color scheme:** Slate (deep purple/teal accents)
- **Custom CSS:** `docs/resources/css/snape.css`
- **Icons:** Octicons only (`:octicons-name-16:` syntax)
- **Features:** Instant loading, search suggestions, code copy, breadcrumbs

Key theme features in `mkdocs.yml`:
- `navigation.sections` - Expandable sections
- `navigation.expand` - Auto-expand sections
- `navigation.instant.loading` - SPA-like navigation
- `search.suggest` - Search auto-complete
- `content.code.copy` - Code copy buttons

## Development Workflow

### Adding Content

1. Create markdown file in appropriate section
2. Add entry to section's `SUMMARY.md`
3. Use octicons (`:octicons-name-16:`), never plain emojis
4. Test locally: `mkdocs serve`
5. Validate: `mkdocs build --strict`

### Template-Based Generation

Use `/mkdocs-material-expert` skill to generate documentation:

**Templates:**
- `docs/templates/tech-reference.template.md` - Cloud platforms, technologies
- `docs/templates/tool-reference.template.md` - CLI tools, utilities

**File naming:**
- Cloud platforms: `{name}.cloud.md`
- Tools: `{name}.tool.md`
- Services: `{name}.service.md`

**Workflow:**
1. Read template and placeholder docs
2. Gather information from user
3. Replace all `{{PLACEHOLDER}}` values
4. Validate (octicons, tone, completeness)
5. Write file with proper naming
6. Update SUMMARY.md navigation
7. Test with `mkdocs build --strict`

### Content Standards

**Tone:**
- Cynical, realistic, practical
- No marketing speak
- Direct and helpful
- Code-focused examples

**Formatting:**
- **ALWAYS octicons:** `:octicons-name-16:` syntax
- **NEVER plain emojis** in site content
- **Three-tab structure:** Essential → Common Patterns → Pro Tips & Gotchas
- **Code blocks:** Include inline comments, specify language
- **"Real talk" sections:** Honest practical advice
- **Tags placement:** Tags go at the BOTTOM of the page (not in frontmatter)
  - Format: `**Tags:** tag1, tag2, tag3`
  - Place after the last content section, typically after "Last Updated" line
  - Frontmatter should only contain `title` and `description`

## CI/CD Pipeline

**Deployment:** GitHub Actions `.github/workflows/gh-pages.yml`
- Triggers on push to `main` branch only
- Runs `mkdocs build --strict`
- Auto-deploys to `gh-pages` branch
- Uses Python 3.12 and pip caching

**Branch strategy:**
- `main` - Production (auto-deploys)
- `develop` - Development
- Feature branches from develop

## Available Skills

### `/mkdocs-material-expert`

UX/UI expert for Material for MkDocs. Handles theme configuration, icons (loves octicons!), navigation, plugins, performance, accessibility (WCAG 2.1 AA), and template-based documentation generation.

**Capabilities:**
- Theme configuration (colors, icons, typography, custom CSS)
- UX/UI optimization (navigation, search, breadcrumbs)
- Plugin ecosystem (search, tags, social, minify)
- Performance optimization
- Template generation from tech-reference and tool-reference templates
- Follows KISS, DRY, Clean Code philosophies

**Invocation:**
```bash
/mkdocs-material-expert [command]
/mkdocs-material-expert audit
/mkdocs-material-expert generate docs for kubectl
/mkdocs-material-expert optimize performance
```

## Configuration Files

### mkdocs.yml

Main configuration file with:
- Site metadata (name, URL, description)
- Theme configuration (Material 9.7.0+)
- Navigation plugins (literate-nav)
- Markdown extensions (admonitions, tabs, code highlighting, emoji)
- Features (instant loading, search, breadcrumbs)
- Custom CSS and logo/favicon paths

### .claudeignore

Excludes from Claude Code context:
- Build artifacts (`site/`, `.cache/`)
- Virtual environments (`venv/`)
- IDE files (`.vscode/`, `.idea/`)
- Media files (images, videos)
- Compiled/minified files

## Important Notes

### Strict Mode Enforcement

All builds use `mkdocs build --strict`:
- Warnings treated as errors
- Broken links cause build failure
- Missing navigation causes failure
- Invalid markdown extensions cause failure

This ensures documentation quality.

### Virtual Environment

Python virtual environment in `venv/` directory. **Always activate before mkdocs commands:**
```bash
source venv/bin/activate
```

### Octicons Requirement

**Critical:** Site content must use octicons, never plain emojis.
- ✅ Correct: `:octicons-heart-16:`
- ❌ Wrong: ❤️

Enforced by:
- `/mkdocs-material-expert` skill audits
- Content standards documentation
- Template validation workflows

---

**Last Updated:** 2026-02-02
**Claude Code Version:** 2026.02
**Maintained By:** cosckoya + Claude Code

**Skills:** 1 active skill (mkdocs-material-expert) with template generation capabilities.
