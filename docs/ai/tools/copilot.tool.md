---
title: GitHub Copilot CLI
description: AI command-line assistant - shell commands, git operations, GitHub integration
---

# :fontawesome-solid-robot: GitHub Copilot CLI

Command-line AI assistant from GitHub. Suggests shell commands, explains existing commands, helps with git operations. Integrated with GitHub ecosystem. Better for quick terminal tasks than complex code generation. Subscription required (comes with GitHub Copilot).

!!! tip "2026 Update"
    Copilot CLI (ghcs) is now stable and widely adopted. Integration with GitHub CLI (gh) for PR/issue management. Supports bash, zsh, fish, PowerShell. Context-aware based on current directory and git status. Included with GitHub Copilot subscription ($10/month individual, $19/month business).

______________________________________________________________________

## :fontawesome-solid-bolt: Quick Hits

=== ":fontawesome-solid-list-check: Essential Commands"

    ```bash
    # Installation (requires GitHub Copilot subscription)
    gh extension install github/gh-copilot

    # Or via npm
    npm install -g @githubnext/github-copilot-cli

    # Authentication
    gh auth login                      # Authenticate with GitHub
    gh copilot auth                    # Verify Copilot access

    # Basic usage (shell command suggestions)
    gh copilot suggest "find large files"
    # Output: find . -type f -size +100M

    gh copilot suggest "kill process on port 8080"
    # Output: lsof -ti:8080 | xargs kill -9

    gh copilot suggest "compress folder to tar.gz"
    # Output: tar -czf archive.tar.gz folder/

    # Explain existing commands
    gh copilot explain "docker run -d -p 80:80 -v /data:/app/data nginx"
    # Provides detailed breakdown of flags and behavior

    # Git operations
    gh copilot suggest "undo last commit but keep changes"
    # Output: git reset --soft HEAD~1

    gh copilot suggest "list branches by last commit date"
    # Output: git branch --sort=-committerdate

    # Aliases for convenience
    alias '??'='gh copilot suggest'
    alias 'explain'='gh copilot explain'

    # Then use:
    ?? "list all running docker containers with their ports"
    explain "kubectl get pods -A"
    ```

    **Real talk:**

    - Requires GitHub Copilot subscription ($10/month)
    - Best for discovering shell commands you don't remember
    - Context-aware (knows you're in a git repo)
    - Works across bash, zsh, fish, PowerShell
    - Interactive mode asks clarifying questions

=== ":fontawesome-solid-bolt: Common Patterns"

    ```bash
    # File operations
    ?? "find and delete all .DS_Store files"
    # find . -name ".DS_Store" -type f -delete

    ?? "count lines of code in JavaScript files"
    # find . -name "*.js" -exec wc -l {} + | tail -1

    ?? "find files modified in last 24 hours"
    # find . -type f -mtime -1

    # System administration
    ?? "check disk usage sorted by size"
    # du -sh * | sort -h

    ?? "list top 10 memory-consuming processes"
    # ps aux --sort=-%mem | head -10

    ?? "monitor network traffic in real-time"
    # iftop -i eth0

    # Git workflows
    ?? "create new branch and switch to it"
    # git checkout -b feature/new-feature

    ?? "cherry-pick commit from another branch"
    # git cherry-pick <commit-hash>

    ?? "squash last 3 commits"
    # git rebase -i HEAD~3

    # Docker operations
    ?? "remove all stopped containers"
    # docker container prune -f

    ?? "view logs from last 100 lines of container"
    # docker logs --tail 100 container_name

    # Kubernetes
    ?? "get pod logs from crashed pod"
    # kubectl logs <pod-name> --previous

    ?? "port forward local 8080 to pod 80"
    # kubectl port-forward <pod-name> 8080:80

    # Networking
    ?? "test if port 443 is open on remote host"
    # nc -zv hostname 443

    ?? "flush DNS cache"
    # sudo dscacheutil -flushcache (macOS)
    # sudo systemd-resolve --flush-caches (Linux)
    ```

    **Why this works:**

    - Copilot has been trained on millions of shell commands
    - Understands context (OS, current directory, git status)
    - Suggests safe commands (no destructive operations without confirmation)
    - Interactive refinement if initial suggestion isn't right
    - Explains complex commands before execution

=== ":fontawesome-solid-fire: Pro Tips & Gotchas"

    !!! success "Productivity Boosters"
        - **Shell aliases** - Set `alias ??='gh copilot suggest'` for quick access
        - **Explain complex commands** - Paste from Stack Overflow, ask Copilot to explain
        - **Learn as you go** - Review suggestions to understand flags and options
        - **Interactive mode** - Let Copilot ask clarifying questions for ambiguous requests
        - **OS-specific** - Copilot adapts to your OS (different commands for Linux/macOS/Windows)

    !!! warning "Best Practices"
        - **Review before executing** - Always read the command before running
        - **Test destructive operations** - Try with `--dry-run` or in test directory first
        - **Understand the command** - Don't blindly copy-paste, learn what it does
        - **Use `explain` often** - Understanding > memorization
        - **Context matters** - Be in the right directory for git/docker commands

    !!! tip "Integration with Workflow"
        - **GitHub CLI integration** - `gh pr create`, `gh issue list` work seamlessly
        - **Terminal multiplexers** - Use with tmux/screen for persistent sessions
        - **Shell history** - Copilot suggestions get added to history for reuse
        - **VSCode terminal** - Works in integrated terminal
        - **Custom aliases** - Combine with shell functions for power-user workflows

    !!! danger "Common Gotchas"
        - **Subscription required** - Need GitHub Copilot subscription ($10/month)
        - **Not a code editor** - For shell commands only, use Copilot in IDE for code
        - **Internet required** - No offline mode (suggestions via API)
        - **Rate limits** - Fair use policy applies (don't spam requests)
        - **Security** - Don't paste secrets or API keys in suggestions
        - **Platform differences** - Some commands are Linux-specific, won't work on macOS/Windows

    !!! info "Copilot CLI vs Claude Code"
        - **Copilot CLI for:**
            - Quick shell command lookups
            - Git command suggestions
            - Explaining complex one-liners
            - GitHub integration (PRs, issues)
            - Learning shell commands
        - **Claude Code for:**
            - Writing/editing application code
            - Multi-file refactoring
            - Architecture planning
            - Complex debugging
            - Autonomous workflows

______________________________________________________________________

## :fontawesome-solid-terminal: Advanced Usage

### Shell Integration

Add to your shell config for seamless integration:

```bash
# ~/.zshrc or ~/.bashrc

# Aliases
alias ??='gh copilot suggest'
alias explain='gh copilot explain'
alias ghcs='gh copilot suggest'

# Function wrapper for auto-execution (use with caution)
function copilot-run() {
    local cmd=$(gh copilot suggest "$*" | tail -1)
    echo "Suggested: $cmd"
    read -p "Execute? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        eval "$cmd"
    fi
}

# Quick Docker suggestions
alias docker??='gh copilot suggest "docker"'
alias k8s??='gh copilot suggest "kubectl"'
```

### GitHub CLI Integration

Combine with `gh` commands for powerful workflows:

```bash
# PR management with Copilot
gh copilot suggest "list open PRs sorted by date"
# gh pr list --state open --json number,title,updatedAt --sort updated

# Issue triage
gh copilot suggest "close all issues labeled 'wontfix'"
# gh issue list --label wontfix --json number --jq '.[].number' | xargs -n1 gh issue close

# Repository insights
gh copilot suggest "count commits by author in last month"
# gh api repos/:owner/:repo/stats/contributors --jq '.[].weeks[-4:] | add | .c'
```

### Custom Workflows

Create shell functions for common tasks:

```bash
# Smart commit function
function smartcommit() {
    local message=$(gh copilot suggest "generate git commit message for: $*")
    git add -A
    git commit -m "$message"
}

# Deployment helper
function deploy() {
    local env=$1
    local cmd=$(gh copilot suggest "deploy to $env environment")
    echo "$cmd"
    read -p "Proceed? (y/n) " -n 1 -r
    [[ $REPLY =~ ^[Yy]$ ]] && eval "$cmd"
}
```

______________________________________________________________________

## :fontawesome-solid-book: Learning Resources

### :fontawesome-solid-graduation-cap: Official Resources

- **[GitHub Copilot Documentation](https://docs.github.com/copilot)** - Official docs
- **[Copilot CLI Guide](https://docs.github.com/copilot/github-copilot-in-the-cli)** - CLI-specific docs
- **[GitHub CLI Documentation](https://cli.github.com/manual/)** - gh command reference

### :fontawesome-solid-code: Example Use Cases

!!! example "Daily Development"
    - **Command discovery** - "List all environment variables containing AWS"
    - **Git archaeology** - "Show commits that modified this file in last month"
    - **Docker debugging** - "Why is container failing health check"
    - **Quick scripts** - "One-liner to backup database to S3"

!!! example "System Administration"
    - **Diagnostics** - "Check if port 80 is listening and which process owns it"
    - **Log analysis** - "Find errors in syslog from last hour"
    - **Cleanup** - "Free up disk space by removing old logs"
    - **Monitoring** - "Show CPU usage by process in real-time"

!!! example "DevOps Tasks"
    - **CI/CD** - "Deploy latest image to Kubernetes staging"
    - **Infrastructure** - "List all EC2 instances using AWS CLI"
    - **Secrets** - "Rotate database password in all environments"
    - **Backups** - "Schedule daily PostgreSQL backups to S3"

______________________________________________________________________

## :fontawesome-solid-star: Worth Checking

<div class="grid cards" markdown>

- :fontawesome-solid-book: __Official Docs__

    ______________________________________________________________________

    [GitHub Copilot](https://github.com/features/copilot)

    [Copilot CLI Guide](https://docs.github.com/copilot/github-copilot-in-the-cli)

    [GitHub CLI](https://cli.github.com/)

    [Copilot Pricing](https://github.com/features/copilot/plans)

- :fontawesome-solid-wrench: __Related Tools__

    ______________________________________________________________________

    [GitHub CLI (gh)](https://cli.github.com/)

    [GitHub Copilot for IDEs](https://github.com/features/copilot)

    [GitHub Copilot Chat](https://docs.github.com/copilot/github-copilot-chat)

- :fontawesome-solid-users: __Community__

    ______________________________________________________________________

    [GitHub Community](https://github.community/)

    [r/github](https://reddit.com/r/github)

    [GitHub Copilot Feedback](https://github.com/github-community/community/discussions/categories/copilot)

- :fontawesome-solid-graduation-cap: __Learning__

    ______________________________________________________________________

    [Shell Command Tips](https://github.com/jlevy/the-art-of-command-line)

    [Awesome Shell](https://github.com/alebcay/awesome-shell)

    [ExplainShell](https://explainshell.com/)

</div>

______________________________________________________________________

**Last Updated:** 2026-02-02 | **Vibe Check:** :fontawesome-solid-terminal: **Specialized Tool** - Copilot CLI is excellent for shell command discovery and git operations. Not a replacement for full coding assistants but invaluable for terminal workflows. Worth the subscription if you work in terminals daily.
**Tags:** copilot, github, ai, cli, shell
