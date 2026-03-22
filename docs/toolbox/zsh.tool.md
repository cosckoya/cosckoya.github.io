---
title: ZSH + Zinit
description: Z Shell with Zinit plugin manager - fast, powerful shell without oh-my-zsh bloat
---

# :fontawesome-solid-terminal: ZSH + Zinit

Z Shell. Better than Bash, faster than oh-my-zsh. Zinit plugin manager gives you blazing fast startup, lazy loading, and Turbo mode. No bloat, just speed and features.

!!! tip "Why Zinit over Oh-My-ZSH"
    10x faster startup (50ms vs 500ms), lazy loading, Turbo mode, granular control, load only what you need. Oh-My-ZSH loads everything at startup - Zinit loads on demand.

---

## :fontawesome-solid-bolt: Quick Start

=== "Installation"

    **Install ZSH:**
    ```bash
    # macOS (already installed)
    zsh --version

    # Ubuntu/Debian
    sudo apt install zsh

    # Arch Linux
    sudo pacman -S zsh

    # Set as default shell
    chsh -s $(which zsh)
    ```

    **Install Zinit:**
    ```bash
    bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
    ```

    **Verify:**
    ```bash
    # Restart shell or run:
    exec zsh

    # Check zinit
    zinit --help
    ```

=== "Basic Configuration"

    **`~/.zshrc` starter:**

    ```bash
    # ============================================
    # ZINIT SETUP
    # ============================================

    # Enable Powerlevel10k instant prompt (optional)
    if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
      source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
    fi

    # Zinit initialization
    ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
    source "${ZINIT_HOME}/zinit.zsh"

    # ============================================
    # BASIC ZSH OPTIONS
    # ============================================

    # History
    HISTSIZE=10000
    SAVEHIST=10000
    HISTFILE=~/.zsh_history
    setopt HIST_IGNORE_ALL_DUPS
    setopt HIST_FIND_NO_DUPS
    setopt SHARE_HISTORY
    setopt APPEND_HISTORY
    setopt INC_APPEND_HISTORY

    # Directory navigation
    setopt AUTO_CD              # cd by typing directory name
    setopt AUTO_PUSHD           # Push directories to stack
    setopt PUSHD_IGNORE_DUPS    # No duplicate dirs in stack
    setopt PUSHD_SILENT         # Don't print stack

    # Completion
    setopt ALWAYS_TO_END        # Move cursor to end on complete
    setopt AUTO_MENU            # Show completion menu on tab
    setopt COMPLETE_IN_WORD     # Complete from both ends

    # ============================================
    # PLUGINS
    # ============================================

    # Theme (Powerlevel10k)
    zinit ice depth=1
    zinit light romkatv/powerlevel10k

    # Syntax highlighting (must be loaded last)
    zinit light zsh-users/zsh-syntax-highlighting

    # Autosuggestions
    zinit light zsh-users/zsh-autosuggestions

    # Completions
    zinit light zsh-users/zsh-completions

    # History substring search
    zinit light zsh-users/zsh-history-substring-search

    # ============================================
    # KEYBINDINGS
    # ============================================

    # Vi mode
    bindkey -v

    # History search
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down

    # ============================================
    # ALIASES
    # ============================================

    alias ls='ls --color=auto'
    alias ll='ls -lh'
    alias la='ls -lah'
    alias ..='cd ..'
    alias ...='cd ../..'

    # Git aliases
    alias g='git'
    alias gs='git status'
    alias ga='git add'
    alias gc='git commit'
    alias gp='git push'
    alias gl='git pull'
    alias gd='git diff'

    # ============================================
    # COMPLETIONS
    # ============================================

    autoload -Uz compinit
    compinit

    # ============================================
    # INTEGRATIONS
    # ============================================

    # ASDF
    . $HOME/.asdf/asdf.sh

    # Powerlevel10k config
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    ```

