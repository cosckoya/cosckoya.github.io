---
title: Zensical - Feature Showcase
description: Complete reference of all Zensical features, markdown extensions, and built-in modules
---

# :lucide-wand-sparkles: Zensical Feature Showcase

**Kitchen sink documentation** — Every feature, pattern, and capability of the Zensical ecosystem. Use this as reference for what's possible, copy/paste examples, or generate new documentation.

Last Updated: 2026-07-08 | Theme: Zensical 0.0.47 (modern variant)

---

## :lucide-layer-group: Theme Features Overview

This site uses Zensical 0.0.47 with all major features enabled. Below is the complete reference.

### Navigation Features

=== "Instant Loading (SPA)"

    ```markdown
    # Automatic with Zensical
    - Pages load without full refresh
    - URL updates smoothly
    - Preserves scroll position
    - Prefetches linked pages on hover
    ```

    When enabled, navigation behaves like a single-page application. Click links and the page transitions smoothly without reloading. Enabled via `navigation.instant` and `navigation.instant.prefetch` in `zensical.toml`.

=== "Breadcrumbs"

    Enabled via `navigation.breadcrumbs` feature. Shows the path:

    > Home > Awesome > Showcase

    Helps users understand location and navigate backwards.

=== "Navigation Sections"

    Sections are collapsible/expandable. With `navigation.expand`, all sections expand by default. Try collapsing the left sidebar sections.

=== "Table of Contents (Right Sidebar)"

    The right sidebar shows page sections with `toc.follow` — it highlights the current section as you scroll.

---

## :lucide-palette: Typography & Colors

### Headings

# Heading 1 — Page title
## Heading 2 — Major section
### Heading 3 — Subsection
#### Heading 4 — Sub-subsection
##### Heading 5 — Minor heading
###### Heading 6 — Smallest heading

### Text Formatting

This is **bold text** and this is *italic text*. You can also use ***bold italic***.

~~Strikethrough text~~ is supported. `Inline code looks like this` with syntax highlighting.

Superscript: H^2^O
Subscript: H~2~O

### Lists

**Unordered lists:**

- Item 1
- Item 2
  - Nested item 2a
  - Nested item 2b
- Item 3

**Ordered lists:**

1. First step
2. Second step
   1. Sub-step 2.1
   2. Sub-step 2.2
3. Third step

**Definition lists:**

`Term`
:   Definition of the term goes here. Can be multiple lines.

`Another term`
:   Explanation of another term.

**Task lists:**

- [x] Completed task
- [ ] Incomplete task
- [x] Another completed task

---

## :lucide-code: Code Blocks & Syntax Highlighting

### Basic Code Block

```bash
# Install dependencies
source venv/bin/activate
pip install -r requirements.txt

# Run server
zensical serve
```

### Python with Annotations

```python
import requests  # (1)!

def fetch_api(url: str) -> dict:  # (2)!
    """Fetch data from API."""
    response = requests.get(url)
    return response.json()  # (3)!

data = fetch_api("https://api.example.com/data")  # (4)!
```

1. Import the requests library
2. Type hints for clarity
3. Return parsed JSON
4. Call the function

### Code with Line Numbers

Enable globally in `zensical.toml` with `linenums: true`, or per-block with `linenums="1"`:

```toml linenums="1"
# zensical.toml — theme config
[markdown_extensions.pymdownx]
highlight = { use_pygments = true, anchor_linenums = true }
```

### Multiple Languages Tabbed

=== "Bash"

    ```bash
    curl -X GET https://api.example.com/users
    ```

=== "Python"

    ```python
    import requests
    response = requests.get("https://api.example.com/users")
    users = response.json()
    ```

=== "JavaScript"

    ```javascript
    const response = await fetch("https://api.example.com/users");
    const users = await response.json();
    ```

=== "Go"

    ```go
    resp, err := http.Get("https://api.example.com/users")
    defer resp.Body.Close()
    data := json.NewDecoder(resp.Body)
    ```

### Inline Code

Use backticks for `inline code`. For highlighting within text: `python`, `bash`, `toml`.

---

## :lucide-message: Admonitions

Admonitions draw attention to important information. Ten types available:

!!! note "Note"
    This is a note. Use for additional information that doesn't fit elsewhere.

!!! abstract "Abstract"
    Short summary or overview of the section. Good for TL;DR sections.

!!! info "Info"
    General informational content. Similar to note but slightly different tone.

!!! tip "Tip"
    Helpful advice or best practice. How to do something better.

!!! success "Success"
    Positive outcome, successful operation, or confirmation.

