# TechWriter - Unified Technical Documentation Expert

**Version:** 1.0.0 **Created:** 2026-01-13 **Status:** Active

______________________________________________________________________

## Overview

TechWriter is the **unified documentation skill** that combines the best of DocMaster and Snape:

- **From DocMaster:** Research-first approach, comprehensive resources, build validation
- **From Snape:** Premium visual design, card grids, icons, conciseness

**Result:** Practical, didactic technical references with beautiful presentation.

______________________________________________________________________

## What TechWriter Creates

Every page includes:

1. **Brief Introduction** (2-4 sentences)
1. **Core Concepts** (tabbed, concise)
1. **Technical Reference** (optional, when applicable)
1. **Resources** (card grids with 4 categories)
1. **Related Topics**

______________________________________________________________________

## Key Features

### ✅ What You Get

- 🔍 **Research-First** - Always investigates current best practices
- 🎨 **Premium Design** - Card grids, icons, tabs, custom CSS
- 📐 **Concise** - Brief introductions, straight to content
- 🔗 **Link-Rich** - Comprehensive resources, visually organized
- ✅ **Validated** - Build passes before completion
- 🇬🇧 **English-Only** - Enforced language policy

### ❌ What You Don't Get

- ❌ Extensive "Getting Started" tutorials
- ❌ Step-by-step installation guides
- ❌ Verbose explanations
- ❌ Plain bullet lists
- ❌ Motivational language

______________________________________________________________________

## Activation

```bash
/techwriter
```

Or in a message:

```
Create documentation for [Technology]
```

______________________________________________________________________

## Example Output

### Input

```
Create documentation for Redis
```

### Output Structure

```markdown
# Redis

In-memory data structure store used as database, cache, message broker, and streaming engine. Supports various data structures including strings, hashes, lists, sets, and sorted sets.

---

## Core Concepts

=== "Data Structures"
    [Concise technical definition]

=== "Persistence"
    [Concise technical definition]

=== "Replication"
    [Concise technical definition]

---

## Resources

<div class="grid cards" markdown>

- :material-file-document: __Official Documentation__
- :material-school: __Learning Resources__
- :material-github: __Code & Tools__
- :material-account-group: __Community__

</div>
```

______________________________________________________________________

## Page Structure

### Required Sections

1. ✅ **Title & Introduction** (2-4 sentences)
1. ✅ **Core Concepts** (tabbed, minimum 3)
1. ✅ **Resources** (card grids, 4 categories)
1. ✅ **Related Topics**

### Optional Sections

- **Technical Reference** (only if technology has specs/API/config)

______________________________________________________________________

## Design Principles

### 1. Card Grids Always

```html
<div class="grid cards" markdown>

- :material-icon: __Category__

    ---

    [:material-link: Link](url)

</div>
```

### 2. Content Tabs for Concepts

```markdown
=== "Concept Name"
    Definition and key points
```

### 3. Icons for Visual Hierarchy

- `:material-file-document:` - Documentation
- `:material-school:` - Learning
- `:material-github:` - Code
- `:material-account-group:` - Community
- `:material-flask:` - Labs
- `:material-api:` - API

______________________________________________________________________

## Research Workflow

**BEFORE creating any page:**

1. ✅ Search official documentation
1. ✅ Find interactive labs/playgrounds
1. ✅ Locate video tutorials
1. ✅ Search awesome lists
1. ✅ Find community resources (Discord, forums, Reddit)
1. ✅ Identify GitHub repositories
1. ✅ Verify all links are accessible

______________________________________________________________________

## Validation Checklist

Before completing ANY page:

- [ ] Brief 2-4 sentence introduction
- [ ] Core concepts in tabs (minimum 3)
- [ ] Resources in card grids (4 categories)
- [ ] All links have icons
- [ ] Related topics section present
- [ ] No "Getting Started" tutorial sections
- [ ] No verbose explanations
- [ ] English only
- [ ] `mkdocs build --strict` passes with 0 errors

______________________________________________________________________

## Integration

### Replaces

- **DocMaster v2.0** - Too verbose, extensive tutorials
- **Snape v1.0** - Too dry, pure reference

### Works With

- **RepoJanitor** - Repository maintenance
- **MkDocs Material** - Theme configuration required
- **Snape CSS** - Premium styling (`docs/stylesheets/snape.css`)

______________________________________________________________________

## Configuration Requirements

### MkDocs Material Extensions

```yaml
markdown_extensions:
  - attr_list
  - md_in_html
  - pymdownx.emoji:
      emoji_index: !!python/name:material.extensions.emoji.twemoji
      emoji_generator: !!python/name:material.extensions.emoji.to_svg
  - pymdownx.superfences
  - pymdownx.tabbed:
      alternate_style: true
  - admonition
  - def_list
  - tables

theme:
  features:
    - content.tabs.link

extra_css:
  - stylesheets/snape.css
```

______________________________________________________________________

## File Structure

```
.claude/skills/techwriter/
├── SKILL.md                          # Main skill definition
├── README.md                         # This file
└── templates/
    └── DOCUMENTATION_TEMPLATE.md     # Page template
```

______________________________________________________________________

## Golden Rules

1. 🔍 **Research first** - Never write from memory
1. 🇬🇧 **English only** - Non-negotiable
1. 🎨 **Card grids** - Never plain bullets for links
1. 📐 **Concise** - Brief intro, straight to content
1. 🔗 **Comprehensive** - But visually organized
1. ✅ **Validate** - Build MUST pass
1. 📊 **Tabs** - For concepts and organization
1. 🎯 **Practical** - Developer-focused content

______________________________________________________________________

## Comparison

| Aspect               | DocMaster      | Snape          | TechWriter            |
| -------------------- | -------------- | -------------- | --------------------- |
| **Introduction**     | Extensive      | Brief          | Brief (2-4 sentences) |
| **Tutorials**        | Yes, detailed  | No             | No                    |
| **Design**           | Basic markdown | Premium        | Premium               |
| **Resources**        | 12 categories  | 3 categories   | 4 categories (visual) |
| **Concepts**         | Verbose        | Minimal        | Concise tabs          |
| **Build Validation** | Yes            | Yes            | Yes                   |
| **Best For**         | Learning paths | Pure reference | Practical reference   |

______________________________________________________________________

## Migration from Old Skills

### From DocMaster Pages

1. Reduce introduction to 2-4 sentences
1. Remove "Quick Start" and "Getting Started" sections
1. Convert concepts to tabbed format
1. Consolidate 12 resource categories into 4
1. Use card grids for all links

### From Snape Pages

1. Add more didactic context to concepts
1. Expand from 3 to 4 resource categories
1. Ensure learning resources are included
1. Make technical definitions more accessible

______________________________________________________________________

## Example Commands

```bash
# Create new documentation
/techwriter create documentation for Terraform

# Update existing page
/techwriter update the Kubernetes page

# Research and document
/techwriter research and document gRPC
```

______________________________________________________________________

## Success Criteria

A TechWriter page is successful when:

- ✅ Brief but informative introduction
- ✅ Visually stunning with card grids and tabs
- ✅ Comprehensive links organized in 4 categories
- ✅ Practical and immediately useful
- ✅ No verbose tutorials
- ✅ Build validates without errors

______________________________________________________________________

**Documentation:** This README **Template:** `templates/DOCUMENTATION_TEMPLATE.md` **Activation:** `/techwriter`
**Status:** Active (v1.0.0)
