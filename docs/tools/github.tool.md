---
title: GitHub
description: GitHub platform reference — repos, Actions, security, and CLI
---

# :simple-github: GitHub

Where the code lives. Repos, Actions, security features, and the `gh` CLI that makes it scriptable.

!!! tip "2026 Update"
    Rulesets replaced classic branch protection as the recommended way to enforce policies. Dependabot and code scanning are built in.

---

## Quick Hits

=== ":lucide-list-check: Essential CLI"
    ```bash
    # Authenticate
    gh auth login

    # Clone and create PR
    gh repo clone owner/repo
    gh pr create --base main --head feature

    # List open PRs
    gh pr list
    ```

    **Real talk:**
    - `gh` is the fastest way to script GitHub operations.
    - Use `--json` for machine-readable output.

=== ":lucide-bolt: Common Patterns"
    ```bash
    # Enable auto-merge on a PR
    gh pr merge 123 --auto --squash

    # Create a release
    gh release create v1.0.0 --generate-notes
    ```

    **Why this works:**
    - Auto-merge waits for required checks.
    - `--generate-notes` builds changelog from PRs.

=== ":material-fire: Pro Tips & Gotchas"
    **Tips:**
    - Pin Actions to full commit SHAs.
    - Use rulesets instead of classic branch protection.

    **Gotchas:**
    - `GITHUB_TOKEN` permissions default to read; set explicit `permissions:` in workflows.
    - Fork PRs don't get secrets by default.

---

## Reference

- :lucide-book: [GitHub Docs](https://docs.github.com)
- :simple-github: [GitHub CLI](https://cli.github.com)

---

**Last Updated:** 2026-11-05 | **Vibe Check:** :lucide-globe: **Default Home** - the platform everything else orbits.

**Tags:** github, platform, tool