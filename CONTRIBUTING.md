# Contributing

Guide for humans adding or editing documentation on this site.

## Quick Start

```bash
git checkout develop
source venv/bin/activate
make serve    # Live preview at localhost:8000
```

## Creating a New Page

### 1. Choose the right template

```bash
cp docs/templates/page.template.md docs/<section>/<name>.<ext>.md
```

### 2. Naming conventions

| Type | Extension | Example |
|------|-----------|---------|
| Cloud platform | `.cloud.md` | `aws.cloud.md` |
| Tool / CLI | `.tool.md` | `terraform.tool.md` |
| Service / API | `.service.md` | `github-rest-api.service.md` |
| Operating System | `.os.md` | `linux.os.md` |
| AI Platform | `.ai.md` | `vertex-ai.ai.md` |
| Security | `.1337.md` | `offensive-security.1337.md` |

### 3. Replace all `{{PLACEHOLDER}}` values

Each page has these required sections:

- **YAML frontmatter** — `title`, `description`, `tags: []` (array format)
- **Intro** — 2-3 cynical, practical sentences
- **Quick Hits** — 3 tabs: Essential / Common Patterns / Pro Tips & Gotchas
- **Optional sections** — Installation, Configuration, Architecture (as needed)
- **Reference** — Links to docs, GitHub, related content
- **Footer** — `Last Updated` + `Vibe Check` + `Tags`

### 4. Add to navigation

Add an entry to the nearest `SUMMARY.md`:

```markdown
- [Page Title](page-name.ext.md)
```

For new sections, create a `SUMMARY.md` in the section directory.

### 5. Validate

```bash
make validate          # mkdocs build --strict
make lint              # ruff + codespell + yamllint
```

## Editing an Existing Page

- Respect the 3-tab Quick Hits structure
- Keep the cynical/practical tone
- Update `Last Updated` date
- Run `make validate` before committing

## Style Guide

### Tone
- Cynical but helpful — realistic about trade-offs
- No marketing speak, no buzzwords
- Technical but accessible to juniors

### Icons
- Use FontAwesome: `:fontawesome-solid-...:`
- Never plain emojis
- Common: `:fontawesome-solid-list-check:` / `:fontawesome-solid-bolt:` / `:fontawesome-solid-fire:`

### Code
- Include inline annotations `# (1)!`
- Language tag on every block
- Realistic examples, not "hello world"

### Vibe Check
Every page ends with a Vibe Check in the footer:

```
**Last Updated:** 2026-06-01 | **Vibe Check:** :fontawesome-solid-fire: **Short Label** - One-sentence assessment.
```

## Validation Checklist

- [ ] All `{{PLACEHOLDER}}` replaced
- [ ] FontAwesome icons only (no emojis)
- [ ] Code blocks have language
- [ ] Vibe Check in footer
- [ ] Tags at bottom
- [ ] Added to SUMMARY.md
- [ ] `make validate` passes
- [ ] `make lint` passes

## Branch & Commit

```bash
git checkout -b feat/my-new-page
# ... make changes ...
git add docs/<section>/<file>.md
git commit -m "feat: add <topic> reference page"
git push origin feat/my-new-page
```

Then open a PR against `develop` using conventional commits: `feat:`, `fix:`, `docs:`, `refactor:`, `chore:`.

## Questions?

Open an issue or ask in the repo discussions.
