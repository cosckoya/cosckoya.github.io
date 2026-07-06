# CLAUDE.md

## Project

MkDocs Material documentation site at cosckoya.github.io

## Commands

- `source venv/bin/activate && mkdocs serve` — Dev server with live reload at localhost:8000
- `source venv/bin/activate && mkdocs build --strict` — Validate (warnings = errors)
- `make validate` — Same as strict build
- `make lint` — ruff + codespell + yamllint (non-blocking)
- `make health` — Run health check script

## Conventions

- FontAwesome icons only (`:fontawesome-solid-...:`), no emojis
- 3-tab Quick Hits structure (Essential / Common Patterns / Pro Tips & Gotchas)
- Vibe Check footer on every content page
- Tags at bottom of page (not in frontmatter)
- Literate-nav with SUMMARY.md files for navigation
- Templates in `docs/templates/page.template.md`
