# AGENTS.md

Single source of truth for this Zensical documentation site — all project state, conventions, commands, and agent instructions.

---

## Project

- **Type:** Zensical documentation site hosted at https://cosckoya.github.io
- **Deploy:** GitHub Pages, auto-deploys `main` branch via GitHub Actions (`.github/workflows/gh-pages.yml`)
- **Python:** 3.12 only — pinned in `pyproject.toml` and CI workflow
- **Theme variant:** `modern` — auto light/dark mode (Lucide toggle: `lucide/sun-moon`), scheme: `default`/`slate`, primary: `deep purple`/`purple`, accent: `teal`/`lime`
- **Icon system:** All icons unified under Lucide (`:lucide-...:`) for inline content. Brand icons in theme config use `simple/` (github, gitlab, x, devdotto, docker) or `material/linkedin` where no Simple/Lucide SVG exists in the theme bundle.
- **Zero FontAwesome references** in the entire repository — fully migrated.

---

## Critical Commands

```bash
source venv/bin/activate          # Always activate first
zensical serve                    # Dev server with live reload at localhost:8000
zensical build --strict           # Build with strict mode (warnings = errors)
make validate                     # Same as zensical build --strict
make build                        # Build without strict mode
make clean                        # Remove site/ directory
make lint                         # ruff, codespell, yamllint (non-blocking)
make health                       # Run health check script (placeholders, orphans, Vibe Checks)
make venv                         # Create Python virtual environment
make deps                         # Install zensical in venv
```

---

## Repository Structure

```
.
├── AGENTS.md                 # ← You are here. Single source of truth.
├── CLAUDE.md                 # DELETED — fully consolidated into this file.
├── CONTRIBUTING.md           # Human contributor guide
├── zensical.toml                # Full Zensical config (theme, nav, extensions, plugins)
├── requirements.txt          # zensical pinned with rationale comments
├── pyproject.toml            # Python 3.12 pin
├── Makefile                  # Targets: serve, build, validate, clean, lint, health
├── .yamllint.yml             # yamllint config
├── scripts/
│   └── health.py             # Documentation health check (orphans, placeholders, Vibe Checks)
├── templates/
│   ├── page.template.md      # Active template — use for all new pages
│   ├── tool-reference.template.md  # DEPRECATED — removal 2026-09-01
│   ├── tech-reference.template.md  # DEPRECATED — removal 2026-09-01
│   └── README.md             # Template documentation and placeholder reference
└── docs/
    ├── index.md              # Home page
    ├── showcase.md           # Capabilities overview
    ├── toolbox/              # Terminal tools: neovim, tmux, kitty, zsh, asdf
    ├── os/                   # Operating systems: linux, macos, windows
    ├── containers/           # Docker, Kubernetes, Helm, Krew, Dive, Popeye
    ├── databases/            # PostgreSQL, dbcli, oracledb-cli
    ├── cloud/                # AWS, Azure, GCP, Terraform, Prowler, Checkov...
    ├── api/                  # GitHub REST API, Docker Hub API
    ├── code/                 # Python, Go, Gitleaks, pre-commit
    ├── ai/                   # AWS Bedrock, Azure AI Foundry, Vertex AI, Gemini
    ├── 1337/                 # Security/penetration testing (10 guides)
    └── awesome/              # Curated lists
```

---

## Navigation Architecture

- **System:** Explicit `nav:` section in `zensical.toml` (72 lines, 55 pages, 16 categories)
- **No `index.md` per section** — all navigation managed in `zensical.toml`
- **Structure:** 3-level hierarchy max, expandable sections
- **Recent migration:** Replaced 16 `SUMMARY.md` files with flat `nav:` in zensical.toml (2026-07-08)

**When adding new pages:**

1. Create `.md` file in the appropriate directory (`docs/<category>/`)
2. Use `templates/page.template.md` as starting point
3. Add entry to the `nav:` block in `zensical.toml` (not `SUMMARY.md` — those no longer exist)
4. Test: `make validate`

---

## Content Standards

### File Naming

`{name}.cloud.md` | Cloud platforms (AWS, Azure, GCP)
`{name}.tool.md` | Tools, CLIs, utilities (Terraform, Docker)
`{name}.service.md` | Services, APIs (GitHub REST API)
`{name}.os.md` | Operating systems (Linux, macOS, Windows)
`{name}.ai.md` | AI platforms (Bedrock, Vertex AI)
`{name}.1337.md` | Security/penetration testing
`{name}.md` | General pages (index, showcase)

### Icons

- **ALWAYS** use Lucide inline syntax: `:lucide-globe:`
- **NEVER** use plain emojis
- **NEVER** use FontAwesome (`:fontawesome-...:`) — all migrated
- Common icons:
  - `:lucide-list-check:` — Essential/basics tab
  - `:lucide-bolt:` — Common patterns tab
  - `:material-fire:` — Pro Tips & Gotchas tab
  - `:lucide-book:` — Documentation links
  - `:lucide-wrench:` — Tools/utilities
  - `:simple-github:` — GitHub links