=== "Turbo Mode (Fast Loading)"

    **Advanced `.zshrc` with Turbo mode:**

    ```bash
    # Load plugins with Turbo mode (lazy loading)

    # Syntax highlighting (load after 0 seconds, wait mode)
    zinit ice wait lucid atinit"zpcompinit; zpcdreplay"
    zinit light zdharma-continuum/fast-syntax-highlighting

    # Autosuggestions (load immediately, async)
    zinit ice wait lucid atload"_zsh_autosuggest_start"
    zinit light zsh-users/zsh-autosuggestions

    # Completions (turbo load)
    zinit ice wait lucid blockf atpull'zinit creinstall -q .'
    zinit light zsh-users/zsh-completions

    # Additional plugins with turbo
    zinit ice wait lucid
    zinit snippet OMZ::plugins/git/git.plugin.zsh

    zinit ice wait lucid
    zinit snippet OMZ::plugins/docker/docker.plugin.zsh

    zinit ice wait lucid
    zinit snippet OMZ::plugins/kubectl/kubectl.plugin.zsh
    ```

    **Turbo mode explanation:**
    - `wait` - Load after prompt appears
    - `lucid` - Don't show loading messages
    - `atload` - Run command after loading
    - `atinit` - Run command before loading
    - Result: Shell starts in ~50ms, plugins load in background

---

## :fontawesome-solid-box: Essential Plugins

```bash
# ============================================
# THEME
# ============================================

# Powerlevel10k (best performance)
zinit ice depth=1
zinit light romkatv/powerlevel10k

# Pure theme (minimalist alternative)
# zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
# zinit light sindresorhus/pure

# ============================================
# CORE FUNCTIONALITY
# ============================================

# Syntax highlighting (fast fork)
zinit light zdharma-continuum/fast-syntax-highlighting

# Autosuggestions (fish-like)
zinit light zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Completions
zinit light zsh-users/zsh-completions

# History substring search
zinit light zsh-users/zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# ============================================
# PRODUCTIVITY
# ============================================

# fzf (fuzzy finder)
zinit ice from"gh-r" as"program"
zinit light junegunn/fzf
zinit snippet https://github.com/junegunn/fzf/blob/master/shell/completion.zsh
zinit snippet https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh

# bat (better cat)
zinit ice as"program" from"gh-r" mv"bat* -> bat" pick"bat/bat"
zinit light sharkdp/bat

# exa (better ls)
zinit ice as"program" from"gh-r" mv"exa* -> exa"
zinit light ogham/exa
alias ls='exa'
alias ll='exa -l'
alias la='exa -la'

# z (directory jumper)
zinit light agkozak/zsh-z

# ============================================
# OH-MY-ZSH PLUGINS (cherry-pick)
# ============================================

# Git plugin
zinit snippet OMZ::plugins/git/git.plugin.zsh

# Docker plugin
zinit snippet OMZ::plugins/docker/docker.plugin.zsh

# Kubectl plugin
zinit snippet OMZ::plugins/kubectl/kubectl.plugin.zsh

# Terraform plugin
zinit snippet OMZ::plugins/terraform/terraform.plugin.zsh

# ============================================
# DEVELOPMENT TOOLS
# ============================================

# asdf completions
zinit ice wait lucid
zinit snippet OMZ::plugins/asdf/asdf.plugin.zsh

# NVM (if not using asdf)
# zinit ice wait lucid
# zinit snippet OMZ::plugins/nvm/nvm.plugin.zsh
```

---

## :fontawesome-solid-terminal: Zinit Commands

```bash
# Plugin management
zinit self-update              # Update zinit itself
zinit update                   # Update all plugins
zinit update <plugin>          # Update specific plugin
zinit delete <plugin>          # Delete plugin
zinit list                     # List installed plugins

# Performance
zinit times                    # Show plugin load times
zinit report <plugin>          # Show plugin info
zinit compile <plugin>         # Compile plugin for speed

# Debugging
zinit status                   # Show zinit status
zinit analytics                # Show usage analytics
zinit help                     # Show help

# Maintenance
zinit cclear                   # Clear completions
zinit csearch                  # Search for completion
zinit creinstall <plugin>      # Reinstall completions
```

