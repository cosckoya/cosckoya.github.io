---
title: Claude Code
description: AI-powered CLI coding assistant - autonomous agents, file editing, git integration, bash execution
---

# :fontawesome-solid-code: Claude Code

Official CLI tool from Anthropic for coding with Claude AI. Autonomous agents that read files, write code, execute commands, and manage git workflows. Context-aware with unlimited conversation length. Terminal-native experience. More capable than Copilot for complex tasks, but requires thoughtful prompting.

!!! tip "2026 Update"
    Claude Code (2026.02+) uses Claude Sonnet 4.5 by default. Multi-agent system with specialized agents (bash, explore, plan). MCP (Model Context Protocol) support for custom integrations. Skills system for reusable workflows. Free tier available, Pro subscription for unlimited usage.

______________________________________________________________________

## :fontawesome-solid-bolt: Quick Hits

=== ":fontawesome-solid-list-check: Essential Commands"

    ```bash
    # Installation (npm global)
    npm install -g @anthropic-ai/claude-code

    # Or via Homebrew (macOS/Linux)
    brew install anthropic/tap/claude-code

    # Authentication
    claude auth login                  # Opens browser for login
    claude auth logout                 # Clear authentication
    claude auth status                 # Check current auth state

    # Basic usage
    claude                             # Start interactive session
    claude "write a fibonacci function" # One-shot command
    claude --file app.py "add error handling" # Work on specific file

    # Session management
    claude --continue                  # Resume last session
    claude --session session-id        # Resume specific session
    claude sessions list               # List all sessions
    claude sessions delete session-id  # Delete session

    # Model selection
    claude --model sonnet              # Claude Sonnet 4.5 (default)
    claude --model opus                # Claude Opus 4.5 (most capable)
    claude --model haiku               # Claude Haiku 4.0 (fast/cheap)

    # Configuration
    claude config set                  # Interactive config wizard
    claude config show                 # Show current config
    claude config reset                # Reset to defaults

    # Skills (reusable workflows)
    claude skills list                 # List available skills
    /commit                            # Git commit with AI message (skill)
    /review-pr 123                     # Review GitHub PR (skill)
    ```

    **Real talk:**

    - First run creates `~/.claude/` config directory
    - Free tier: 30 messages/day with Sonnet, upgrade for unlimited
    - Claude can read/write files, run bash commands, commit to git
    - Sessions are unlimited length (automatic summarization)
    - Use skills (`/command`) for common workflows

=== ":fontawesome-solid-bolt: Common Patterns"

    ```bash
    # Code generation workflow
    claude "create a REST API with Express.js, PostgreSQL, JWT auth"
    # Claude will:
    # 1. Ask clarifying questions
    # 2. Generate file structure
    # 3. Write implementation files
    # 4. Create package.json with dependencies
    # 5. Write tests

    # Debugging workflow
    claude --file src/api.js "why is this endpoint returning 500?"
    # Claude will:
    # 1. Read the file
    # 2. Analyze error patterns
    # 3. Suggest fixes
    # 4. Optionally apply changes

    # Refactoring workflow
    claude "refactor this codebase to use TypeScript"
    # Claude will:
    # 1. Analyze current code structure
    # 2. Create migration plan
    # 3. Convert files incrementally
    # 4. Update configs (tsconfig.json, package.json)

    # Git workflow
    # Make changes, then:
    /commit
    # Claude will:
    # 1. Run git status and git diff
    # 2. Analyze changes
    # 3. Generate descriptive commit message
    # 4. Stage files and commit
    # 5. Ask if you want to push

    # Documentation workflow
    claude "generate API documentation for all endpoints in routes/"
    # Claude will:
    # 1. Read route files
    # 2. Identify endpoints
    # 3. Generate OpenAPI/Swagger spec or markdown docs

    # Testing workflow
    claude "write unit tests for utils/validation.js with 90% coverage"
    # Claude will:
    # 1. Read source file
    # 2. Identify functions and edge cases
    # 3. Write comprehensive test suite
    # 4. Suggest running tests to verify
    ```

    **Why this works:**

    - Claude has full codebase context via file reads
    - Autonomous agents handle multi-step workflows
    - Built-in tools (bash, git, file editing) enable execution
    - Conversation history maintains context across tasks
    - Skills encapsulate best practices for common operations