!!! question "Question"
    FAQ entry or common question.

!!! warning "Warning"
    Caution required. Potential issues or things to watch out for.

!!! failure "Failure"
    Failed operation or error condition.

!!! danger "Danger"
    Critical warning. Do NOT do this or serious consequences may occur.

!!! bug "Bug"
    Known issue or limitation. Workaround may be available.

!!! example "Example"
    Code example or usage demonstration.

!!! quote "Quote"
    Quote from external source.

### Collapsible Admonitions

??? note "Click to expand"
    This note is collapsible. Click the header to expand/collapse.

??? warning "Expandable warning"
    This warning starts closed. Great for side notes that might clutter the page.

??? danger "Nested collapsible with admonition"
    You can nest admonitions inside collapsibles.

    !!! bug "Bug inside collapsible"
        This bug is inside a collapsible admonition.

---

## :lucide-table: Tables

| Feature | Zensical | Hugo | Jekyll | Status |
|---------|----------|------|--------|--------|
| Setup Time | :lucide-bolt: 2 min | :lucide-hourglass: 10 min | :lucide-hourglass: 20 min | :lucide-circle-check: |
| Customization | :lucide-star: Excellent | :lucide-star: Good | :lucide-star: Good | :lucide-circle-check: |
| Performance | :lucide-rocket: Fast | :lucide-rocket: Fast | :lucide-snail: Slow | :lucide-circle-check: |
| Learning Curve | :material-chart-line: Easy | :material-chart-line: Moderate | :material-chart-line: Easy | :lucide-circle-check: |

**Table with alignment:**

| Left | Center | Right |
|:-----|:------:|------:|
| Aligned left | Centered | Aligned right |
| Git is | Version | Control |

### Data Table from Markdown

```markdown
| Header 1 | Header 2 | Header 3 |
|----------|----------|----------|
| Cell     | Cell     | Cell     |
```

---

## :lucide-icons: Icons

### Lucide Icons (Inline)

Solid icons: :lucide-star: :lucide-heart: :lucide-rocket: :lucide-skull: :lucide-bug:

Brand icons via Simple Icons: :simple-github: :simple-gitlab: :simple-docker: :simple-python:

### Icon Collections

| Category | Icons |
|----------|-------|
| Development | :simple-github: :simple-gitlab: :lucide-code: :simple-git: |
| Deployment | :lucide-rocket: :simple-docker: :material-aws: :lucide-cloud: |
| Security | :lucide-lock: :lucide-key: :lucide-shield: :lucide-bug: |
| Status | :lucide-circle-check: :fontawesome-solid-circle-xmark: :lucide-hourglass: :fontawesome-solid-triangle-exclamation: |

### Theme Config Icons

Icons used for UI elements (admonitions, tags, social) in `zensical.toml`:

```toml
[theme.icon.repo]
repo = "simple/github"

[theme.icon.admonition]
note = "lucide/info"
tip = "lucide/lightbulb"
danger = "lucide/skull"

[theme.icon.tag]
cloud = "lucide/cloud"
security = "lucide/shield"
ai = "lucide/sparkles"
```

---

## :lucide-link: Links & References

### Internal Links

- [Go to index](index.md)
- [Cloud & DevOps section](cloud/)
- [GitHub API documentation](api/github-rest-api.service.md)

### External Links

