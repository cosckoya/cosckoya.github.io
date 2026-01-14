# Claude Code Skills - Quick Reference

> **Two skills. That's it. Keep it simple.**

______________________________________________________________________

## 🚀 Available Skills

You have **2 skills** configured:

1. **TechWriter v2.0** - Modern technical documentation
1. **Janitor** - Repository maintenance

______________________________________________________________________

## 📖 Skill 1: TechWriter v2.0

**Purpose:** Create modern, practical technical references. No BS, no fluff.

### Activation

```bash
/techwriter
```

Or just say:

```
"Document Redis"
"Create reference for Kubernetes"
"Add page for Terraform"
```

### What TechWriter Creates

**Page structure:**

1. **WTF** - 1-2 line technical intro
1. **Quick Hits** - 3 tabs (Essential, Patterns, Pro Tips)
1. **TL;DR Reference** - Optional table for CLI/APIs
1. **Worth Checking** - 4 card categories with curated links
1. **See Also** - Related topics

**Style:**

- 🎯 Direct, technical, no fluff
- ⚡ Modern with emojis
- 🔥 Assumes you know the basics
- 💀 Real-world patterns
- 🚀 No motivational language

**What it DOESN'T create:**

- ❌ Academic "Core Concepts" sections
- ❌ Abstract "Strategies" or "Core Services"
- ❌ Step-by-step tutorials
- ❌ 50+ link dumps

### Example Output

````markdown
# Redis

In-memory data store. Supports strings, hashes, lists, sets, sorted sets. Stupid fast (<1ms latency). Persistence optional.

---

## Quick Hits

=== "🎯 Essential Commands"
    ```bash
    redis-server       # Start server
    redis-cli          # Connect
    SET key value      # Store
    GET key            # Retrieve
    ```

=== "⚡ Common Patterns"
    ```python
    # Connection pool (best practice)
    pool = redis.ConnectionPool(host='localhost', port=6379, db=0)
    r = redis.Redis(connection_pool=pool)

    # Cache pattern
    cached = r.get(f'user:{user_id}')
    if cached:
        return json.loads(cached)
    ```

=== "🔥 Pro Tips"
    - Use connection pooling
    - Enable persistence only if needed
    - Monitor SLOWLOG for slow operations
    - Use SCAN instead of KEYS in production
````

### Validation

**MANDATORY after every page:**

```bash
source venv/bin/activate && mkdocs build --strict
```

Task is NOT complete until build passes with 0 errors.

______________________________________________________________________

## 🧹 Skill 2: Janitor

**Purpose:** Keep your repo clean with witty, sarcastic commentary.

### Activation

```bash
/janitor
```

Or just say:

```
"Inspect the repository"
"Clean up obsolete files"
"Generate health report"
```

### What Janitor Does

**Inspections:**

- 🗑️ Finds obsolete files (365+ days old)
- 💾 Detects cache files in version control
- 📋 Identifies duplicate markdown files
- 🐘 Locates large files (>1MB)
- 🧼 Validates .gitignore configuration
- 🌿 Analyzes branch hygiene
- 📊 Generates health score (0-100)

**Personality:**

> "Found 47 markdown files. Are we writing a novel or documenting code?"

> "Cache files detected. Git is not a trash can!"

### Common Commands

```bash
# Full inspection
./scripts/janitor.sh inspect

# Clean cache files
./scripts/janitor.sh clean-cache

# Repository health report
./scripts/janitor.sh health-report

# Find obsolete files
./scripts/janitor.sh find-obsolete

# Check .gitignore
./scripts/janitor.sh check-gitignore

# Find duplicates
./scripts/janitor.sh find-duplicates

# Deep clean (dry-run first!)
./scripts/janitor.sh deep-clean --dry-run
```

### Health Score

- **90-100:** 🏆 Pristine (Janitor is impressed)
- **75-89:** ✅ Good (Minor issues)
- **60-74:** ⚠️ Needs work (Schedule cleanup)
- **0-59:** 🚨 Critical (Janitor is judging you)

______________________________________________________________________

## 🔧 Skill Management

### Check Loaded Skills

```bash
ls -1 .claude/skills/*/SKILL.md
```

Output:

```
.claude/skills/janitor/SKILL.md
.claude/skills/techwriter/SKILL.md
```

### View Skill Documentation

```bash
# TechWriter
cat .claude/skills/techwriter/SKILL.md

# Janitor
cat .claude/skills/janitor/SKILL.md
```

______________________________________________________________________

## 📚 Complete Workflow Examples

### Example 1: Create Documentation for New Tech

```
/techwriter

"Document Terraform"
```

**TechWriter will:**

1. Research official docs, GitHub, awesome lists
1. Create 1-2 line intro (technical, direct)
1. Add Quick Hits tabs (commands, patterns, tips)
1. Include TL;DR table (if applicable)
1. Add 4 card categories with curated links (5-10 total)
1. Update SUMMARY.md
1. Validate build (`mkdocs build --strict`)
1. Report success

### Example 2: Repository Cleanup

```
/janitor

"Run full inspection"
```

**Janitor will:**

1. Scan for obsolete files (365+ days)
1. Find cache files in git
1. Detect duplicate markdown files
1. Locate large files (>1MB)
1. Check .gitignore completeness
1. Calculate health score
1. Provide sarcastic but actionable feedback

Then you can run:

```bash
./scripts/janitor.sh clean-cache
./scripts/janitor.sh fix-gitignore
```

______________________________________________________________________

## 🎯 When to Use Each Skill

### Use TechWriter When:

- ✅ Creating new documentation pages
- ✅ Documenting new technology/tool
- ✅ Adding technical reference
- ✅ Updating existing docs with modern style

### Use Janitor When:

- ✅ Monthly repository cleanup
- ✅ Before major releases
- ✅ After large refactors
- ✅ When root directory feels cluttered
- ✅ To check repository health

______________________________________________________________________

## 🆘 Troubleshooting

### Skill Not Activating

**Check skills exist:**

```bash
ls -la .claude/skills/
```

Should show:

```
drwxrwxr-x ... janitor/
drwxrwxr-x ... techwriter/
```

### Scripts Not Working

**Make scripts executable:**

```bash
chmod +x scripts/*.sh
```

**Test scripts:**

```bash
./scripts/janitor.sh help
```

______________________________________________________________________

## 🎓 Quick Command Reference

```bash
# TECHWRITER
/techwriter                          # Activate skill
mkdocs build --strict                # Validate build (MANDATORY)

# JANITOR
/janitor                             # Activate skill
./scripts/janitor.sh inspect         # Full inspection
./scripts/janitor.sh health-report   # Health score
./scripts/janitor.sh clean-cache     # Clean cache
```

______________________________________________________________________

## 📖 Additional Documentation

**Skills:**

- [TechWriter SKILL.md](.claude/skills/techwriter/SKILL.md)
- [Janitor SKILL.md](.claude/skills/janitor/SKILL.md)

**Project:**

- [Project Guidelines](../CLAUDE.md)
- [Contributing Guide](../CONTRIBUTING.md)

______________________________________________________________________

**Last Updated:** 2026-01-13 **Skills Version:** 2.0 **Philosophy:** Modern, practical, no BS