**Theme config icons** (in `zensical.toml`):
- Admonitions: `lucide/info`, `lucide/list-check`, `lucide/lightbulb`, `lucide/circle-check`, `lucide/circle-help`, `lucide/alert-triangle`, `lucide/x-circle`, `lucide/skull`, `lucide/bug`, `lucide/flask-conical`, `lucide/text-quote`
- Tags: `lucide/cloud`, `lucide/shield`, `lucide/sparkles`, `lucide/code`, `lucide/database`, `lucide/container`, `lucide/monitor`, `lucide/wrench`, `lucide/code-2`
- Social brands: `simple/github`, `simple/gitlab`, `simple/x`, `simple/devdotto`, `material/linkedin`, `simple/docker`
- Repo: `simple/github`
- Theme toggles: `lucide/sun-moon`, `lucide/sun`, `lucide/moon`

### Page Structure

Every content page follows the 3-tab Quick Hits format:

```
# Title

Intro paragraph (2-3 cynical, practical sentences)

!!! tip "2026 Update"
    What changed recently.

---

## Quick Hits

=== ":lucide-list-check: Essential <Topic>"
    Code examples with inline annotations `# (1)!`
    **Real talk:** Practical advice as bullets

=== ":lucide-bolt: Common Patterns"
    Implementation examples
    **Why this works:** Explanation bullets

=== ":material-fire: Pro Tips & Gotchas"
    **Tips:** Expert advice
    **Gotchas:** Common mistakes

---

## Reference

- :lucide-book: [Official Docs](url)
- :simple-github: [GitHub](url)
- :material-fire: __Related Topic 1__
- :lucide-wrench: __Related Topic 2__

---

**Last Updated:** YYYY-MM-DD | **Vibe Check:** :lucide-globe: **Label** - One-sentence assessment.

