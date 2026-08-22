---
title: mise
description: Polyglot tool-version manager — one Rust binary replacing nvm, pyenv, rbenv, tfenv and friends on Linux
---

# :lucide-boxes: mise

Every language ecosystem invented its own version manager, so you ended up juggling nvm, pyenv, rbenv, and tfenv like a circus act. mise (formerly rtx) fires them all: one Rust binary that pins any tool version per project or globally, reads a single committed config, and throws in a task runner for free. Install it once, stop thinking about which toolchain is active ever again.

!!! tip "2026 Update"
    mise ships calendar-versioned releases (2026.x.x) and has become the pragmatic default on Linux boxes. Its backend registry covers hundreds of tools — including everything in the DevSecOps section — through native, aqua, cargo, npm, pipx, and asdf-compatible sources.

---

## Quick Hits

=== ":lucide-list-check: Essential Commands"

    ```bash
    # Install — lands in ~/.local/bin, no root required
    curl https://mise.run | sh                              # (1)!

    # Activate for zsh (add to ~/.zshrc)
    echo 'eval "$(mise activate zsh)"' >> ~/.zshrc          # (2)!

    # Global tool installs
    mise use -g node@22 python@3.14                         # (3)!

    # See what is installed and active here
    mise ls                                                 # (4)!

    # Upgrade everything mise manages
    mise up                                                 # (5)!
    ```

    1. Single static binary; the install script never touches system packages.
    2. Activation hooks your shell PATH per directory — bash users swap `zsh` for `bash`.
    3. `-g` writes to `~/.config/mise/config.toml`; omit it to pin inside the current project instead.
    4. Shows installed versions plus which one is active for this directory.
    5. Short for upgrade; run it periodically or pin deliberately and skip it.

    **Real talk:**

    - Activation is not optional decoration — without it, mise-managed binaries are not on PATH.
    - Trust prompts exist for a reason: review unknown `.mise.toml` files before accepting.
    - `mise doctor` diagnoses PATH problems faster than staring at dotfiles.

=== ":lucide-bolt: Common Patterns"

    Pin an entire toolchain for a project in one committed file:

    ```toml
    # .mise.toml — commit this
    [tools]
    terraform = "1.15"
    tflint = "0.64"
    python = "3.14"

    [tasks.lint]
    run = ["terraform fmt -check -recursive", "tflint --recursive"]
    ```

    Then everyone — humans and CI — gets identical versions:

    ```bash
    mise use terraform@1.15.8 tflint@0.64   # writes the block above

    # CI bootstrap is one line
    mise install

    # Run project tasks
    mise run lint
    ```

    **Why this works:**

    - One file pins every tool, so laptop and pipeline cannot drift apart.
    - `mise install` is idempotent — safe at the top of any CI job.
    - Tasks replace Makefile boilerplate for dev commands while keeping real builds where they belong.

=== ":material-fire: Pro Tips & Gotchas"

    **Tips:**

    - `mise x -- terraform plan` runs any command with the project's tools without permanent activation.
    - Version strings accept partial pins — `"0.64"` tracks the newest 0.64.x patch.
    - Backends matter for speed: aqua and native downloads beat asdf-plugin builds.

    **Gotchas:**

    - Do not mix activation with manually adding the shims dir to PATH — pick one mechanism or fight ghosts.
    - IDE integrated terminals do not inherit activation automatically; configure them or run `mise activate` there too.
    - Tools installed through legacy asdf plugins compile from source more often than you would like.

---

## Reference

**Documentation:**

- :lucide-book: [mise Docs](https://mise.jdx.dev)
- :simple-github: [jdx/mise](https://github.com/jdx/mise)

**Related:**

- :lucide-wrench: __Terraform__
- :lucide-wrench: __tflint__

---

**Last Updated:** 2026-08-22 | **Vibe Check:** :lucide-globe: **Single Point of Truth** - One manager, one config file, zero version drift between machines.

**Tags:** tools, linux, version-manager
