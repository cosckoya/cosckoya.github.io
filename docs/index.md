---
title: Home
description: Technical documentation built with Zensical, GitHub Pages, and too much coffee
---

![!](resources/img/zelda.png#center)

# :lucide-circle-info: About This Project

Personal technical knowledge base built by engineers, for engineers. No marketing fluff, no enterprise buzzwords, just practical technical content. Documentation as code. Open source tooling. Continuous deployment. Cyberpunk aesthetics optional.

---

## :lucide-rocket: The Stack

**Built with modern tooling because legacy tech is a choice, not a requirement.**

### Core Engine

```yaml
Platform: Zensical 0.0.47 (Rust runtime)
Language: Python 3.12
Hosting: GitHub Pages (free, fast, reliable)
CI/CD: GitHub Actions (auto-deploy on push to main)
Theme: Zensical Modern (Maleficent - purple/lime, auto light/dark)
Custom CSS: Snape theme (docs/resources/css/snape.css)
```

**Why Zensical?**

- Static site generation (fast, secure, no backend)
- Markdown-native (docs live in git, version controlled)
- Built-in search (client-side, no server needed)
- Navigation that doesn't suck (literate-nav plugin)
- Mobile-responsive (actually works on phones)
- Dark mode by default (light mode for weirdos)

### Navigation Architecture

```python
# Literate Navigation (Zensical native)
# SUMMARY.md files define navigation hierarchy
# No more YAML hell in zensical.toml

docs/
├── SUMMARY.md              # Main nav
├── cloud/
│   ├── SUMMARY.md          # Cloud section nav
│   └── tools/
│       └── SUMMARY.md      # Cloud tools nav
├── 1337/
│   └── SUMMARY.md          # Cybersecurity nav
└── ...

# Benefits:
# - DRY: Navigation lives next to content
# - Scalable: Nested SUMMARY.md for subsections
# - Git-friendly: Easy to review nav changes in PRs
# - No more: "Where the hell is that page in zensical.toml?"
```

### Markdown Extensions

```python
# Code blocks with syntax highlighting
markdown_extensions = [
    "pymdownx.highlight",      # Syntax highlighting (Pygments)
    "pymdownx.superfences",    # Fenced code blocks with features
    "pymdownx.inlinehilite",   # Inline code highlighting
    "pymdownx.snippets",       # Include external files in docs

    # Admonitions (callout boxes)
    "admonition",              # !!! note, !!! warning, etc.
    "pymdownx.details",        # Collapsible admonitions (???)

    # Content tabs
    "pymdownx.tabbed",         # === "Tab 1" syntax

    # Icons and emojis
    "pymdownx.emoji",          # :lucide-heart: syntax

    # Tables and lists
    "tables",                  # GitHub-flavored tables
    "def_list",                # Definition lists
    "pymdownx.tasklist",       # - [ ] checkboxes

    # Smart symbols
    "pymdownx.smartsymbols",   # (c) → ©, --> → →

    # Mermaid diagrams
    "pymdownx.superfences",    # Mermaid in code blocks
]
```

**Features used:**

- **Inline annotations** - `# (1)!` comments explain code
- **Tabbed content** - Three-tab "Quick Hits" structure
- **Admonitions** - Tips, warnings, danger callouts
- **Code highlighting** - 100+ languages supported
- **Lucide** - Clean, consistent icon set (`:lucide-...:`)
- **Mermaid diagrams** - Architecture visualizations

### CI/CD Pipeline

```yaml
# .github/workflows/gh-pages.yml
name: Deploy to GitHub Pages

on:
  push:
    branches: [main]  # Deploy on push to main only

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - uses: actions/setup-python@v5
        with:
          python-version: 3.12
          cache: pip  # Cache pip dependencies (faster builds)

      - name: Install dependencies
        run: pip install -r requirements.txt

      - run: zensical build --clean --strict  # Warnings = errors

      - name: Upload artifact
        uses: actions/upload-pages-artifact@v5
        with:
          path: site

  deploy:
    needs: build
    permissions:
      pages: write
      id-token: write
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    steps:
      - uses: actions/deploy-pages@v5
        id: deployment
```

**Pipeline benefits:**

- Push to `main` → auto-deploy (no manual builds)
- Strict mode catches broken links (fail fast)
- Pip caching speeds up builds (30s → 15s)
- `gh-pages` branch auto-managed (no manual git pushes)
- Deploy history preserved (every commit tracked)

### Development Workflow

```bash
# Local development (live reload)
source venv/bin/activate  # Activate Python virtual environment
zensical serve            # http://localhost:8000

# Build validation (strict mode)
zensical build --strict   # Warnings treated as errors

# Branch strategy
main       # Production (auto-deploys)
develop    # Development branch
feature/*  # Feature branches from develop

# Git workflow
git checkout -b feature/new-content develop
# Make changes...
zensical serve  # Test locally
zensical build --strict  # Validate
git add . && git commit -m "feat: add new content"
git push origin feature/new-content
# Create PR to develop → merge → PR to main → auto-deploy
```

### Content Standards

**File naming conventions:**

```bash
*.cloud.md      # Cloud platforms (AWS, Azure, GCP)
*.tool.md       # Tools (Terraform, kubectl, docker)
*.service.md    # Cloud services (S3, Lambda, etc.)
*.lang.md       # Programming languages (Python, Go, Node.js)
*.1337.md       # Cybersecurity content
```

**Structure template (three-tab Quick Hits):**

```markdown
## Quick Hits

=== "Essential Syntax/Commands"
    Core concepts, syntax, commands with inline comments

=== "Common Patterns"
    Real-world patterns, workflows, integrations

=== "Pro Tips & Gotchas"
    Best practices, performance tips, common mistakes
```

**Tone guidelines:**

- **Cynical but helpful** - No marketing BS, real talk
- **Technical accuracy** - Code examples that actually work
- **2026 context** - Current tooling, no legacy recommendations
- **Practical focus** - Why it works, not just what it is
- **Inline comments** - `# (1)!` explain non-obvious code

### Performance Optimizations

```yaml
# Zensical features for speed & UX
theme:
  features:
    - navigation.instant          # SPA-like navigation
    - navigation.instant.prefetch # Prefetch on hover
    - navigation.instant.progress # Progress indicator
    - navigation.prune            # 33%+ smaller HTML
    - search.suggest              # Search autocomplete
    - search.highlight            # Search term highlighting
    - content.code.copy           # Copy code button
    - content.code.annotate       # Inline code annotations

# Built-in (no plugins needed):
#   - Disco search (blazing fast, BM25 ranking)
#   - Link validation (catches broken links at build)
#   - Tags (native categorization)
#   - Mermaid diagrams
```

**Performance metrics:**

- Build time: ~3 seconds (49 pages)
- Page load: <1 second (minified assets)
- Search: Client-side (no server latency)
- Images: WebP with lazy loading

---

## :lucide-terminal: Tech Specs

### Repository Structure

```bash
cosckoya.github.io/
├── .github/
│   └── workflows/
│       └── gh-pages.yml        # CI/CD pipeline
├── docs/
│   ├── SUMMARY.md              # Main navigation
│   ├── index.md                # Home page
│   ├── showcase.md             # Feature reference
│   ├── 1337/                   # Cybersecurity
│   ├── ai/                     # AI/ML platforms & tools
│   ├── awesome/                # Curated lists
│   ├── cloud/                  # Cloud platforms & tools
│   ├── code/                   # Programming languages & tools
│   ├── containers/             # Container tech
│   ├── databases/              # Database tools
│   ├── os/                     # Operating systems
│   ├── toolbox/                # Dev environment tools
│   ├── templates/              # Documentation templates
│   └── resources/
│       ├── css/
│       │   └── snape.css       # Custom theme
│       └── img/                # Images and logos
├── zensical.toml                  # Zensical configuration
├── requirements.txt            # Python dependencies
├── venv/                       # Virtual environment
├── CLAUDE.md                   # Claude Code instructions
└── README.md                   # Repository readme
```

### Dependencies

```text
# requirements.txt
zensical==0.0.47
codespell==2.4.2
ruff==0.15.20
yamllint==1.38.0
pre-commit==4.6.0
```

### Configuration Highlights

```yaml
# zensical.toml (key sections - Zensical modern)
site_name: It's dangerous to go alone!
site_url: https://cosckoya.github.io
repo_url: https://github.com/cosckoya/cosckoya.github.io

theme:
  variant: modern
  palette:
    # Auto mode
    - media: "(prefers-color-scheme)"
      toggle:
        icon: lucide/sun-moon
        name: Switch to system preference
    # Light mode
    - media: "(prefers-color-scheme: light)"
      scheme: default
      primary: deep purple
      accent: teal
      toggle:
        icon: lucide/sun
        name: Switch to dark mode
    # Dark mode
    - media: "(prefers-color-scheme: dark)"
      scheme: slate
      primary: purple
      accent: lime
      toggle:
        icon: lucide/moon
        name: Switch to light mode
  features:
    - navigation.sections
    - navigation.expand
    - navigation.instant
    - navigation.instant.prefetch
    - navigation.instant.progress
    - navigation.tracking
    - navigation.top
    - navigation.indexes
    - navigation.path
    - navigation.prune
    - search.suggest
    - search.highlight
    - content.code.copy
    - content.code.annotate
    - toc.follow
    - header.autohide

validation:
  invalid_links: true
  invalid_link_anchors: true

extra_css:
  - resources/css/snape.css    # Custom styling
```

---

## :lucide-code: Content Generation

### Template-Based Documentation

```bash
# Documentation templates (DRY principle)
templates/
├── README.md                    # Template usage guide
├── page.template.md             # **RECOMMENDED** - Universal template
├── tech-reference.template.md   # DEPRECATED - Use page.template.md
└── tool-reference.template.md   # DEPRECATED - Use page.template.md

# Usage: Replace {{PLACEHOLDER}} values
# Example placeholders:
{{TITLE}}                        # Technology name
{{DESCRIPTION}}                  # One-line SEO description
{{CODE_LANGUAGE}}                # Syntax highlighting
{{TAB_1_TITLE}}                  # First tab name
{{TAB_1_CODE_EXAMPLES}}          # Code examples
{{PRO_TIPS_BULLETS}}             # Expert tips
{{GOTCHAS_BULLETS}}              # Common mistakes
```

**Template philosophy:**

- **DRY** - Templates eliminate repetition across docs
- **Consistent structure** - Three-tab Quick Hits format
- **Quality gates** - Validation checklist before writing
- **Cynical tone** - "No marketing speak" enforced

### Quality Standards

**Pre-write checklist:**

- [ ] All `{{PLACEHOLDER}}` values replaced
- [ ] Lucide icons only (`:lucide-...:`), no plain emojis
- [ ] All code blocks have language specified
- [ ] "Real talk" bullets are practical and honest
- [ ] Tone is cynical/realistic (not aspirational)
- [ ] Tags at bottom of page (not in frontmatter)
- [ ] Frontmatter contains only `title` and `description`

---

## :lucide-wrench: Why This Tech Stack?

### Static Site Generation

**Pros:**

- :lucide-circle-check: Fast (pre-rendered HTML, no server-side processing)
- :lucide-circle-check: Secure (no backend, no database, no SQL injection)
- :lucide-circle-check: Scalable (CDN-friendly, handles traffic spikes)
- :lucide-circle-check: Free hosting (GitHub Pages, Cloudflare Pages, Vercel)
- :lucide-circle-check: Version controlled (docs in git, rollback anytime)
- :lucide-circle-check: Offline-first (works without internet after first load)

**Cons:**

- :lucide-x: No dynamic content (no user accounts, comments, forms)
- :lucide-x: Build step required (not instant publish)
- :lucide-x: Search is client-side (works well for <1000 pages)

**Trade-off:** Perfect for technical documentation. Don't need dynamic features.

### Zensical vs Alternatives

| Feature | Zensical | Docusaurus | GitBook | Confluence |
|---------|----------------|------------|---------|------------|
| **Setup** | :lucide-bolt: 5 minutes | :lucide-hourglass: 15 minutes | :lucide-cloud: Cloud only | :lucide-dollar-sign: Enterprise |
| **Markdown** | :lucide-circle-check: Pure MD | :lucide-triangle-alert: MDX (React) | :lucide-circle-check: Pure MD | :lucide-x: WYSIWYG |
| **Hosting** | Free (Pages) | Free (Pages) | $$ Paid | $$$ Paid |
| **Customization** | :lucide-paintbrush: CSS/HTML | :simple-react: React | :lucide-x: Limited | :lucide-x: Limited |
| **Search** | :lucide-circle-check: Built-in | :lucide-circle-check: Built-in | :lucide-circle-check: Built-in | :lucide-circle-check: Built-in |
| **Performance** | :lucide-rocket: Fast | :lucide-rocket: Fast | :lucide-snail: Slow | :lucide-snail: Slow |
| **Offline** | :lucide-circle-check: Yes | :lucide-circle-check: Yes | :lucide-x: No | :lucide-x: No |

**Winner:** Zensical (best docs-to-effort ratio)

### Python Tooling

**Why Python?**

- Zensical is Python-installable (pip install, done) with a Rust core for speed
- Virtual environments isolate dependencies
- Requirements.txt locks versions (reproducible builds)
- GitHub Actions has native Python support
- Fast iteration (change markdown, refresh browser)

**Alternatives considered:**

- **Hugo** (Go-based, faster builds but complex templating)
- **Jekyll** (Ruby-based, GitHub Pages default but slow)
- **Sphinx** (Python, but RST syntax sucks)

### GitHub Pages

**Why GitHub Pages?**

- Free (no cost for public repos)
- Fast (Fastly CDN, global edge locations)
- HTTPS built-in (free SSL certificates)
- Custom domains supported (CNAME)
- Git-based deployment (push to gh-pages branch)
- 100GB bandwidth/month (enough for docs)

**Alternatives:**

- **Vercel** - Faster builds, better DX, but overkill for static docs
- **Cloudflare Pages** - Unlimited bandwidth, but GitHub integration smoother
- **Netlify** - Great features, but free tier limits

---

## :lucide-heart: Philosophy

### Documentation as Code

**Principles:**

1. **Version controlled** - Every change in git history
2. **Peer reviewed** - PRs for major content changes
3. **CI/CD validated** - Broken links fail builds
4. **Markdown-native** - Plain text, tool-agnostic
5. **Searchable** - grep works on docs (unlike wikis)
6. **Portable** - Export to PDF, publish anywhere

### Content Philosophy

**Goals:**

- **Practical over theoretical** - Code examples > concepts
- **Honest over aspirational** - "Real talk" bullets
- **Current over comprehensive** - 2026 tooling, not legacy
- **Cynical over marketing** - No enterprise buzzwords
- **Self-contained** - Copy-paste examples that work

**Anti-goals:**

- :lucide-x: SEO optimization (this is personal documentation)
- :lucide-x: Monetization (no ads, no affiliate links)
- :lucide-x: Completeness (better to have 80% of useful content than 100% of everything)
- :lucide-x: Beginners first (assumes technical competence)

---

## :lucide-circle-help: FAQ

??? question "Why not use a CMS?"
    **CMSs are overkill for technical docs.** WordPress, Ghost, Strapi all require:
    - Database (maintenance, backups, security)
    - Server (hosting costs, scaling issues)
    - Admin UI (WYSIWYG editors break markdown)
    - Plugins (dependency hell)

    **Static sites are:**
    - Faster (pre-rendered HTML)
    - Cheaper (free hosting)
    - Simpler (markdown in git)
    - More secure (no backend to hack)

??? question "Why FontAwesome instead of plain emojis?"
    **Emojis are inconsistent across platforms.** Plain unicode renders differently on:
    - Windows (Microsoft emojis)
    - macOS (Apple emojis)
    - Linux (font-dependent)
    - Mobile (OS-dependent)

    **FontAwesome icons are:**
    - SVG-based (consistent rendering)
    - Professional (industry-standard icon set)
    - Scalable (crisp at any size)
    - Theme-aware (adapt to dark/light mode)

??? question "Why not host on personal server?"
    **GitHub Pages is more reliable than any personal server:**
    - 99.9%+ uptime (GitHub SLA)
    - Global CDN (Fastly, low latency worldwide)
    - DDoS protection (GitHub infrastructure)
    - Free SSL (Let's Encrypt auto-renewal)
    - Zero maintenance (no server to patch)

    **Personal servers:**
    - Cost money (VPS $5-20/month)
    - Require maintenance (updates, security)
    - Single point of failure (no redundancy)
    - Slower (no CDN)

??? question "Can I fork this project?"
    **Yes, it's open source.** Repository: [github.com/cosckoya/cosckoya.github.io](https://github.com/cosckoya/cosckoya.github.io)

    **To fork:**
    ```bash
    git clone https://github.com/cosckoya/cosckoya.github.io.git
    cd cosckoya.github.io
    python -m venv venv
    source venv/bin/activate
    pip install -r requirements.txt
    zensical serve  # http://localhost:8000
    ```

    **Customize:**
    - Edit `zensical.toml` (site name, colors, variant)
    - Replace `docs/resources/css/snape.css` (custom styling)
    - Update `CLAUDE.md` (remove project-specific instructions)
    - Modify content in `docs/` (your own documentation)

??? question "How do you maintain this?"
    **Minimal maintenance required:**
    - Write content in markdown (VS Code + preview)
    - Test locally: `zensical serve`
    - Validate: `zensical build --strict`
    - Push to main → auto-deploy (GitHub Actions)
    - Monthly: `pre-commit autoupdate` (update hooks)
    - Quarterly: Update dependencies (`pip install --upgrade -r requirements.txt`)

    **Time investment:**
    - Initial setup: 2-3 hours
    - Per page: 1-2 hours (writing + review)
    - Maintenance: <1 hour/month

---

## :lucide-bolt: Performance

### Build Metrics

```bash
# Production build stats (June 2026)
Pages: 49
Build time: ~3 seconds
Site size: ~15 MB (minified)
Largest page: ~50 KB (HTML)
Total CSS: ~200 KB (Zensical theme + custom)
Total JS: ~100 KB (search + instant loading)

# Lighthouse scores (mobile)
Performance: 95/100
Accessibility: 100/100
Best Practices: 100/100
SEO: 100/100
```

### Load Times

```bash
# First visit (cold cache)
HTML: ~50 KB → 200ms (CDN)
CSS: ~200 KB → 300ms (CDN)
JS: ~100 KB → 250ms (CDN)
Search index: ~500 KB → 500ms (CDN)
Total: ~1.25 seconds

# Return visit (warm cache)
HTML: ~50 KB → 50ms (304 Not Modified)
All assets: Cached
Total: ~50ms

# Navigation (instant loading)
Page change: ~50ms (client-side routing)
```

---

## :lucide-chart-line: Stats

**As of June 2026:**

- **49 pages** across 10 major sections
- **500+ code examples** with syntax highlighting
- **200+ inline annotations** explaining code
- **50+ Mermaid diagrams** for architecture visualization
- **8 cybersecurity disciplines** (1337 section)
- **3-second builds** (strict mode validation)
- **Zero runtime errors** (thanks to strict builds)
- **100% mobile responsive** (works on phones)

---

## :lucide-terminal: Contributing

This is a personal documentation project, but if you find errors or have suggestions:

1. **Open an issue** - [GitHub Issues](https://github.com/cosckoya/cosckoya.github.io/issues)
2. **Submit a PR** - Fork, branch, commit, push, PR
3. **Follow the style** - Read `CLAUDE.md` for content standards

**Contribution guidelines:**

- Use templates from `templates/`
- Follow three-tab "Quick Hits" structure
- Include inline code comments `# (1)!`
- Maintain cynical-but-helpful tone
- Use Lucide icons (`:lucide-...:`), no emojis
- Tags at bottom of page (not frontmatter)
- Validate with `zensical build --strict` or `make validate`

---

**Built with:** :lucide-heart: **and way too much coffee**

**Tech Stack:** Python 3.12 • Zensical 0.0.47 • GitHub Pages • GitHub Actions • FontAwesome • Mermaid • Pygments • Way too many Markdown extensions

**Last Updated:** 2026-02-02 | **Build Status:** :lucide-circle-check: Passing | **Uptime:** 99.9%

**Tags:** zensical, python, github-pages, documentation, static-site, markdown

*"It's dangerous to go alone."*