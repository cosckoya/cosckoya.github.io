# MkDocs Material Expert Skill

**Version:** 2026.01
**Status:** ✅ Active
**Created:** January 26, 2026

---

## Overview

A comprehensive Claude Code skill for MkDocs Material theme expertise. She's a UX/UI documentation designer who specializes in creating beautiful, accessible, and performant documentation sites.

### Key Features

- ✨ **Material Theme Mastery** - Colors, typography, icons, custom CSS
- 🎨 **Icon Systems** - Octicons, FontAwesome, Material Design Icons
- 🚀 **UX/UI Optimization** - Navigation, search, breadcrumbs, social cards
- 🔌 **Plugin Ecosystem** - 10+ plugins configured and optimized
- ⚡ **Performance** - Minification, caching, lazy loading
- ♿ **Accessibility** - WCAG 2.1 AA compliance
- 🎯 **Advanced Features** - Annotations, tabs, admonitions, custom components

---

## Installation

The skill is already installed at:
```
.claude/skills/mkdocs-material-expert/SKILL.md
```

It's registered in `CLAUDE.md` and ready to use.

---

## Usage

### Basic Invocation

```
/mkdocs-material-expert [command]
```

### Common Commands

```bash
# Audit current setup
/mkdocs-material-expert audit

# Add octicons to admonitions
/mkdocs-material-expert add octicons

# Improve navigation UX
/mkdocs-material-expert improve navigation

# Enable social cards (OG images)
/mkdocs-material-expert enable social cards

# Optimize performance
/mkdocs-material-expert optimize performance

# Add dark mode toggle
/mkdocs-material-expert dark mode toggle

# Configure breadcrumbs
/mkdocs-material-expert add breadcrumbs

# Setup blog section
/mkdocs-material-expert setup blog
```

---

## Capabilities

### Theme Configuration

- Dual color scheme (light/dark) with toggles
- Custom palettes (16+ colors)
- Typography configuration
- Custom CSS variables
- Icon system integration

### Navigation Features

- Section indexes
- Breadcrumb trails
- Instant loading (SPA-like)
- URL tracking on scroll
- Expandable sections
- "Back to top" button

### Search Optimization

- Auto-suggestions
- Highlight matches
- Share search results
- Stemming and stop words
- Custom separators

### Content Features

- Code block copy/select/annotate
- Persistent tab state
- Tooltips
- Edit/view source links

### Plugins

- **Search** - Full-text with optimization
- **Tags** - Tag system with index pages
- **Social** - Auto-generated OG images
- **Git Committers** - Author attribution
- **Minify** - HTML/CSS/JS optimization
- **Offline** - Service worker support
- **Blog** - Integrated blogging platform
- **RSS** - Feed generation
- **Privacy** - GDPR compliance

### Markdown Extensions

- Admonitions (9 types)
- Code blocks with syntax highlighting
- Tabs and tabbed content
- Icons and emojis (3 icon sets)
- Custom attributes
- Details/summary
- Definition lists
- Magic links

---

## Configuration Examples

### Minimal Enhancement (Phase 1)

```yaml
theme:
  features:
    - navigation.breadcrumbs
    - search.suggest
    - search.highlight
    - content.code.select
```

### Recommended Stack (Phase 2)

```yaml
theme:
  features:
    - navigation.indexes
    - navigation.breadcrumbs
    - navigation.instant.loading
    - navigation.tracking
    - content.code.copy
    - content.code.select
    - content.code.annotate
    - content.tabs.link
    - search.suggest
    - search.highlight
    - search.share
    - toc.follow

plugins:
  - search
  - tags
  - social
  - git-committers
  - minify
```

### Advanced Setup (Phase 3)

Add blog, RSS, offline support, privacy compliance, and custom styling.

---

## Personality

The MkDocs Material Expert has a distinct personality:

- **Enthusiastic** about beautiful documentation :octicons-sparkle-16:
- **Detail-oriented** with configurations
- **Patient** when explaining features
- **Creative** in design suggestions
- **Pragmatic** about complexity trade-offs

### Favorite Things

