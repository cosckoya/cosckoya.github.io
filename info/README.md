# Project Information Directory

> **Consolidated documentation and project information files.**

This directory contains all non-user-facing documentation, agent configurations, project reports, and templates that
were previously scattered across the repository root.

______________________________________________________________________

## Directory Structure

```
info/
├── SKILLS_GUIDE.md  # How to use Claude Code skills (START HERE!)
├── agents/          # Claude Code agent documentation
├── project/         # Project reports and audits
└── templates/       # Generic templates and examples
```

______________________________________________________________________

## 📁 agents/

**Agent configurations and documentation for Claude Code.**

### Files

- **[DOCMASTER.md](agents/DOCMASTER.md)** - DocMaster v2.0 agent full documentation

    - Research-enabled documentation agent
    - 9 maintenance skills
    - English-only policy
    - Comprehensive resource categorization
    - Version management

- **[DEMO_DOCMASTER.md](agents/DEMO_DOCMASTER.md)** - DocMaster usage guide and demo

    - Quick start guide
    - Test commands
    - Example workflows
    - Health check procedures

**Quick Access:**

- Activate DocMaster: `/docmaster`
- Agent definition: `.claude/skills/docmaster/SKILL.md`
- Automation tools: `scripts/docmaster-tools.sh`

______________________________________________________________________

## 📋 project/

**Project-specific reports, audits, and documentation.**

### Files

- **[PROJECT_AUDIT_REPORT.md](project/PROJECT_AUDIT_REPORT.md)** - Repository audit report
    - Structure analysis
    - File organization review
    - Recommendations
    - Action items

______________________________________________________________________

## 📝 templates/

**Generic templates and examples for reference.**

### Files

- **[TEMPLATE.md](templates/TEMPLATE.md)** - Generic markdown template
    - Structural template
    - Reference format
    - Example sections

______________________________________________________________________

## Why This Structure?

**Before:** Markdown files scattered across repository root, making navigation confusing.

**After:** Clean organization with logical groupings:

✅ **Clear separation** - User docs (docs/) vs project info (info/) ✅ **Logical grouping** - Related files together
(agents, project, templates) ✅ **Clean root** - Only essential files remain at root level ✅ **Easy navigation** -
Predictable structure

______________________________________________________________________

## Root Level Files (What Stayed)

The following files remain at repository root because they serve specific purposes:

- **README.md** - Main project README (GitHub standard)
- **CONTRIBUTING.md** - Contribution guidelines (GitHub standard)
- **CLAUDE.md** - Claude Code project configuration
- **mkdocs.yml** - MkDocs configuration
- **requirements.txt** - Python dependencies
- **.gitignore** - Git ignore rules

Everything else related to project documentation has been consolidated into `info/`.

______________________________________________________________________

## Related Directories

- **docs/** - User-facing MkDocs documentation (public website)
- **.claude/** - Claude Code configuration and skills
- **.docmaster/** - DocMaster templates and examples
- **.github/** - GitHub workflows and project architecture docs
- **scripts/** - Automation scripts (docmaster-tools.sh, repo-janitor.sh)

______________________________________________________________________

## Quick Links

**Agent Documentation:**

- [DocMaster Agent](agents/DOCMASTER.md)
- [DocMaster Demo](agents/DEMO_DOCMASTER.md)
- [RepoJanitor Skill](../.claude/skills/repo-janitor/SKILL.md)

**Project Documentation:**

- [Project Audit Report](project/PROJECT_AUDIT_REPORT.md)
- [Architecture Proposal](.github/docs/architecture/SITE_ARCHITECTURE_PROPOSAL.md)

**Templates:**

- [Generic Template](templates/TEMPLATE.md)
- [Documentation Template](.docmaster/DOCUMENTATION_TEMPLATE.md)
- [AWS Example](.docmaster/EXAMPLE_AWS.md)

______________________________________________________________________

**Organized by:** RepoJanitor 🧹 **Date:** 2026-01-13 **Motto:** "Clean repos, clear mind, zero BS."
