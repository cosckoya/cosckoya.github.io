---
title: MISE
description: Dev tools, env vars, and task runner in one Rust binary — faster asdf replacement without the shims
---

# :lucide-package: MISE

Pronounced "meez" (short for *mise-en-place*). One tool that replaces asdf, direnv, and Make: installs runtimes, loads env vars per project, runs tasks. Written in Rust by [Jeff Dickey (jdx)](https://github.com/jdx/mise) — the guy who got tired of waiting for Bash. 30k+ GitHub stars, ThoughtWorks **Adopt** rating.

!!! tip "2026 Update"
    MISE hit 30.6k stars, 7.4k commits, 1000+ tools in registry. Renamed from rtx in 2024. Fully backward-compatible with `.tool-versions` — zero migration friction. Active development with daily releases (v2026.7.5).

---

## Quick Hits

=== ":lucide-list-check: Essential Commands"

    **Install:**
    ```bash
    curl https://mise.run | sh

    brew install mise           # macOS
    sudo snap install mise      # Linux
    cargo install mise          # From source
    ```

    **Activate in shell:**
    ```bash
    # Add to ~/.zshrc / ~/.bashrc
    eval "$(~/.local/bin/mise activate zsh)"   # or bash, fish, pwsh
    ```

    **Install tools:**
    ```bash
    # One command: plugin + runtime + version — all at once
    mise use node@22
    mise use python@3.12

    # Install from existing .tool-versions or .mise.toml
    mise install

    # List installed / available
    mise ls                 # Installed tools
    mise ls-remote node     # Available versions
    ```

    **Real talk:**

    - `mise use node@22` does everything — no manual plugin add step
    - Reads `.tool-versions` automatically — zero migration from asdf
    - `mise install` installs everything in config at once
    - Use `mise use --global` for system-wide defaults

=== ":lucide-bolt: Common Patterns"

    **`.mise.toml` — tools + env + tasks in one file:**
    ```toml
    [tools]
    node = "22"
    python = "3.12"

    [env]
    NODE_ENV = "development"
    DATABASE_URL = "postgres://localhost/myapp"

    [tasks.build]
    run = "npm run build"

    [tasks.test]
    depends = ["build"]
    run = "pytest"
    ```

    **Env vars:**
    ```bash
    mise set DATABASE_URL=postgres://localhost/myapp
    mise env                   # Show env for current project
    ```

    **Run tasks:**
    ```bash
    mise run test              # Full syntax
    mise build                 # Shorthand if no name conflict
    mise run                   # Selector UI
    ```

    **Why this works:**

    - TOML is readable, git-friendly, supports comments
    - Tasks auto-install required tools before running
    - Replaces asdf + direnv + Makefile with one file

=== ":lucide-flame: Pro Tips & Gotchas"

    **Migration from asdf (zero friction):**
    ```bash
    # .tool-versions works as-is — no changes needed
    cat .tool-versions
    # nodejs 20.11.0
    # python 3.12.1

    # MISE reads it automatically
    mise use node@20   # Or switch to .mise.toml when ready
    ```

    **Security (supply-chain hardening):**
    ```bash
    # Enable Cosign/SLSA verification for aqua-backend tools
    mise settings set trusted_dependencies aqua

    # List what's actually verified
    mise doctor | grep security
    ```

    !!! tip "Performance"
        MISE doesn't use shims. It modifies `PATH` directly, so `node -v` has zero overhead. asdf shims add ~120ms *per call*. On a busy terminal, that savings adds up fast.

    **Tips:**

    - **Fuzzy matching everywhere** — `mise use node@20` works in config files, CLI, and tasks
    - **Auto-install on cd** — entering a project with uninstalled tools triggers automatic install
    - **Backends** — supports asdf, aqua, cargo, npm, pipx, go, gem, ubi, vfox (not just asdf plugins)
    - **Legacy compat** — reads `.nvmrc`, `.node-version`, `.ruby-version` automatically
    - **Self-update** — `mise self-update` keeps you on latest (daily releases)

    **Gotchas:**

    - **brew vs curl** — the brew formula lags slightly behind curl install (use curl for latest)
    - **Shell hook required** — without `eval "$(mise activate ...)"`, tools won't switch
    - **Windows** — no native support (WSL2 works, that's it)
    - **Task name conflicts** — if MISE adds a command you use as a task, use `mise run task-name`
    - **Plugin deps** — some asdf plugins need build tools (Python needs `libssl-dev`, etc.)
    - **Stale cache** — run `mise cache clear` if remote version listings seem out of date

---

## :lucide-link: Resources

**Official:**
- :lucide-book: [MISE Docs](https://mise.en.dev)
- :lucide-github: [GitHub](https://github.com/jdx/mise) — 30.6k stars
- :simple-git-compare: [Comparison to asdf](https://mise.en.dev/dev-tools/comparison-to-asdf.html)

**Install:**
- :lucide-download: [Quick install](https://mise.run) — `curl https://mise.run | sh`
- :lucide-home: [Homebrew](https://formulae.brew.sh/formula/mise) — `brew install mise`
- :lucide-box: [Crates.io](https://crates.io/crates/mise) — `cargo install mise`

**Communities:**
- :lucide-message-circle: [Discord](https://discord.gg/mABnUDvP57)
- :lucide-message-square: [GitHub Discussions](https://github.com/jdx/mise/discussions)
- :simple-x: [X/Twitter @jdxcode](https://x.com/jdxcode) — Creator

**Related:**
- :lucide-wrench: [aube](https://aube.jdx.dev) — Node.js PM by @jdx
- :lucide-wrench: [rtx](https://github.com/jdx/rtx) — Predecessor (renamed to MISE in 2024)

---

**Last Updated:** 2026-07-09 | **Vibe Check:** :lucide-zap: **Rust-Powered Upgrade** - MISE is what asdf should have been from day one. Same plugin ecosystem, zero migration cost, dramatically better performance. If you use asdf, switch. If you don't, start here.

**Tags:** mise, version-manager, rust, dev-tools, task-runner, cli, development-tools
