# MkDocs Material Expert - Quick Start Guide

**Version:** 2026.01 | **Created:** January 26, 2026

---

## 🚀 Getting Started

The MkDocs Material Expert is now available! She's a UX/UI documentation designer who loves creating beautiful, accessible documentation sites—and she **loves octicons**! :octicons-heart-16:

### Invoke the Skill

```bash
/mkdocs-material-expert [command]
```

---

## 📋 Common Tasks

### 1. Audit Your Current Setup

```
/mkdocs-material-expert audit
```

**What it does:**
- Reviews your `mkdocs.yml` configuration
- Analyzes enabled features vs. available 2026 features
- Suggests improvements with priority levels
- Estimates complexity and performance impact

---

### 2. Add Octicons Everywhere :octicons-sparkle-16:

```
/mkdocs-material-expert add octicons to admonitions
```

**Result:**
```yaml
theme:
  icon:
    admonition:
      note: octicons/info-16
      warning: octicons/alert-16
      tip: octicons/light-bulb-16
      danger: octicons/stop-16
```

---

### 3. Improve Navigation UX

```
/mkdocs-material-expert improve navigation
```

**Enables:**
- Breadcrumb trails
- Instant loading (SPA-like)
- URL tracking on scroll
- "Back to top" button
- Section indexes

---

### 4. Enable Social Cards (OG Images)

```
/mkdocs-material-expert enable social cards
```

**Result:**
- Auto-generated social media preview images
- Beautiful OpenGraph cards for Twitter/LinkedIn
- Custom layouts with your branding

---

### 5. Add Dark Mode Toggle

```
/mkdocs-material-expert add dark mode toggle
```

**Result:**
```yaml
theme:
  palette:
    # Light mode
    - scheme: default
      toggle:
        icon: material/lightbulb-outline
        name: Switch to dark mode

    # Dark mode
    - scheme: slate
      toggle:
        icon: material/lightbulb
        name: Switch to light mode
```

---

### 6. Optimize Performance ⚡

```
/mkdocs-material-expert optimize performance
```

**Actions:**
- Enable minification (HTML/CSS/JS)
- Configure caching
- Set up lazy loading
- Measure improvements
- Report metrics

---

## 🎨 Feature Categories

### Navigation
- Breadcrumbs
- Instant loading
- Section indexes
- Tabs
- Tracking

### Search
- Auto-suggestions
- Highlighting
- Share results
- Stemming

### Content
- Code copy/select/annotate
- Tabs with persistence
- Tooltips
- Annotations

### Visual
- Octicons :octicons-heart-16:
- Custom colors
- Typography
- Dark mode toggle

### Plugins
- Social cards
- Git committers
- Tags
- Blog
- RSS
- Offline
- Privacy

---

## 💡 Pro Tips

### 1. Start Small
Add one feature at a time and test with `make serve`

### 2. Use Octicons
```markdown
:octicons-heart-16: User loves these!
:octicons-star-fill-24: Featured
:octicons-check-16: Complete
```

### 3. Test Accessibility
- Use keyboard navigation
- Check color contrast
- Test with screen reader

### 4. Measure Performance
```bash
# Before changes
time make build

# After changes
time make build

# Compare times and site size
```

### 5. Progressive Enhancement
- **Phase 1**: Navigation + Search improvements
- **Phase 2**: Social cards + Git committers
- **Phase 3**: Blog + RSS + Offline

---

## 📖 Quick Reference

### Essential Commands

```bash
make serve              # Local preview
make build              # Validate (strict mode)
make test               # Full validation
```

### Configuration File

```
mkdocs.yml              # Main configuration
```

### Skill Files

```
.claude/skills/mkdocs-material-expert/
├── SKILL.md            # Full skill documentation
├── README.md           # Overview and examples
└── QUICKSTART.md       # This file!
```

---

## 🎯 Example Workflow

### Scenario: Enhance Your Documentation Site

1. **Audit current setup**
   ```
   /mkdocs-material-expert audit
   ```

2. **Implement Phase 1** (Low complexity)
   ```
   /mkdocs-material-expert improve navigation
   /mkdocs-material-expert add search suggestions
   ```

3. **Test locally**
   ```bash
   make serve
   # Visit localhost:8000
   ```

4. **Implement Phase 2** (Medium complexity)
   ```
   /mkdocs-material-expert enable social cards
   /mkdocs-material-expert add octicons
   ```

5. **Validate build**
   ```bash
   make build
   ```

6. **Commit changes**
   ```bash
   git add mkdocs.yml
   git commit -m "feat: enhance MkDocs Material theme"
   ```

---

## 🆘 Troubleshooting

### "Icon not showing"

Check pymdownx.emoji configuration:
```yaml
markdown_extensions:
  - pymdownx.emoji:
      emoji_index: !!python/name:material.extensions.emoji.twemoji
      emoji_generator: !!python/name:material.extensions.emoji.to_svg
```

### "Build fails in strict mode"

```bash
make build
# Review error output
# Check for broken links
# Validate mkdocs.yml syntax
```

### "Feature not working"

1. Check Material version: `pip show mkdocs-material`
2. Verify feature flag syntax
3. Test with `make serve`
4. Check browser console for errors

---

## 📚 Learn More

- **Full Documentation**: `.claude/skills/mkdocs-material-expert/SKILL.md`
- **Examples**: `.claude/skills/mkdocs-material-expert/README.md`
- **Material Docs**: https://squidfunk.github.io/mkdocs-material/

---

## 🎉 Next Steps

1. Run an audit to see what's possible
2. Pick 2-3 quick wins from Phase 1
3. Test locally with `make serve`
4. Gradually add advanced features

**Remember:** Beautiful documentation is **functional art**! :octicons-paintbrush-16:

---

**Created with** :octicons-heart-fill-16: **by the MkDocs Material Expert**
**Version:** 2026.01
