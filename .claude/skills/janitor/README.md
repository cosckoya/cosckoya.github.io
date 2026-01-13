# RepoJanitor Skill 🧹

Your sarcastic but brutally effective repository maintenance expert. Detects clutter, eliminates technical debt, and keeps your codebase cleaner than a freshly mopped server room.

## Skill Structure

This skill is self-contained with all its resources:

```
.claude/skills/repo-janitor/
├── SKILL.md                  # Main skill definition
├── README.md                 # This file
└── scripts/                  # Automation tools
    └── repo-janitor.sh      # All cleanup and inspection commands
```

## Quick Start

### Activate the Skill

```bash
/repo-janitor
```

Or in a message:
```
Use the repo-janitor skill to clean up this repository
```

### Available Tools

All cleanup tools are available via the script:

```bash
# Via symlink (convenient)
./scripts/repo-janitor.sh <command>

# Or directly from skill
./.claude/skills/repo-janitor/scripts/repo-janitor.sh <command>
```

**Common Commands:**
- `inspect` - Full repository inspection with health score
- `find-obsolete` - Find files older than 365 days
- `clean-cache` - Remove cache files (node_modules, __pycache__, etc.)
- `find-duplicates` - Detect duplicate markdown files
- `check-gitignore` - Audit .gitignore configuration
- `health-report` - Generate comprehensive health report
- `deep-clean --dry-run` - Nuclear option (use dry-run first!)

Run with `help` to see all available commands.

## Key Features

### 🗑️ Clutter Detection
- Finds files older than 365 days (obsolete content)
- Detects cache files in version control
- Identifies duplicate markdown files
- Locates large files (>1MB)

### 🧼 Smart Cleanup
- Archives obsolete files instead of deleting
- Updates .gitignore with best practices
- Validates repository structure
- Safe dry-run mode for all operations

### 📊 Health Scoring
- Repository health score (0-100)
- Branch hygiene analysis
- Detailed inspection reports
- Actionable recommendations

### 🎭 Personality
- Technically precise with humor
- Brutally honest about repo hygiene
- Zero tolerance for clutter
- Helpful but judgmental

## Common Workflows

### Initial Inspection

```bash
# Get a health report
./scripts/repo-janitor.sh health-report

# Full inspection with recommendations
./scripts/repo-janitor.sh inspect
```

### Safe Cleanup

```bash
# Always use dry-run first!
./scripts/repo-janitor.sh deep-clean --dry-run

# Review the output, then execute
./scripts/repo-janitor.sh deep-clean
```

### Maintenance Tasks

```bash
# Find and archive old files
./scripts/repo-janitor.sh find-obsolete
./scripts/repo-janitor.sh archive-obsolete

# Clean up cache files
./scripts/repo-janitor.sh clean-cache

# Check gitignore
./scripts/repo-janitor.sh check-gitignore
./scripts/repo-janitor.sh fix-gitignore
```

## Safety Features

- **Dry-run mode** - Test before executing
- **Archive instead of delete** - Moves to `.archive/` directory
- **Backup recommendations** - Always suggests backups first
- **Selective operations** - Target specific cleanup tasks

## Integration

Works with:
- Git repositories
- Any project structure
- Pre-commit hooks (planned)
- CI/CD pipelines (planned)

## Personality Traits

RepoJanitor's commentary style:
- "Your node_modules folder is committing crimes against humanity"
- "Found 47 obsolete files. Are we running a museum here?"
- "Your .gitignore is missing some basics. Did you even read the docs?"

But always technically precise and helpful underneath the snark.

## Version

**Current Version:** 1.0.0
**Last Updated:** 2026-01-13
**Maintained by:** cosckoya
