---
title: ASDF
description: Universal version manager for multiple runtime versions - one tool to rule them all (Node, Python, Ruby, Go, etc.)
---

# :octicons-versions-16: ASDF

Universal version manager. Manage Node, Python, Ruby, Go, Rust, Java versions with one tool. No more nvm, pyenv, rbenv, goenv chaos. One `.tool-versions` file, one command interface, done.

!!! tip "Why ASDF"
    Single tool for all languages, project-specific versions via `.tool-versions`, shell-agnostic, plugin ecosystem for 300+ runtimes.

---

## :fontawesome-solid-bolt: Quick Start

=== "Installation"

    **macOS:**
    ```bash
    brew install asdf

    # Add to shell (ZSH example)
    echo '. $(brew --prefix asdf)/libexec/asdf.sh' >> ~/.zshrc
    source ~/.zshrc
    ```

    **Linux (Git):**
    ```bash
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0

    # ZSH
    echo '. $HOME/.asdf/asdf.sh' >> ~/.zshrc

    # Bash
    echo '. $HOME/.asdf/asdf.sh' >> ~/.bashrc

    # Reload shell
    source ~/.zshrc  # or ~/.bashrc
    ```

    **Verify:**
    ```bash
    asdf --version
    # asdf 0.14.0
    ```

=== "Basic Usage"

    **Install a plugin:**
    ```bash
    # List all available plugins
    asdf plugin list all

    # Add Node.js plugin
    asdf plugin add nodejs

    # Add Python plugin
    asdf plugin add python

    # Add common plugins
    asdf plugin add golang
    asdf plugin add rust
    asdf plugin add terraform
    ```

    **Install a version:**
    ```bash
    # List all available versions
    asdf list all nodejs

    # Install specific version
    asdf install nodejs 20.11.0

    # Install latest
    asdf install nodejs latest

    # Install LTS
    asdf install nodejs lts
    ```

    **Set versions:**
    ```bash
    # Global (all projects)
    asdf global nodejs 20.11.0

    # Local (current project - creates .tool-versions)
    asdf local nodejs 20.11.0

    # Shell session only
    asdf shell nodejs 20.11.0
    ```

=== "Project Configuration"

    **`.tool-versions` file:**

    ```bash
    # In project root
    nodejs 20.11.0
    python 3.12.1
    golang 1.21.6
    terraform 1.7.0
    ```

    **Create from current versions:**
    ```bash
    cd ~/project
    asdf local nodejs 20.11.0
    asdf local python 3.12.1
    # .tool-versions now contains both
    ```

    **Install all project versions:**
    ```bash
    # In project with .tool-versions
    asdf install
    ```

    **Real talk:**
    - Commit `.tool-versions` to git
    - Team gets same versions automatically
    - CI/CD can use same file
    - No more "works on my machine"

---

## :fontawesome-solid-box: Common Plugins

### Essential Runtimes

```bash
# Node.js
asdf plugin add nodejs
asdf install nodejs latest
asdf global nodejs latest

# Python
asdf plugin add python
asdf install python 3.12.1
asdf global python 3.12.1

# Go
asdf plugin add golang
asdf install golang 1.21.6
asdf global golang 1.21.6

# Rust
asdf plugin add rust
asdf install rust 1.75.0
asdf global rust 1.75.0

# Ruby
asdf plugin add ruby
asdf install ruby 3.3.0
asdf global ruby 3.3.0
```

### Infrastructure Tools

```bash
# Terraform
asdf plugin add terraform
asdf install terraform 1.7.0

# Kubectl
asdf plugin add kubectl
asdf install kubectl 1.29.0

# Helm
asdf plugin add helm
asdf install helm 3.14.0

# AWS CLI
asdf plugin add awscli
asdf install awscli latest

# Terraform
asdf plugin add terragrunt
asdf install terragrunt latest
```

---

## :fontawesome-solid-terminal: Essential Commands