---

## :fontawesome-solid-diagram-project: Powerlevel10k Setup

```bash
# Install Powerlevel10k
zinit ice depth=1
zinit light romkatv/powerlevel10k

# Run configuration wizard
p10k configure

# Reload shell
exec zsh

# Reconfigure anytime
p10k configure
```

**Recommended settings:**
- Prompt style: Rainbow
- Character set: Unicode
- Show current time: 24-hour
- Prompt separators: Angled
- Prompt heads: Sharp
- Prompt tails: Flat
- Prompt height: Two lines
- Prompt connection: Disconnected
- Prompt frame: Left
- Transient prompt: Yes
- Instant prompt: Verbose

---

## :fontawesome-solid-lightbulb: Pro Tips

- **Use Turbo mode** - Shell starts instantly, plugins load in background
- **Cherry-pick OMZ plugins** - Don't load entire framework, just snippets
- **Benchmark startup** - Run `time zsh -i -c exit` to measure
- **Use ice modifiers** - `wait`, `lucid`, `atload` for fine control
- **Compile plugins** - Zinit compiles to native code for speed
- **Lazy load tools** - ASDF, NVM, etc. should load on first use
- **Use `p10k` instant prompt** - Appears before zsh fully loads
- **Profile slow plugins** - Run `zinit times` to find bottlenecks
- **Keep `.zshrc` organized** - Group plugins by category
- **Use `bindkey -v`** - Vi mode for command line editing

---

## :fontawesome-solid-triangle-exclamation: Common Gotchas

- **Slow startup** - Profile with `zinit times`, use Turbo mode
- **Completions not working** - Run `zinit cclear && zinit creinstall -q .`
- **Oh-My-ZSH muscle memory** - Cherry-pick plugins as snippets instead
- **ASDF not loading** - Source after zinit: `. $HOME/.asdf/asdf.sh`
- **Theme not showing** - Install Nerd Font (MesloLGS NF for p10k)
- **Instant prompt warnings** - Move slow commands after `p10k` source
- **Keybindings reset** - Set keybindings after all plugins load
- **History not shared** - Enable `SHARE_HISTORY` and `INC_APPEND_HISTORY`
- **Autosuggestions color** - Set `ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'`

---

## :fontawesome-solid-link: Resources

**Zinit:**
- **[Zinit Wiki](https://github.com/zdharma-continuum/zinit/wiki)** - Complete documentation
- **[GitHub](https://github.com/zdharma-continuum/zinit)** - Source code
- **[Zinit Configs](https://github.com/zdharma-continuum/zinit-configs)** - Example configs

**ZSH:**
- **[ZSH Manual](https://zsh.sourceforge.io/Doc/)** - Official documentation
- **[ZSH Lovers](https://grml.org/zsh/zsh-lovers.html)** - Tips and tricks
- **[Awesome ZSH](https://github.com/unixorn/awesome-zsh-plugins)** - Plugin list

**Themes:**
- **[Powerlevel10k](https://github.com/romkatv/powerlevel10k)** - Fast theme
- **[Pure](https://github.com/sindresorhus/pure)** - Minimalist theme
- **[Starship](https://starship.rs/)** - Cross-shell prompt (alternative)

**Plugins:**
- **[fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting)** - Better highlighting
- **[zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)** - Fish-like suggestions
- **[zsh-completions](https://github.com/zsh-users/zsh-completions)** - Extra completions

**Communities:**
- **[r/zsh](https://reddit.com/r/zsh)** - Reddit community
- **[ZSH Discord](https://discord.gg/zsh)** - Discord server

---

**Last Updated:** 2026-02-03

**Tags:** zsh, zinit, shell, terminal, cli, powerlevel10k, productivity, development-tools