**Tags:** tag1, tag2, tag3
```

### Tone

- Cynical but helpful — realistic about trade-offs
- No marketing speak, no buzzwords
- Technical but accessible to juniors
- Active voice, present tense, imperative mood

### Footer Requirements

Every content page MUST end with:
1. **Vibe Check** — `**Vibe Check:** :lucide-globe: **Label** - Description.`
2. **Last Updated** — ISO date: `**Last Updated:** YYYY-MM-DD`
3. **Tags** — At bottom of page, NOT in frontmatter: `**Tags:** tag1, tag2`

---

## Theme Configuration

Key configuration points in `zensical.toml`:

- **variant:** `modern` — Zensical modern theme
- **palette:** tri-mode (auto / light / dark) with Lucide toggles
- **features:** 24 features enabled — navigation.sections, expand, breadcrumbs, instant, search.suggest, code.copy, content.tooltips, header.autohide, etc.
- **extensions:** 19 markdown_extensions — toc (permalink), admonition, pymdownx.superfences (mermaid), pymdownx.tabbed (alternate), pymdownx.highlight, pymdownx.emoji (twemoji), attr_list, md_in_html, def_list, footnotes, magiclink, snippets, tasklist, etc.
- **custom extensions:** `zensical.extensions.glightbox` (image lightbox), `zensical.extensions.macros` (template macros)
- **validation:** `invalid_links: true`, `invalid_link_anchors: true`
- **extra_css:** `resources/css/images.css`, `resources/css/snape.css`
- **tags:** 9 tag definitions (cloud, security, ai, api, database, container, os, tool, language)

---

## Template System

- **Active template:** `templates/page.template.md` — use for ALL new pages (tools, cloud, services, OS, AI, security)
- **Deprecated templates** (removal target: 2026-09-01):
  - `templates/tool-reference.template.md`
  - `templates/tech-reference.template.md`
- **Full documentation:** `templates/README.md` — complete placeholder reference table

### Creating a New Page

1. Copy template: `cp templates/page.template.md docs/<section>/<name>.<ext>.md`
2. Replace all `{{PLACEHOLDER}}` values
3. Optionally remove unused sections (Installation, Configuration)
4. Add entry to `nav:` in `zensical.toml`
5. Validate: `make validate`

---

## Linting

```bash
ruff check docs/
codespell docs/ --skip='*.png,*.jpg,*.svg'
# Config is TOML format (no yamllint needed)
```

---

## Health Check

Run `make health` (or `source venv/bin/activate && python3 scripts/health.py`):

Checks for:
- **Orphaned files** — `.md` files in `docs/` not referenced in `nav:` in `zensical.toml`
- **Missing pages** — `nav:` entries pointing to non-existent files
- **Placeholder leaks** — `{{PLACEHOLDER}}` still present in content
- **Vibe Check compliance** — every content page has a Vibe Check footer
- **Tag presence** — every content page has tags

---

## CI/CD Pipeline

Workflow: `.github/workflows/gh-pages.yml`

- **Trigger:** Push to `main` branch only
- **Steps:**

```
1. Lint (ruff + codespell + yamllint)
2. Setup Python 3.12
3. pip install zensical
4. python scripts/health.py --ci
5. zensical build --clean --strict
6. Upload Pages Artifact
7. Deploy to GitHub Pages
```

- **Deployment URL:** https://cosckoya.github.io
- **Page build time:** ~18s (lint: 12s, build: 4s, deploy: 8s)

---

## Recent Modernisation (2026-07-08)

| Change | Details |
|--------|---------|
| **Theme variant** | Switched to `modern` (was default) — Lucide icons, auto light/dark, new features |
| **Navigation** | Replaced 16 `SUMMARY.md` files with explicit `nav:` in `zensical.toml` (72 lines, 55 pages) |
| **Icon unification** | 785 FontAwesome → Lucide replacements across 63 files (55 content pages + 8 meta/template files) |
| **Theme icon fixes** | 9 admonition icons mapped to existing Lucide SVGs; brand icons migrated to `simple/` set |
| **Health check** | Updated to parse `nav:` instead of `SUMMARY.md` |
| **Build fix** | yamllint warning fixed (missing document start `---`) |
| **MkDocs-isms cleaned** | All MkDocs-specific references removed from zensical.toml, index.md, showcase.md, AGENTS.md |
| **Disco search** | Enabled Zensical's built-in Disco search (no external search plugin) |
| **Link validation** | Enabled `invalid_links` + `invalid_link_anchors` |
| **Tags with icons** | 9 tag definitions with Lucide icons |
| **GLightbox** | Image lightbox via `zensical.extensions.glightbox` |
| **Macros** | Template macros via `zensical.extensions.macros` |

---

## Configuration Files

| File | Purpose |
|------|---------|
| `zensical.toml` | Theme, navigation, extensions, validation — primary config |
| `opencode.json` | OpenCode permissions, model config (qwen2.5-coder:7b local), skills |
| `.opencodeignore` | Exclusion patterns for OpenCode context |
| `pyproject.toml` | Python 3.12 constraint |
| `requirements.txt` | `zensical` pinned with rationale comments |
| `Makefile` | Targets: serve, build, validate, clean, lint, health, venv, deps |
| `.yamllint.yml` | yamllint rules (legacy, no longer used) |
| `scripts/health.py` | Documentation health checker |

---

## OpenCode Configuration

- **`opencode.json`** — Project-level OpenCode config (permissions, skills, instructions)
- **`.opencodeignore`** — Exclusion patterns for OpenCode context
- **Global config:** `~/.config/opencode/opencode.json` (symlinked to `.agentic/opencode.json`)
- **Global skills:** `/home/cosckoya/.agentic/skills/`

---

## Global Skills

Located at `/home/cosckoya/.agentic/skills/`:

| Skill | Purpose |
|-------|---------|
| `mkdocs-material` | Zensical theme config, navigation, icons, templates (compat) |
| `color-theory` | Color schemes, WCAG compliance, palette analysis |
| `markdown-redacter` | Document generation for the `.agentic` ecosystem |
| `janitor` | Documentation audits, health scores, structure validation |
| `github-expert` | GitHub administration, Actions, security, API |
| `python-architect` | Python architecture reviews, DRY/KISS/SOLID |
| `find-skills` | Skill discovery and installation |
| `skill-development` | Skill creation best practices |
| `agent-development` | Agent creation and system prompts |
| `claude-code-expert` | Claude Code skills compliance review |
| `token-optimizer` | Token consumption auditing |
| `report-forge` | JSON data → rendered reports |
| `flutter-expert` | Flutter/Material Design 3 reviews |
| `github-actions-docs` | Grounded GitHub Actions documentation |

## Installed Skills

At `~/.agents/skills/`:
- `github-actions-docs` — Grounded GitHub Actions documentation, workflow YAML, runners, CI/CD

---

## Agents

This project has dedicated agents for documentation tasks:

- **`@mcdoc`** — Documentation Publisher. Invoke for content creation, health audits, CI/CD management, theme configuration, and deployment. Knows all project conventions (Vibe Check, Lucide icons, nav: architecture, template system).

- **`@atticus`** — Documentation Architect. Invoke for content audits, style enforcement, Diátaxis compliance, and documentation health assessments across any Markdown project.

- **`@zendoc`** — Zensical + GitHub Pages Expert. Project-agnostic Zensical specialist — config audits, design reviews, CI/CD health. Reads the actual config first, always researches current Zensical docs before recommending.

---

## See Also

- **`zensical.toml`** — Full theme, plugin, extension configuration (265 lines)
- **`templates/README.md`** — Template placeholder reference
- **`CONTRIBUTING.md`** — Human contributor guide
- **`scripts/health.py`** — Documentation health checker source
