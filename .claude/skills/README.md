# Claude Code Skills

> **Two skills. That's it. Keep it simple.**

This directory contains custom skills for Claude Code in this project.

______________________________________________________________________

## Active Skills

### 1. TechWriter v2.0 📝

**Skill ID:** `techwriter`

**File:** `techwriter/SKILL.md`

**Philosophy:** Practical, no-BS technical references for people who know their shit.

**Activation:**

```bash
/techwriter
```

Or just:

```
"Document Redis"
"Create reference for Terraform"
```

**What You Get:**

- 1-2 line technical intro (straight to the point)
- Quick Hits tabs: Essential commands, patterns, pro tips
- Optional TL;DR reference table
- Curated links (5-10 best resources, not 50)
- No academic BS, no tutorials, no fluff

**Style:**

- 🎯 Direct and technical
- ⚡ Modern with emojis
- 🔥 Assumes you know the basics
- 💀 Real-world code patterns
- 🚀 No motivational language

**What It Does NOT Create:**

- ❌ "Core Concepts" academic sections
- ❌ "Core Services" or "Strategies" abstractions
- ❌ Step-by-step tutorials
- ❌ Verbose explanations
- ❌ 50+ link lists

**Version:** 2.0.0 **Created:** 2026-01-13 **Replaces:** DocMaster v2.0, Snape v1.0, Schorlar

______________________________________________________________________

### 2. Janitor 🧹

**Skill ID:** `janitor`

**File:** `janitor/SKILL.md`

**Philosophy:** Clean repos, clear mind, zero BS. With sass and class.

**Activation:**

```bash
/janitor
```

Or just:

```
"Inspect the repository"
"Clean up obsolete files"
```

**What It Does:**

- 🗑️ Finds obsolete files (365+ days old)
- 💾 Detects cache files in version control
- 📋 Identifies duplicate markdown files
- 🐘 Locates large files (>1MB)
- 🧼 Validates .gitignore configuration
- 🌿 Analyzes branch hygiene
- 📊 Generates health reports (0-100 score)
- 🎭 Provides witty, sarcastic feedback

**Personality:**

> "Found 47 markdown files. Are we writing a novel or documenting code?"

> "Cache files detected. Git is not a trash can!"

**Common Commands:**

```bash
./scripts/janitor.sh inspect         # Full inspection
./scripts/janitor.sh clean-cache     # Remove cache
./scripts/janitor.sh health-report   # Health score
```

**Version:** 1.0.0 **Created:** 2026-01-13 **Formerly:** RepoJanitor (renamed for simplicity)

______________________________________________________________________

## Skill Structure

Each skill is self-contained:

```
.claude/skills/<skill-name>/
├── SKILL.md              # Skill definition and instructions
├── README.md             # Documentation
├── scripts/              # Automation scripts (optional)
│   └── <skill>-tools.sh
├── templates/            # Templates and examples (optional)
│   └── *.md
└── config/              # Configuration files (optional)
    └── *.md
```

**Current structure:**

```
.claude/skills/
├── techwriter/
│   ├── SKILL.md
│   ├── README.md
│   └── templates/
│       └── DOCUMENTATION_TEMPLATE.md
└── janitor/
    ├── SKILL.md
    ├── README.md
    └── scripts/
        └── janitor.sh
```

**Benefits:**

- ✅ Self-contained - everything in one place
- ✅ Easy to share - copy the entire skill directory
- ✅ Modular - each skill has its own tools and config
- ✅ Maintainable - clear organization

______________________________________________________________________

## How Skills Work

When you invoke a skill:

1. Claude Code reads the `SKILL.md` file from the skill directory
1. Activates the agent with the defined instructions
1. The agent follows the workflows and policies defined in the skill
1. Has access to the tools and commands specified in the skill
1. Uses templates and scripts from the skill's own directories

______________________________________________________________________

## Quick Command Reference

### TechWriter

```bash
/techwriter                          # Activate skill
mkdocs build --strict                # Validate build (MANDATORY)
```

### Janitor

```bash
/janitor                             # Activate skill
./scripts/janitor.sh inspect         # Full inspection
./scripts/janitor.sh health-report   # Health score
./scripts/janitor.sh clean-cache     # Clean cache
```

______________________________________________________________________

## Deprecated Skills

The following skills have been removed:

### ❌ DocMaster v2.0

- **Status:** DEPRECATED (2026-01-13)
- **Replaced by:** TechWriter v2.0
- **Reason:** Too verbose with extensive tutorials, academic tone

### ❌ Snape v1.0

- **Status:** DEPRECATED (2026-01-13)
- **Replaced by:** TechWriter v2.0
- **Reason:** Too dry, lacked practical context

### ❌ Schorlar

- **Status:** DEPRECATED (2026-01-13)
- **Replaced by:** TechWriter v2.0
- **Reason:** Too basic, no personality

### ❌ Rankle

- **Status:** DEPRECATED (2026-01-13)
- **Reason:** Orchestrator no longer needed with single unified documentation skill

______________________________________________________________________

## Related Documentation

**Skills Guide:** `info/SKILLS_GUIDE.md` - Complete usage guide **Project Guidelines:** `CLAUDE.md` - Project-specific
instructions **Contributing:** `CONTRIBUTING.md` - Contribution guidelines

______________________________________________________________________

**Last Updated:** 2026-01-13 **Active Skills:** TechWriter v2.0, Janitor **Philosophy:** Modern, practical, no BS
