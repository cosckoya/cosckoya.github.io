# AGENTS.md

Instructions for OpenCode when working on this MkDocs Material documentation site.

## Project

- **Type:** MkDocs Material documentation site hosted at https://cosckoya.github.io
- **Deploy:** GitHub Pages, auto-deploys main branch via GitHub Actions
- **Python:** 3.12 only (see pyproject.toml and CI workflow)

## Configuration

- **`opencode.json`** — Project-level OpenCode config (permissions, skills, instructions)
- **`.opencodeignore`** — Exclusion patterns for OpenCode context
- **Global config:** `~/.config/opencode/opencode.json` (symlinked to `.agentic/opencode.json`)
- **Global skills:** `/home/cosckoya/.agentic/skills/`

## Critical Commands

```bash
source venv/bin/activate
mkdocs serve              # Live-reload at localhost:8000
mkdocs build --strict    # Strict mode (warnings = errors)
make validate             # Equivalent: mkdocs build --strict
make lint                 # ruff, codespell, yamllint (non-blocking)
```

## Plugin Pinning (CRITICAL)

**DO NOT update** `mkdocs-same-dir==0.1.3`, `mkdocs-section-index==0.3.10`, `mkdocs-literate-nav==0.6.2`. Newer versions inject ProperDocs promotional warnings. See requirements.txt.

## Navigation Architecture

- **System:** `mkdocs-literate-nav` with `SUMMARY.md` files
- **Structure:** 3-level hierarchy max, expandable sections
- **No index.md per section** — managed via SUMMARY.md entries

When adding new sections:
1. Create `.md` file in appropriate category
2. Add entry to nearest `SUMMARY.md`
3. Test: `mkdocs serve` then `mkdocs build --strict`

## Content Standards

**File naming:** `{name}.cloud.md`, `{name}.tool.md`, `{name}.service.md`, `{name}.os.md`, `{name}.ai.md`, `{name}.1337.md`, `{name}.md`

**Icons:** Use FontAwesome (`:fontawesome-solid-...:`), never plain emojis.

**Tags:** At bottom of file, not in frontmatter: `**Tags:** tag1, tag2`

**Structure:** Essential → Common Patterns → Pro Tips & Gotchas. Tone: cynical, practical.

**Footer:** Every content page must end with: `**Last Updated:** <date> | **Vibe Check:** <icon> **<label>** - <description>` followed by `**Tags:** ...`

## Template System

Use `docs/templates/page.template.md` when creating new pages. It supports both tool and tech-reference content with optional sections. The old `tech-reference.template.md` and `tool-reference.template.md` are deprecated.

When generating a new page:
1. Copy `page.template.md` to the target directory
2. Replace all `{{PLACEHOLDER}}` values
3. Optionally remove unused sections (Installation, Configuration)
4. Add entry to nearest `SUMMARY.md`
5. Validate with `make validate`

## Linting

```bash
ruff check docs/
codespell docs/ --skip='*.png,*.jpg,*.svg'
yamllint -c .yamllint.yml mkdocs.yml
```

## CI/CD Pipeline

Workflow: `.github/workflows/gh-pages.yml`
- **Trigger:** Push to `main`
- **Flow:** lint → `mkdocs build --strict` → `mkdocs gh-deploy --force`

## Skills

Global skills at `/home/cosckoya/.agentic/skills/`:
- `mkdocs-material` — Theme config, navigation, icons, templates
- `color-theory` — Color schemes, WCAG compliance
- `markdown-redacter` — Document generation
- `janitor` — Documentation audits and health scores
- `github-expert` — GitHub administration, Actions, security
- `python-architect` — Python architecture reviews

Installed skills at `~/.agents/skills/`:
- `github-actions-docs` — Grounded GitHub Actions documentation, workflow YAML, runners, CI/CD

## Agents

This project has a dedicated OpenCode agent for documentation tasks:

- **`@mcdoc`** — MkDocs Material Documentation Publisher. Invoke for content creation, health audits, CI/CD management, theme configuration, and deployment. Knows this project's conventions (templates, Vibe Check, literate-nav, plugin pinning).

## See Also

- **mkdocs.yml** — Full theme, plugin, extension configuration
- **requirements.txt** — Dependency versions with rationale comments
- **opencode.json** — Project-level OpenCode permissions and model config