- **Octicons** :octicons-heart-fill-16: (user's favorite!)
- Beautiful typography
- Accessible design
- Performance optimization
- Clean, semantic markup

### Communication Style

Always explains:
1. **What** the feature does
2. **Why** it's beneficial
3. **How** to implement it
4. **Trade-offs** (complexity, performance)

---

## Integration

### Works With

- `/claude-code-expert` - Skill architecture
- `documentation` rules - Content guidelines
- `git-workflow` rules - Commit processes

### Respects

- SUMMARY.md files (literate navigation)
- Strict build mode
- Pre-commit hooks
- Existing configuration

---

## Dependencies (2026)

```txt
# Core (Required)
mkdocs>=1.5.3
mkdocs-material>=9.5.0

# Plugins (Essential)
mkdocs-literate-nav>=0.6.1
mkdocs-same-dir>=0.3.0
mkdocs-minify-plugin>=0.8.0

# Plugins (Optional)
mkdocs-git-committers-plugin-2>=0.2.2
mkdocs-rss-plugin>=1.12.0
mkdocs-social-plugin>=0.2.0
mkdocs-offline-plugin>=1.0.0

# Markdown
pymdown-extensions>=10.5
```

---

## Examples

### Example 1: Add Octicons to Admonitions

**Input:**
```
/mkdocs-material-expert add octicons to admonitions
```

**Output:**
Configures mkdocs.yml with octicon icons for all admonition types (note, warning, tip, danger, etc.)

### Example 2: Enable Social Cards

**Input:**
```
/mkdocs-material-expert enable social cards
```

**Output:**
- Adds social plugin configuration
- Creates card layout directory
- Tests OG image generation
- Provides usage examples

### Example 3: Optimize Performance

**Input:**
```
/mkdocs-material-expert optimize performance
```

**Output:**
- Enables minification
- Configures caching
- Sets up lazy loading
- Measures build time improvements
- Checks site size reduction

---

## Testing

The skill includes comprehensive testing guidance:

```bash
# Local preview
make serve

# Build validation
make build

# Check accessibility
# (Manual testing with keyboard, screen reader)
```

### Testing Checklist

- [ ] `make serve` works
- [ ] `make build` passes (strict mode)
- [ ] Navigation resolves all links
- [ ] Search returns relevant results
- [ ] Icons display correctly
- [ ] Code blocks render properly
- [ ] Colors readable (contrast)
- [ ] Mobile responsive
- [ ] Keyboard accessible
- [ ] Fast loading (<3s)

---

## Performance Metrics

Typical improvements after optimization:

| Metric | Before | After | Improvement |
|--------|--------|-------|-------------|
| Build time | 5s | 3s | 40% faster |
| Site size | 15MB | 11MB | 27% smaller |
| Page load | 2.5s | 1.2s | 52% faster |
| Lighthouse | 85 | 95+ | Performance |

---

## Best Practices

1. **Test locally** - Always use `make serve` before committing
2. **Validate build** - Run `make build` (strict mode catches errors)
3. **Incremental changes** - Add one feature at a time
4. **Measure performance** - Check build time and site size
5. **Accessibility first** - WCAG 2.1 AA minimum standard
6. **Use octicons** :octicons-heart-16: - User loves them!
7. **Explain benefits** - User should understand why each feature helps

---

## Troubleshooting

### Build Fails

```bash
make build
# Review error output
# Check mkdocs.yml syntax
# Validate plugin versions
```

### Icons Not Showing

```yaml
# Verify pymdownx.emoji is configured
markdown_extensions:
  - pymdownx.emoji:
      emoji_index: !!python/name:material.extensions.emoji.twemoji
      emoji_generator: !!python/name:material.extensions.emoji.to_svg
```

### Plugin Conflicts

```bash
# Check plugin order in mkdocs.yml
# Some plugins must run before others
# Example: search before minify
```

---

## Version History

### 2026.01 (January 26, 2026)
- Initial release
- Material 9.5.x+ support
- 10+ plugin configurations
- Comprehensive icon system support
- Accessibility guidelines
- Performance optimization
- Custom CSS patterns
- Full 2026 feature set

---

## Resources

- [Material for MkDocs Docs](https://squidfunk.github.io/mkdocs-material/)
- [MkDocs Documentation](https://www.mkdocs.org/)
- [PyMdown Extensions](https://facelessuser.github.io/pymdown-extensions/)
- [Octicons](https://primer.style/foundations/icons)
- [WCAG Guidelines](https://www.w3.org/WAI/WCAG21/quickref/)

---

## Contributing

To enhance this skill:

1. Test new Material features as they're released
2. Update plugin versions and configurations
3. Add new icon sets or design patterns
4. Improve accessibility guidance
5. Optimize performance techniques
6. Document user feedback and common requests

---

## License

This skill is part of the cosckoya.github.io project.

---

**Maintained By:** MkDocs Material Expert + Human
**Last Updated:** January 26, 2026
**Version:** 2026.01

Built with :octicons-heart-fill-16: for beautiful documentation
