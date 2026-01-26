---
paths:
  - "**"
---

# Git Workflow Guidelines

## Commit Guidelines

**Format**: Follow conventional commit style

```
<type>: <description>

Co-Authored-By: Claude <noreply@anthropic.com>
```

**Types**:
- `feat:` - New feature or content
- `fix:` - Bug fix or correction
- `docs:` - Documentation changes
- `refactor:` - Restructuring without behavior change
- `style:` - Formatting, whitespace
- `chore:` - Maintenance tasks

## Commit Safety Rules

**NEVER**:
- Run `git push --force` (especially to main/master)
- Run `git reset --hard` without explicit user request
- Skip hooks with `--no-verify` unless requested
- Commit sensitive files (`.env`, credentials)
- Use `git add -A` or `git add .` blindly

**ALWAYS**:
- Stage specific files by name
- Create NEW commits (not `--amend`) unless requested
- Include co-author attribution
- Run pre-commit hooks before committing
- Verify with `git status` before and after operations

## Pre-Commit Hook Workflow

Hooks enforce:
- Markdown formatting (`mdformat`)
- Spell checking (`codespell`)
- YAML validation (`yamllint`)

Run manually:
```bash
pre-commit run --all-files
```

## Pull Request Workflow

1. Create feature branch from `develop`
2. Make changes and commit with conventional format
3. Run `make test` to validate
4. Run `./scripts/docmaster-tools.sh full-maintenance`
5. Push to remote: `git push -u origin feature-branch`
6. Create PR to `develop` (not `main`)
7. Wait for CI/CD checks
8. Address review feedback
9. Merge when approved

## Creating Pull Requests

Use GitHub CLI for PRs:
```bash
gh pr create --title "feat: add new feature" --body "$(cat <<'EOF'
## Summary
- Bullet point summary

## Test plan
- [ ] Build passes with make test
- [ ] Documentation validated
- [ ] Navigation links work

🤖 Generated with [Claude Code](https://claude.com/claude-code)
EOF
)"
```

## Branch Protection

- `main` - Protected, requires PR and review
- Auto-deploys to GitHub Pages on push
- CI/CD must pass before merge

## Git Configuration

Repository uses:
- User: "Roy Batty"
- Email: roy.batty@users.noreply.github.com

For commits via Claude Code:
- Co-Author: Claude <noreply@anthropic.com>
