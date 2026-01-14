# DocMaster v2.0 - Demo Guide

Quick demonstration of DocMaster capabilities and how to use the skill.

---

## 🚀 Quick Start

### Activate DocMaster Skill

In Claude Code, type:
```
/docmaster
```

Or mention it in your request:
```
"Use the docmaster skill to help me create documentation for Docker"
```

---

## 🧪 Test Commands

### 1. Validate Documentation Structure

```bash
./scripts/docmaster-tools.sh validate-structure
```

**Expected Output:**
```
ℹ Validating documentation structure...
✓ Documentation structure is valid
```

### 2. Check Internal Links

```bash
./scripts/docmaster-tools.sh check-links
```

**Expected Output:**
```
ℹ Checking link integrity...
✓ All 16 links are valid
```

### 3. Find Orphaned Documents

```bash
./scripts/docmaster-tools.sh find-orphans
```

**Expected Output:**
```
ℹ Finding orphaned documents...
✓ No orphaned documents found
```

### 4. Check for Empty Directories

```bash
./scripts/docmaster-tools.sh cleanup-empty
```

**Expected Output:**
```
ℹ Finding empty directories...
✓ No empty directories found
```

### 5. Check Dependency Versions

```bash
./scripts/docmaster-tools.sh check-versions
```

**Expected Output:**
```
ℹ Checking latest versions of dependencies...
ℹ Checking Python packages...
✓ mkdocs: 1.6.1 (up to date)
⚠ mkdocs-material: 9.7.0 → 9.7.1 (update available)
...
⚠ Found 20 outdated dependencies
ℹ Run 'docmaster-tools update-requirements' to update
```

### 6. Validate Build

```bash
./scripts/docmaster-tools.sh validate-build
```

**Expected Output:**
```
ℹ Validating MkDocs build...
✓ MkDocs build successful
```

### 7. Run Full Maintenance

```bash
./scripts/docmaster-tools.sh full-maintenance
```

**Expected Output:**
```
ℹ Running full maintenance check...

ℹ Validating documentation structure...
✓ Documentation structure is valid

ℹ Finding empty directories...
✓ No empty directories found

ℹ Finding orphaned documents...
✓ No orphaned documents found

ℹ Checking link integrity...
✓ All 16 links are valid

ℹ Auditing content freshness...
...

✨ All maintenance checks passed!
```

---

## 📝 Example: Creating New Documentation

### Scenario: Create documentation for Kubernetes

**Step 1: Activate DocMaster**
```
/docmaster
```

**Step 2: Request documentation**
```
"Create comprehensive documentation for Kubernetes following the expert template"
```

**What DocMaster will do:**

1. **Research Phase:**
   - Search for latest Kubernetes version
   - Fetch official Kubernetes documentation
   - Research current best practices
   - Find top learning resources

2. **Content Creation:**
   - Read the documentation template
   - Create `docs/containers/kubernetes.md`
   - Include all required sections:
     - Overview (What/Why)
     - Quick Start (5-minute setup)
     - Core Concepts (Pods, Services, Deployments)
     - Common Use Cases
     - Advanced Usage
     - Best Practices
     - Learning Resources (5+ quality links)
     - Related Topics

3. **Navigation Update:**
   - Update `docs/containers/SUMMARY.md`
   - Add `* [Kubernetes](kubernetes.md)`

4. **Validation:**
   - Run structure validation
   - Check links
   - Validate build
   - Run pre-commit hooks

5. **Result:**
   - Expert-level documentation in English
   - Beginner-to-expert learning path
   - Validated and ready to commit

---

## 🔧 Maintenance Workflows

### Update Dependencies

```bash
# Check what needs updating
./scripts/docmaster-tools.sh check-versions

# Update requirements.txt (creates backup)
./scripts/docmaster-tools.sh update-requirements

# Update pre-commit hooks
./scripts/docmaster-tools.sh update-precommit

# Verify everything works
pre-commit run --all-files
mkdocs build --strict
```

### Audit Content Freshness

```bash
# Find old content and TODOs
./scripts/docmaster-tools.sh audit-freshness
```

