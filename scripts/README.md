# DocMaster Tools

Automation scripts for maintaining MkDocs documentation with integrity.

## Overview

DocMaster Tools provides automated checks and maintenance tasks for this MkDocs project, ensuring:

- ✅ No broken links
- ✅ No orphaned documents
- ✅ Valid structure and navigation
- ✅ Clean, zero-waste documentation
- ✅ Consistent style and formatting

## Quick Start

```bash
# Run full maintenance check
./scripts/docmaster-tools.sh full-maintenance

# Check for specific issues
./scripts/docmaster-tools.sh check-links
./scripts/docmaster-tools.sh find-orphans
./scripts/docmaster-tools.sh cleanup-empty
```

## Available Commands

### Link Integrity

```bash
./scripts/docmaster-tools.sh check-links
```

Scans all markdown files for internal links and verifies targets exist.

**Checks**:

- Relative link targets exist
- Directory links resolve to index.md
- No broken cross-references

### Orphan Detection

```bash
./scripts/docmaster-tools.sh find-orphans
```

Finds markdown files not referenced in any SUMMARY.md.

**Reports**:

- Documents not in navigation
- Files without incoming links
- Suggestions for integration

### Structure Validation

```bash
./scripts/docmaster-tools.sh validate-structure
```

Validates documentation structure follows project conventions.

**Checks**:

- First-level directories have SUMMARY.md
- Directories have index.md files
- Main docs/SUMMARY.md exists
- Proper hierarchy (max 3 levels)

### Empty Directory Cleanup

```bash
./scripts/docmaster-tools.sh cleanup-empty
```

Finds and removes empty placeholder directories.

**Actions**:

- Scans docs/ for empty directories
- Removes empty directories
- Reports cleanup results

### Content Freshness Audit

```bash
./scripts/docmaster-tools.sh audit-freshness
```

Identifies stale content and TODO markers.

**Reports**:

- Files not modified in 6+ months
- TODO/FIXME/XXX markers
- Placeholder content

### Build Validation

```bash
./scripts/docmaster-tools.sh validate-build
```

Runs MkDocs build in strict mode to catch warnings and errors.

**Checks**:

- Activates venv if present
- Runs `mkdocs build --strict`
- Reports build success/failure

### Style Check

```bash
./scripts/docmaster-tools.sh check-style
```

Runs markdownlint to enforce markdown style conventions.

**Requires**: `npm install -g markdownlint-cli`

### Full Maintenance

```bash
./scripts/docmaster-tools.sh full-maintenance
```

Runs all checks in sequence for comprehensive validation.

**Includes**:

1. Structure validation
1. Empty directory cleanup
1. Orphan detection
1. Link integrity check
1. Freshness audit
1. Build validation

## Integration with Pre-Commit

Add to `.pre-commit-config.yaml`:

```yaml
- repo: local
  hooks:
    - id: docmaster-validation
      name: DocMaster Validation
      entry: scripts/docmaster-tools.sh
      args: [validate-structure, cleanup-empty, check-links]
      language: script
      pass_filenames: false
```

## Integration with Make

Add to `Makefile`:

```makefile
.PHONY: docmaster-check
docmaster-check:
 @./scripts/docmaster-tools.sh full-maintenance

.PHONY: docmaster-links
docmaster-links:
 @./scripts/docmaster-tools.sh check-links

.PHONY: docmaster-clean
docmaster-clean:
 @./scripts/docmaster-tools.sh cleanup-empty
```

Then use:

```bash
make docmaster-check
make docmaster-links
make docmaster-clean
```

## Integration with Claude Code

DocMaster tools work seamlessly with Claude Code via the DOCMASTER.md prompt.

**Usage**:

```
@DOCMASTER.md run maintenance check
```

Claude will:

1. Read DOCMASTER.md instructions
1. Run appropriate docmaster-tools.sh commands
1. Report results and suggest fixes

See [DOCMASTER.md](../info/agents/DOCMASTER.md) for full agent documentation.

## Workflow Examples

### Before Committing

```bash
# Quick validation
./scripts/docmaster-tools.sh check-links
./scripts/docmaster-tools.sh validate-structure
./scripts/docmaster-tools.sh validate-build

# Or run all at once
./scripts/docmaster-tools.sh full-maintenance
```

### Weekly Maintenance

```bash
# Clean up and audit
./scripts/docmaster-tools.sh cleanup-empty
./scripts/docmaster-tools.sh find-orphans
./scripts/docmaster-tools.sh audit-freshness
```

### After Major Restructuring

```bash
# Comprehensive check
./scripts/docmaster-tools.sh full-maintenance

# If issues found, fix and re-run
./scripts/docmaster-tools.sh check-links
./scripts/docmaster-tools.sh validate-build
```

## Exit Codes

- `0` - Success, no issues found
- `1` - Failure, issues detected

Use in CI/CD:

```bash
if ./scripts/docmaster-tools.sh check-links; then
  echo "✓ Links are valid"
else
  echo "✗ Broken links detected"
  exit 1
fi
```

## Output Format

Tools use colored output for clarity:

- 🔵 **Info** (blue) - Informational messages
- ✅ **Success** (green) - Checks passed
- ⚠️ **Warning** (yellow) - Issues found (non-critical)
- ❌ **Error** (red) - Critical issues

## Dependencies

- **bash** - Shell script interpreter
- **grep** - Pattern matching
- **find** - File system search
- **mkdocs** - Documentation generator (for validate-build)
- **markdownlint** - Markdown linter (optional, for check-style)

## Troubleshooting

### "mkdocs not found"

```bash
# Activate virtual environment
source venv/bin/activate

# Or install mkdocs
pip install -r requirements.txt
```

### "Permission denied"

```bash
# Make script executable
chmod +x scripts/docmaster-tools.sh
```

### False positives in orphan detection

Some files are intentionally standalone (e.g., `bookmarks.md`). These are excluded in the script logic.

## Contributing

When adding new checks:

1. Follow the existing function pattern
1. Add colored output (info/success/warning/error)
1. Return appropriate exit codes
1. Update help text
1. Update this README

## Related Documentation

- [DOCMASTER.md](../info/agents/DOCMASTER.md) - Full DocMaster agent documentation
- [CLAUDE.md](../CLAUDE.md) - Project development guidelines
- [.github/docs/architecture/](../.github/docs/architecture/) - Architecture decisions

______________________________________________________________________

**Created**: 2026-01-13 **Maintained by**: DocMaster Agent **Status**: Active