```bash
# Plugin management
asdf plugin list                    # List installed plugins
asdf plugin list all                # List all available plugins
asdf plugin add <name>              # Install plugin
asdf plugin update <name>           # Update plugin
asdf plugin remove <name>           # Remove plugin

# Version management
asdf list all <plugin>              # List all available versions
asdf list <plugin>                  # List installed versions
asdf install <plugin> <version>     # Install specific version
asdf install <plugin> latest        # Install latest version
asdf uninstall <plugin> <version>   # Uninstall version
asdf install                        # Install all from .tool-versions

# Setting versions
asdf global <plugin> <version>      # Set global version
asdf local <plugin> <version>       # Set project version (.tool-versions)
asdf shell <plugin> <version>       # Set shell session version
asdf current                        # Show current versions
asdf current <plugin>               # Show current version for plugin

# Utility
asdf which <command>                # Show path to command
asdf where <plugin> <version>       # Show install path for version
asdf reshim <plugin> <version>      # Recreate shims
asdf update                         # Update asdf itself
```

---

## :fontawesome-solid-diagram-project: Common Workflows

### New Project Setup

```bash
# 1. Create project
mkdir my-project && cd my-project

# 2. Set versions
asdf local nodejs 20.11.0
asdf local python 3.12.1

# 3. Verify .tool-versions created
cat .tool-versions
# nodejs 20.11.0
# python 3.12.1

# 4. Commit to git
git add .tool-versions
git commit -m "Add runtime versions"
```

### Joining Existing Project

```bash
# 1. Clone repo
git clone <repo-url>
cd project

# 2. Check .tool-versions
cat .tool-versions

# 3. Install all required versions
asdf install

# 4. Verify versions
asdf current
```

### Multiple Python Projects

```bash
# Project A - Python 3.11
cd ~/project-a
asdf local python 3.11.7
python --version  # 3.11.7

# Project B - Python 3.12
cd ~/project-b
asdf local python 3.12.1
python --version  # 3.12.1

# Automatic switching when changing directories
```

---

## :fontawesome-solid-lightbulb: Pro Tips

- **Use `latest` carefully** - Pin exact versions in production projects
- **Reshim after global installs** - Run `asdf reshim` if commands not found
- **Legacy version files** - ASDF reads `.nvmrc`, `.node-version`, `.ruby-version` automatically
- **Install dependencies first** - Some plugins need build tools (Python needs `libssl-dev`, etc.)
- **Update plugins regularly** - `asdf plugin update --all`
- **Check plugin docs** - Each plugin has specific requirements: `asdf plugin list all | grep <name>`
- **Use shell integration** - Auto-completion available for ZSH/Bash/Fish
- **Global defaults** - Set sensible global versions for new projects
- **CI/CD integration** - Use `.tool-versions` in build scripts

---

## :fontawesome-solid-triangle-exclamation: Common Gotchas

- **Command not found after install** - Run `asdf reshim <plugin>`
- **Python build fails** - Install build dependencies: `sudo apt install build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev`
- **Node.js GPG errors** - Import Node.js release team keys (plugin handles this usually)
- **Slow installs** - Some languages compile from source (Python, Ruby), use precompiled when available
- **Wrong version used** - Check order: shell → local → global (`.tool-versions` in closest parent dir wins)
- **Shims not working** - Ensure ASDF is sourced in shell config AFTER other version managers
- **Plugin not found** - Update plugin repository: `asdf plugin update --all`
- **Version conflicts** - Remove old version managers (nvm, pyenv, rbenv) from shell config

---

## :fontawesome-solid-link: Resources

**Official:**
- **[ASDF Docs](https://asdf-vm.com/)** - Official documentation
- **[GitHub](https://github.com/asdf-vm/asdf)** - Source code and issues
- **[Plugin Registry](https://github.com/asdf-vm/asdf-plugins)** - All available plugins

**Common Plugins:**
- **[nodejs](https://github.com/asdf-vm/asdf-nodejs)** - Node.js plugin
- **[python](https://github.com/asdf-community/asdf-python)** - Python plugin
- **[golang](https://github.com/asdf-community/asdf-golang)** - Go plugin
- **[rust](https://github.com/asdf-community/asdf-rust)** - Rust plugin
- **[terraform](https://github.com/asdf-community/asdf-hashicorp)** - Terraform/Vault/etc.

**Communities:**
- **[GitHub Discussions](https://github.com/asdf-vm/asdf/discussions)** - Official forum
- **[r/asdf](https://reddit.com/r/asdf)** - Reddit community

---

**Last Updated:** 2026-02-03

**Tags:** asdf, version-manager, nodejs, python, golang, rust, ruby, development-tools, cli, runtime