**Output shows:**
- Files not modified in 180+ days
- TODO/FIXME/XXX markers in code
- Content that needs review

### Fix Broken Links

```bash
# Check for broken links
./scripts/docmaster-tools.sh check-links

# If broken links found:
# 1. Review the error output
# 2. Fix links in the markdown files
# 3. Re-run check-links
# 4. Commit fixes
```

---

## 🎯 DocMaster Features Demo

### Feature 1: English-Only Policy

**Test:** Try to request content in non-English language (should be rejected)

```
"Create documentation for Python in Spanish"
```

**Expected Behavior:**
DocMaster will REJECT the request and respond in English, enforcing the CRITICAL POLICY that ALL documentation MUST be in English. The agent will create the content in English regardless of the request language.

### Feature 2: Research-First Approach

**Test:** Ask DocMaster about a technology

```
"What's the latest version of Terraform and what are the best practices?"
```

**Expected Behavior:**
- Uses WebSearch to find latest version
- Fetches official Terraform documentation
- Researches current best practices
- Provides accurate, current information

### Feature 3: Expert-Level Content

**Test:** Ask for documentation

```
"Create documentation for PostgreSQL"
```

**Expected Content:**
- Overview explaining what PostgreSQL is and why use it
- Quick Start with installation steps
- Core Concepts (ACID, Relations, Transactions)
- Common Use Cases
- Advanced Usage (Replication, Partitioning)
- Best Practices (Performance, Security)
- 5+ Learning Resources (official docs, tutorials, community)
- Related Topics (SQL, Databases, Backup)

### Feature 4: Version Management

**Test:** Check dependencies

```bash
./scripts/docmaster-tools.sh check-versions
```

**Expected Behavior:**
- Queries PyPI for latest versions
- Compares with requirements.txt
- Shows available updates
- Provides update command

### Feature 5: Zero-Waste Principle

**Test:** Run maintenance

```bash
./scripts/docmaster-tools.sh full-maintenance
```

**Expected Behavior:**
- Removes empty directories
- Finds orphaned documents
- Validates all links
- Ensures clean, organized structure

---

## 📊 Current Project Status

After DocMaster setup, the project has:

✅ **Clean Structure**
- 0 empty directories
- 0 orphaned documents
- 16 valid internal links

✅ **Valid Build**
- mkdocs build --strict passes
- All pre-commit hooks pass
- Site deploys successfully

✅ **Python-Only Toolchain**
- No Node.js dependencies
- Fast CI/CD pipeline
- All tools in requirements.txt

✅ **Documentation Standards**
- Expert-level template
- English-only policy
- Research-first approach
- Minimum 5 learning resources per page

✅ **Automated Maintenance**
- 11 maintenance commands
- Version checking
- Automatic updates
- Pre-commit validation

---

## 🎓 Learning the Skill

### When to Use DocMaster

Use `/docmaster` when you need to:

- ✅ Create new documentation pages
- ✅ Update existing documentation with latest info
- ✅ Research best practices for a technology
- ✅ Validate documentation structure
- ✅ Run maintenance checks
- ✅ Update dependencies
- ✅ Fix broken links or orphaned docs

### When NOT to Use DocMaster

Don't use `/docmaster` for:

- ❌ Writing application code
- ❌ Debugging Python/JavaScript code
- ❌ Git operations (commits, branches)
- ❌ Deployment tasks
- ❌ General conversation

---

## 🚦 Quick Health Check

Run this command to verify everything is working:

```bash
./scripts/docmaster-tools.sh full-maintenance && \
pre-commit run --all-files && \
echo "✅ All systems operational!"
```

If all checks pass, DocMaster is ready to use!

---

## 📚 Additional Resources

- **Full Agent Docs:** `/home/cosckoya/hack/cosckoya.github.io/info/agents/DOCMASTER.md`
- **Content Template:** `.docmaster/DOCUMENTATION_TEMPLATE.md`
- **Project Guidelines:** `CLAUDE.md`
- **Skill Definition:** `.claude/skills/docmaster/SKILL.md`

---

**Created:** 2026-01-13
**Version:** 2.0.0
**Status:** Ready for Production 🚀