=== ":fontawesome-solid-fire: Pro Tips & Gotchas"

    !!! success "Productivity Boosters"
        - **Specific prompts** - "Add JWT auth to /api/login endpoint" > "improve security"
        - **Iterative refinement** - Start broad, then refine (Claude remembers context)
        - **Ask for explanations** - "Explain what this regex does" (learning mode)
        - **Use skills** - `/commit`, `/review-pr` for common workflows
        - **Multiple models** - Use Haiku for simple tasks (faster/cheaper), Opus for complex
        - **Context files** - Create `CLAUDE.md` in repo root for project-specific instructions

    !!! warning "Best Practices"
        - **Review before applying** - Claude suggests changes, you approve (safety net)
        - **Git commits** - Commit working code before major refactors (rollback safety)
        - **Test generated code** - Always run tests after changes (AI makes mistakes)
        - **Security review** - Check generated auth/crypto code carefully
        - **API keys** - Never paste real credentials in prompts (use env vars)
        - **CLAUDE.md** - Add project conventions, coding standards, architecture notes

    !!! tip "Advanced Usage"
        - **MCP servers** - Connect external tools (databases, APIs, custom integrations)
        - **Custom skills** - Create reusable workflows in `.claude/skills/`
        - **Plan mode** - Use for complex features (design first, implement later)
        - **Multi-file edits** - Claude can edit multiple files in one response
        - **Task management** - Use built-in task list for tracking work items
        - **IDE integration** - VSCode extension available (chat + inline edits)

    !!! danger "Common Gotchas"
        - **Token limits** - Very long files may be truncated (split into chunks)
        - **Binary files** - Claude can't read images/PDFs directly (describe them)
        - **Destructive commands** - Claude won't run `rm -rf` or force-push without approval
        - **Network access** - No direct internet access (can't fetch URLs for you)
        - **API rate limits** - Free tier has daily message cap, Pro is unlimited
        - **Context drift** - Very long sessions may lose nuance (start fresh if needed)
        - **Hallucinations** - Claude may invent APIs or packages (verify critical code)

    !!! info "When to Use Claude Code vs Copilot"
        - **Use Claude Code for:**
            - Complex refactoring across multiple files
            - Architecture design and planning
            - Debugging with contextual analysis
            - Git workflows and commit messages
            - Learning (Claude explains reasoning)
            - Autonomous multi-step tasks
        - **Use Copilot for:**
            - Inline autocomplete while typing
            - Quick code snippets
            - Boilerplate generation
            - Pattern repetition (similar to existing code)

______________________________________________________________________

## :fontawesome-solid-wrench: Configuration & Customization

### CLAUDE.md Project Instructions

Create a `CLAUDE.md` file in your project root to provide context and guidelines:

```markdown
# CLAUDE.md

## Project Overview
Personal blog built with Gatsby, React, and Markdown. Deployed on Netlify.

## Code Standards
- TypeScript strict mode
- Functional React components (no classes)
- Styled-components for CSS
- ESLint + Prettier (configs in root)
- Jest + React Testing Library for tests

## Architecture
- `/src/components` - Reusable React components
- `/src/pages` - Gatsby page components
- `/content/posts` - Blog posts in Markdown
- `/src/templates` - Post template for rendering

## Commands
- `npm run develop` - Dev server (localhost:8000)
- `npm run build` - Production build
- `npm test` - Run test suite

## Guidelines
- Always write tests for new components
- Use semantic HTML5 elements
- Maintain 90%+ test coverage
- Follow accessibility best practices (WCAG 2.1 AA)

## Deployment
- Push to `main` branch triggers Netlify build
- Preview deploys for PRs
```

### Custom Skills

Create custom skills in `.claude/skills/`:

```bash
# .claude/skills/deploy.skill/SKILL.md
---
name: deploy
description: Deploy application to production
---

# Deploy Skill

Deploys the application to production environment.

## Steps
1. Run test suite (must pass)
2. Build production bundle
3. Run security checks (npm audit)
4. Deploy to hosting platform
5. Verify deployment (health check)
6. Notify team (Slack webhook)

## Usage
/deploy [environment]

## Example
/deploy production
```

### MCP Server Integration

Connect external tools via Model Context Protocol:

```json
// .claude/mcp_config.json
{
  "mcpServers": {
    "postgres": {
      "command": "docker",
      "args": ["run", "-i", "--rm", "postgres:16", "psql"],
      "env": {
        "PGHOST": "localhost",
        "PGDATABASE": "myapp"
      }
    },
    "github": {
      "command": "gh",
      "args": ["api"]
    }
  }
}
```

______________________________________________________________________

## :fontawesome-solid-book: Learning Resources

### :fontawesome-solid-graduation-cap: Official Resources

- **[Claude Code Documentation](https://docs.anthropic.com/claude-code)** - Official docs
- **[Claude AI Documentation](https://docs.anthropic.com/)** - API and concepts
- **[Model Context Protocol](https://modelcontextprotocol.io/)** - MCP specification
- **[GitHub Repository](https://github.com/anthropics/claude-code)** - Source code and issues

### :fontawesome-solid-code: Example Use Cases

!!! example "Development Workflows"
    - **Feature development** - "Implement user authentication with email verification"
    - **Bug fixing** - "Fix the memory leak in the WebSocket connection handler"
    - **Code review** - "Review this PR for security issues and performance problems"
    - **Migration** - "Migrate this Express app to use TypeScript"
    - **Testing** - "Write integration tests for the payment API"

!!! example "DevOps & Automation"
    - **CI/CD** - "Create GitHub Actions workflow for testing and deployment"
    - **Docker** - "Containerize this application with multi-stage build"
    - **Monitoring** - "Add Prometheus metrics to all API endpoints"
    - **Infrastructure** - "Generate Terraform configs for AWS ECS deployment"

!!! example "Documentation & Learning"
    - **README generation** - "Create comprehensive README with installation and usage"
    - **Architecture docs** - "Document the system architecture with diagrams"
    - **Code explanation** - "Explain how the authentication middleware works"
    - **Onboarding** - "Create developer onboarding guide for this codebase"

______________________________________________________________________

## :fontawesome-solid-star: Worth Checking

<div class="grid cards" markdown>

- :fontawesome-solid-book: __Official Docs__

    ______________________________________________________________________

    [Claude Code CLI](https://docs.anthropic.com/claude-code)

    [Claude API Docs](https://docs.anthropic.com/)

    [Prompt Engineering Guide](https://docs.anthropic.com/prompt-library)

    [Model Context Protocol](https://modelcontextprotocol.io/)

- :fontawesome-solid-wrench: __Related Tools__

    ______________________________________________________________________

    [Claude.ai Web Interface](https://claude.ai/)

    [Anthropic API](https://console.anthropic.com/)

    [VSCode Extension](https://marketplace.visualstudio.com/items?itemName=Anthropic.claude-code)

- :fontawesome-solid-code: __Community__

    ______________________________________________________________________

    [GitHub Issues](https://github.com/anthropics/claude-code/issues)

    [Discord Community](https://discord.gg/anthropic)

    [r/ClaudeAI](https://reddit.com/r/ClaudeAI)

- :fontawesome-solid-lightbulb: __Learning__

    ______________________________________________________________________

    [Prompt Engineering Guide](https://www.promptingguide.ai/)

    [Claude Use Cases](https://www.anthropic.com/claude)

    [AI Safety Best Practices](https://www.anthropic.com/safety)

</div>

______________________________________________________________________

**Last Updated:** 2026-02-02 | **Vibe Check:** :fontawesome-solid-rocket: **Game Changer** - Claude Code is the most capable AI coding assistant for complex tasks. Better at architecture, refactoring, and multi-step workflows than alternatives. Requires more guidance than autocomplete tools but produces better results. Free tier is generous, Pro is worth it for serious developers.
**Tags:** claude, ai, cli, coding-assistant, anthropic
