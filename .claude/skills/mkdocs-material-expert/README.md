# MkDocs Material Expert

**Purpose:** UX/UI expert for Material for MkDocs theme - navigation, icons (loves octicons!), plugins, performance, accessibility (WCAG 2.1 AA), and template-based documentation generation.

**Version:** 2026.02 | **Status:** Active | **Updated:** January 31, 2026

---

## Quick Start

```bash
/mkdocs-material-expert [command]
```

### Common Commands

```bash
# Audit and suggest improvements
/mkdocs-material-expert audit

# Generate documentation from templates
/mkdocs-material-expert generate docs for kubectl
/mkdocs-material-expert generate docs for Azure

# Theme enhancements
/mkdocs-material-expert add octicons
/mkdocs-material-expert improve navigation
/mkdocs-material-expert optimize performance
/mkdocs-material-expert enable social cards
```

---

## Core Capabilities

### Theme Configuration
- Color schemes (light/dark with toggles)
- Icon systems (Octicons, FontAwesome, Material)
- Custom CSS and typography
- Accessibility (WCAG 2.1 AA)

### UX/UI Features
- Navigation (breadcrumbs, instant loading, sections, tracking)
- Search (suggestions, highlighting, sharing)
- Content (code copy/annotate, tabs, tooltips)
- Performance (minification, caching, lazy loading)

### Plugins
- Search (optimized)
- Tags (categorization)
- Social (OG images)
- Git committers (attribution)
- Minify (HTML/CSS/JS)
- Blog, RSS, Offline, Privacy

### Template Generation (NEW)
Generate consistent documentation from project templates:
- **tech-reference.template.md** - Cloud platforms, technologies (AWS, Azure, Kubernetes)
- **tool-reference.template.md** - CLI tools, utilities (Terraform, Docker, kubectl)

**Features:**
- Automated placeholder filling
- Enforces octicons (no plain emojis)
- Validates cynical/realistic tone
- Updates navigation automatically
- Tests with strict build validation

---

## Development Philosophies

**KISS (Keep It Simple)**
- Use built-in features before custom CSS
- One feature at a time
- Minimal configuration

**DRY (Don't Repeat Yourself)**
- Centralize CSS in single file
- Use templates for consistency
- Reuse components via includes

**Clean Code**
- Group related features with comments
- Consistent naming (`.cloud.md`, `.tool.md`, `.service.md`)
- Remove unused config

---

## Testing

```bash
# Local preview
make serve

# Validate build (strict mode)
make build

# Full validation
make test
```

### Checklist
- [ ] `make serve` works
- [ ] `make build` passes strict mode
- [ ] Navigation links resolve
- [ ] Search returns results
- [ ] Icons display correctly
- [ ] Mobile responsive
- [ ] Keyboard accessible
- [ ] Fast loading (<3s)

---

## Configuration Examples

### Minimal (Phase 1)

```yaml
theme:
  features:
    - navigation.breadcrumbs
    - search.suggest
    - search.highlight
    - content.code.copy
```

### Recommended (Phase 2)

```yaml
theme:
  features:
    - navigation.sections
    - navigation.expand
    - navigation.instant.loading
    - navigation.tracking
    - navigation.top
    - content.code.copy
    - content.code.annotate
    - content.tabs.link
    - search.suggest
    - search.highlight
    - toc.follow

plugins:
  - search
  - tags
  - minify:
      minify_html: true
      minify_css: true
      minify_js: true
```

### Advanced (Phase 3)
Add social cards, git-committers, blog, RSS, offline support.

---

## Integration

**Works with:**
- `/devops-github-expert` - CI/CD for Pages deployment
- `/technical-writer` - Formal documentation standards
- `/claude-code-expert` - Skill architecture

**Respects:**
- SUMMARY.md literate navigation
- Strict build mode
- Pre-commit hooks
- Project templates

---

## Template Generation Workflow

**Example: Generate kubectl documentation**

1. **Invoke:**
   ```
   /mkdocs-material-expert generate docs for kubectl
   ```

2. **Skill gathers information** (via AskUserQuestion):
   - Tool name, description, tags
   - Essential commands
   - Common patterns
   - Installation steps
   - Pro tips and gotchas

3. **Fills template placeholders:**
   - Replaces all `{{PLACEHOLDER}}` values
   - Enforces octicons (`:octicons-name-16:`)
   - Applies cynical/realistic tone
   - Sets current date

4. **Writes and validates:**
   - Writes to `docs/cloud/tools/kubectl.tool.md`
   - Updates `docs/cloud/tools/SUMMARY.md`
   - Runs `mkdocs build --strict`

---

## Troubleshooting

**Icons not showing:**
```yaml
markdown_extensions:
  - pymdownx.emoji:
      emoji_index: !!python/name:material.extensions.emoji.twemoji
      emoji_generator: !!python/name:material.extensions.emoji.to_svg
```

**Build fails:**
```bash
make build  # Review errors
# Check mkdocs.yml syntax
# Validate plugin versions
# Check for broken links
```

**Plugin conflicts:**
```bash
# Check plugin order in mkdocs.yml
# Some plugins must run before others
# Example: search before minify
```

---

## Resources

- [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)
- [MkDocs Documentation](https://www.mkdocs.org/)
- [Octicons](https://primer.style/foundations/icons)
- [WCAG Guidelines](https://www.w3.org/WAI/WCAG21/quickref/)
- [PyMdown Extensions](https://facelessuser.github.io/pymdown-extensions/)

---

## Dependencies

```txt
# Core
mkdocs>=1.5.3
mkdocs-material>=9.7.0

# Essential Plugins
mkdocs-literate-nav>=0.6.1
mkdocs-minify-plugin>=0.8.0

# Optional Plugins
mkdocs-git-committers-plugin-2>=0.2.2
mkdocs-rss-plugin>=1.12.0

# Markdown
pymdown-extensions>=10.5
```

---

**Maintained By:** cosckoya + Claude Code
**Philosophy:** DRY, KISS, Clean Code
**Communication:** Professional (no emojis in responses)
**Content:** ALWAYS use octicons in site content (`:octicons-name-16:`)