- [Zensical Documentation](https://zensical.dev/)
- [Python](https://www.python.org/)

### Automatic Link Detection

Visit https://github.com/cosckoya/cosckoya.github.io for the source.

### Anchor Links (Footnotes)

This text has a footnote[^1].

[^1]: This is the footnote content. Can be multiple lines and paragraphs.

Another footnote reference[^2] in the text.

[^2]: Footnotes appear at the bottom of the page and are clickable.

---

## :lucide-image: Images

### Basic Image

![Site logo](resources/img/logo.png){ width="200" }

### Image with Caption

![Architecture diagram](resources/img/logo.png)

This is a caption below the image.

### Image Alignment

Left aligned:

![Left](resources/img/logo.png){ align="left" width="150" }

Lorem ipsum dolor sit amet, consectetur adipiscing elit. The image floats to the left with text wrapping around it.

Right aligned:

![Right](resources/img/logo.png){ align="right" width="150" }

Lorem ipsum dolor sit amet, consectetur adipiscing elit. The image floats to the right with text wrapping around it.

Centered (default):

![Center](resources/img/logo.png){ width="150" }

---

## :lucide-square-asterisk: Abbreviations

The HTML specification is maintained by the W3C.

*[HTML]: Hyper Text Markup Language
*[W3C]: World Wide Web Consortium

Hover over "HTML" or "W3C" to see the abbreviation tooltip.

---

## :lucide-minus: Horizontal Rules

Text before rule.

---

Text after rule. Use horizontal rules to separate major sections visually.

---

## :lucide-code-branch: Code Snippets & Diagrams

### Inline Snippet Example

```python
# This is inline code - copy/paste ready
def hello_world():
    print("Hello, World!")

if __name__ == "__main__":
    hello_world()
```

### Mermaid Diagrams

Diagrams are rendered via `pymdownx.superfences` with mermaid support:

```mermaid
graph TD
    A[Start] --> B{Decision}
    B -->|Yes| C[Process A]
    B -->|No| D[Process B]
    C --> E[End]
    D --> E
```

### Class Diagram

```mermaid
classDiagram
    class User {
        +name: str
        +email: str
        +login()
        +logout()
    }
    class Admin {
        +permissions: list
        +approve()
    }
    User <|-- Admin
```

### Sequence Diagram

```mermaid
sequenceDiagram
    participant User
    participant Browser
    participant Server
    User->>Browser: Click link
    Browser->>Server: HTTP GET /api/data
    Server-->>Browser: JSON response
    Browser-->>User: Render page
```

---

## :lucide-toggle-right: Tabs & Panels

Tabbed content with persistent state across pages:

=== "Getting Started"

    ### Installation

    ```bash
    pip install zensical
    zensical new my-site
    cd my-site
    ```

=== "Configuration"

    ### zensical.toml

    ```toml
    site_name = "My Site"

    [theme]
    variant = "modern"
    ```

=== "Deployment"

    ### Deploy to GitHub Pages

    ```bash
    zensical build
    # Deploy site/ to gh-pages branch
    ```

### Multiple Platform Tabs

!!! warning "Nested tabs not supported"
    `pymdownx.tabbed` does NOT support nested tabs. Tabs must be flat at the same level.
    Use separate tab groups if you need multiple dimensions.

**Tab group 1 — By OS:**

=== "Linux"

    ```bash
    sudo apt-get install python3-pip
    pip install zensical
    ```

=== "macOS"

    ```bash
    brew install python3
    pip install zensical
    ```

=== "Windows"

    ```cmd
    python -m pip install zensical
    zensical serve
    ```

**Tab group 2 — By package manager:**

=== "pip"

    ```bash
    pip install zensical
    ```

=== "conda"

    ```bash
    conda install zensical
    ```

=== "uv"

    ```bash
    uv pip install zensical
    ```

---

## :lucide-list: Advanced Lists

### Nested Lists with Mixed Content

- **Feature 1**: Description here
  - Sub-feature 1a
    - Detail 1a1
    - Detail 1a2
  - Sub-feature 1b
- **Feature 2**: Another description
  - With code example:
    ```bash
    zensical serve
    ```
  - And some text

### Lists with Admonitions

- First item
  !!! note "Note about item"
      This is a note about the first item
- Second item
- Third item with warning
  !!! warning "Be careful"
      Do not skip this step

---

## :lucide-comments: Comments & Annotations

Comments can be added using HTML comments (they won't be rendered):

<!-- This comment is invisible to users -->

Code can have inline annotations as shown in the "Code with Annotations" section above.

### Keyboard Input

Press ++ctrl+alt+delete++ to reboot.

Use ++cmd+s++ on Mac to save.

---

## :lucide-strikethrough: Text Decorations

~~Strikethrough~~ text shows what was removed.

<u>Underlined text</u> for emphasis.

*Italic for emphasis*

**Bold for strong emphasis**

***Bold italic for maximum emphasis***

### Mark/Highlight

This is ==highlighted text== using mark extension.

---

## :lucide-sliders: Content Actions

Pages can have action buttons (edit/view source):

These are controlled by:
```yaml
features:
  - content.action.edit
  - content.action.view
```

Buttons appear in the header (if configured).

---

## :lucide-book-open: Blockquotes

> This is a simple blockquote.
> It can span multiple lines.
> — Author Name

> This is a longer blockquote with more content.
>
> It has multiple paragraphs and can include other elements.
>
> - Lists
> - Even lists!
>
> And ***formatting***.

---

## :lucide-calculator: Math & Formulas

!!! warning "Requires additional setup"
    Math rendering requires `pymdownx.arithmatex` extension **plus** MathJax or KaTeX JavaScript.
    Add to `zensical.toml`:
    ```toml
    [markdown_extensions.pymdownx]
    arithmatex = { generic = true }
    ```
    Also add `extra_javascript`. Not enabled by default on this site.

Inline math syntax: `$E = mc^2$`

Block math syntax:

```
$$
\frac{-b \pm \sqrt{b^2 - 4ac}}{2a}
$$
```

```
$$
\begin{align}
a &= b + c \\
d &= e + f \\
g &= h + i
\end{align}
$$
```

---

## :lucide-search: Zensical Features

### Disco Search

Search is built-in via Disco (Zensical's native search engine). Try the search box (top right on desktop).

- Powered by client-side Rust indexing
- No external search plugin needed
- Supports stemming and fuzzy matching
- Shares search results via URL

### Tags

Pages can be tagged for organization:

!!! info "Tags"
    This page is tagged with: `zensical`, `showcase`, `features`, `markdown`, `theme`

### GLightbox

Images can be opened in a lightbox for full-size viewing. Powered by `zensical.extensions.glightbox`.

### Template Macros

Reusable content macros via `zensical.extensions.macros`. Define snippets once, include anywhere.

---

## :lucide-monitor: Responsive Design

This page is fully responsive. Try resizing your browser:

- Desktop: Full navigation sidebar
- Tablet: Collapsible navigation
- Mobile: Navigation drawer

### Mobile Menu

On mobile/tablet, click the hamburger menu (three lines) to toggle the navigation sidebar.

### Breakpoints

Zensical's modern theme uses these breakpoints:

- **Small** (< 768px): Mobile
- **Medium** (768-1216px): Tablet
- **Large** (> 1216px): Desktop

---

## :lucide-circle-half-stroke: Dark & Light Mode

Toggle between dark (Purple theme) and light (Deep Purple + Teal) modes using the button in the top right.

Color schemes are defined in `zensical.toml`:

```toml
[[theme.palette]]
scheme = "slate"
primary = "purple"
accent = "lime"

[[theme.palette]]
scheme = "default"
primary = "deep purple"
accent = "teal"
```

---

## :lucide-gears: Configuration Reference

### Key Theme Options

```toml
[theme]
variant = "modern"
logo = "path/to/logo.png"
favicon = "path/to/favicon.png"
language = "en"
features = ["nav.sections", "nav.expand", ...]
```

### Essential Features

Complete feature list as configured on this site:

```yaml
features:
  # Navigation
  - navigation.sections          # Expandable/collapsible sections
  - navigation.expand            # Expand all sections by default
  - navigation.breadcrumbs       # Breadcrumb trail
  - navigation.instant           # SPA-like navigation (no full reload)
  - navigation.instant.prefetch  # Prefetch pages on hover
  - navigation.instant.progress  # Loading progress indicator
  - navigation.tracking          # URL fragment updates on scroll
  - navigation.top               # Back to top button
  - navigation.indexes           # Section index pages (index.md per section)
  - navigation.footer            # Previous/next page navigation
  - navigation.path              # Show full path in navigation

  # Search
  - search.suggest               # Search auto-complete
  - search.highlight             # Highlight matches in page

  # Content
  - content.code.copy            # Copy button on code blocks
  - content.code.select          # Text selection on code blocks
  - content.code.annotate        # Inline code annotations (# (1)!)
  - content.tabs.link            # Persistent tab state across pages
  - content.tooltips             # Abbreviation tooltips
  - content.footnote.tooltips    # Footnotes as inline tooltip popovers
  - content.action.edit          # "Edit this page" button
  - content.action.view          # "View source" button

  # TOC
  - toc.follow                   # Highlight current section while scrolling

  # Header
  - header.autohide              # Auto-hide header on scroll down
  - announce.dismiss             # Dismissible announcement bar
```

---

## :lucide-circle-help: Common Patterns

### "Real Talk" Pattern

!!! note "Real talk:"
    - This is how real things work
    - Practical advice for production
    - What actually matters
    - Skip the marketing speak

### Pro Tips & Gotchas Pattern

!!! tip "Pro Tips"
    - Use feature X for Y reason
    - Combine with Z for best results
    - Consider edge case ABC

!!! danger "Gotchas"
    - Don't do X (it breaks Y)
    - Watch out for Z behavior
    - This is a common mistake

### Three-Tab Quick Hits Pattern

=== ":lucide-list-check: Essential"

    Key commands and basic usage

    ```bash
    command --flag argument
    ```

=== ":lucide-bolt: Common Patterns"

    Real-world use cases

    ```bash
    command pattern example
    ```

=== ":lucide-fire: Pro Tips & Gotchas"

    Advanced usage and warnings

    - Tip 1
    - Gotcha 1

---

## :lucide-rocket: Performance Tips

### 1. Use Instant Loading

Already enabled. Pages load without full refresh.

### 2. Lazy Load Images

Use markdown image syntax with proper alt text:

```markdown
![Description](image.png){ alt="Detailed description" }
```

### 3. Organize Navigation

Use explicit `nav:` in `zensical.toml` for clean, maintainable navigation structure.

### 4. Optimize Images

- Compress images before adding to docs
- Use WebP format when possible
- Set width/height attributes

### 5. Cache-Friendly URLs

Zensical generates static URLs that leverage browser caching.

---

## :lucide-shield: Accessibility (WCAG 2.1 AA)

This site aims for WCAG 2.1 AA compliance:

- Color contrast: 4.5:1 minimum for text
- Keyboard navigation: Fully functional
- Screen reader support: Semantic HTML
- Focus indicators: Visible on all interactive elements
- Alt text: All images have descriptions

### Keyboard Shortcuts

- ++s++ or ++slash++: Focus search
- ++esc++: Close modals / exit search
- ++tab++: Navigate elements
- ++enter++: Activate buttons / confirm

---

## :lucide-file: File Organization

```
docs/
├── index.md                 # Homepage
├── showcase.md              # This file (feature reference)
├── toolbox/                 # CLI tools: asdf, kitty, neovim, tmux, zsh
├── os/                      # Operating systems: linux, macos, windows
├── containers/              # Docker (+ Compose), Kubernetes
│   └── tools/               # helm, krew, kubectx, dive, popeye
├── databases/               # Database tooling
│   └── tools/               # dbcli, oracledb-cli
├── cloud/                   # Cloud & DevOps (AWS + merged tools)
│   └── tools/               # terraform, prowler, checkov, github, azure-devops, snyk, sonarcloud, trivy
├── api/                     # API references
├── code/                    # Programming languages + tools
│   └── tools/               # gitleaks, shellcheck, etc.
├── ai/                      # AI tools: Bedrock, AI Foundry, Vertex AI
│   └── tools/
├── 1337/                    # Security / CTF content (10 guides)
├── awesome/                 # Curated references
├── templates/               # Doc generation templates
│   ├── page.template.md                 # RECOMMENDED
│   ├── tech-reference.template.md       # DEPRECATED
│   └── tool-reference.template.md       # DEPRECATED
└── resources/
    ├── css/
    │   ├── snape.css        # Custom styling
    │   └── images.css
    └── img/
        ├── logo.png
        └── favicon.png
```

Navigation is managed via explicit `nav:` in `zensical.toml` (no `SUMMARY.md` files).

---

## :lucide-circle-check: Validation Checklist

When creating new documentation, use this checklist:

- [ ] Page has `title` and `description` in frontmatter
- [ ] All links are relative paths
- [ ] All images have alt text
- [ ] Lucide icons used (no plain emojis)
- [ ] Code blocks have language specified
- [ ] Admonitions used appropriately
- [ ] "Real talk" sections for practical advice
- [ ] Pro tips separated from gotchas
- [ ] Tags placed at bottom of page
- [ ] `zensical build --strict` passes
- [ ] Tone is cynical/realistic (not aspirational)

---

## :lucide-lightbulb: Tips for Content Creation

### 1. Use Templates

Start with `page.template.md` for consistency. The old `tech-reference.template.md` and `tool-reference.template.md` are deprecated.

### 2. Three-Tab Structure

Essential → Common Patterns → Pro Tips & Gotchas structure works for most content.

### 3. Practical Examples

Copy-paste code examples that actually work. Include inline comments.

### 4. Honest Tone

Say "this is painful" instead of "this is challenging." Marketing-speak has no place here.

### 5. Link Everything

Internal links help users navigate. Use relative paths.

### 6. Organize with Sections

Use heading hierarchy (h2, h3, h4) to structure content logically.

---

## :lucide-graduation-cap: Learning Resources

**External Resources:**

- :lucide-book: [Zensical Documentation](https://zensical.dev/)
- :lucide-book: [Python-Markdown Extensions](https://python-markdown.github.io/)
- :simple-github: [cosckoya/cosckoya.github.io](https://github.com/cosckoya/cosckoya.github.io)

**Related Topics:**

- :lucide-code: Markdown syntax and best practices
- :lucide-palette: Color theory and accessibility
- :lucide-layer-group: Static site generation
- :lucide-magnifying-glass: Full-text search optimization

---

**Last Updated:** 2026-07-08
**Tags:** zensical, showcase, features, markdown, theme, documentation
