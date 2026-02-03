---
title: TMUX
description: Terminal multiplexer for persistent sessions, split panes, and window management - work survives disconnects
---

# :octicons-stack-16: TMUX

Terminal multiplexer. Split terminals, create windows, detach/reattach sessions. SSH connection drops? Session survives. Long-running processes? Background them. Multiple terminals? One window. The Swiss Army knife of terminal management.

!!! tip "Why TMUX"
    Persistent sessions survive disconnects, split panes for multi-tasking, window management without GUI, pair programming over SSH, scriptable layouts.

---

## :octicons-zap-16: Quick Start

=== "Installation"

    **macOS:**
    ```bash
    brew install tmux
    ```

    **Ubuntu/Debian:**
    ```bash
    sudo apt install tmux
    ```

    **Arch Linux:**
    ```bash
    sudo pacman -S tmux
    ```

    **Verify:**
    ```bash
    tmux -V
    # tmux 3.3a
    ```

=== "Basic Usage"

    **Start session:**
    ```bash
    # New session
    tmux

    # Named session
    tmux new -s work

    # New session with name and window
    tmux new -s dev -n editor
    ```

    **Detach and attach:**
    ```bash
    # Inside tmux, detach with: Ctrl+b then d

    # List sessions
    tmux ls

    # Attach to session
    tmux attach -t work

    # Attach to last session
    tmux a
    ```

    **Kill sessions:**
    ```bash
    # Kill specific session
    tmux kill-session -t work

    # Kill all sessions
    tmux kill-server
    ```

=== "Key Bindings"

    **Prefix key:** `Ctrl+b` (all commands start with this)

    **Session management:**
    - `Ctrl+b d` - Detach session
    - `Ctrl+b $` - Rename session
    - `Ctrl+b s` - List sessions

    **Window management:**
    - `Ctrl+b c` - Create window
    - `Ctrl+b ,` - Rename window
    - `Ctrl+b w` - List windows
    - `Ctrl+b n` - Next window
    - `Ctrl+b p` - Previous window
    - `Ctrl+b 0-9` - Switch to window number
    - `Ctrl+b &` - Kill window

    **Pane management:**
    - `Ctrl+b %` - Split vertically
    - `Ctrl+b "` - Split horizontally
    - `Ctrl+b arrow` - Navigate panes
    - `Ctrl+b o` - Next pane
    - `Ctrl+b x` - Kill pane
    - `Ctrl+b z` - Zoom/unzoom pane
    - `Ctrl+b {` - Move pane left
    - `Ctrl+b }` - Move pane right

    **Copy mode:**
    - `Ctrl+b [` - Enter copy mode
    - `Space` - Start selection
    - `Enter` - Copy selection
    - `Ctrl+b ]` - Paste

---

## :octicons-gear-16: Configuration

**Config file:** `~/.tmux.conf`

```bash
# ============================================
# TMUX CONFIGURATION
# ============================================

# Change prefix from Ctrl+b to Ctrl+a (easier to reach)
unbind C-b
set-option -g prefix C-a
bind-key C-a send-prefix

# Split panes using | and - (more intuitive)
bind | split-window -h
bind - split-window -v
unbind '"'
unbind %

# Switch panes using Alt+arrow without prefix
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D

# Enable mouse mode (tmux 2.1+)
set -g mouse on

# Don't rename windows automatically
set-option -g allow-rename off

# Start windows and panes at 1, not 0
set -g base-index 1
setw -g pane-base-index 1

# Reload config with prefix + r
bind r source-file ~/.tmux.conf \; display "Config reloaded!"

# Increase scrollback buffer
set-option -g history-limit 10000

# Fix colors
set -g default-terminal "screen-256color"
set -ga terminal-overrides ",xterm-256color:Tc"

# Status bar
set -g status-position bottom
set -g status-bg colour234
set -g status-fg colour137
set -g status-left ''
set -g status-right '#[fg=colour233,bg=colour241,bold] %d/%m #[fg=colour233,bg=colour245,bold] %H:%M:%S '
set -g status-right-length 50
set -g status-left-length 20

# Active window title colors
setw -g window-status-current-style 'fg=colour81 bg=colour238 bold'
setw -g window-status-current-format ' #I#[fg=colour250]:#[fg=colour255]#W#[fg=colour50]#F '

# Inactive window title colors
setw -g window-status-style 'fg=colour138 bg=colour235'
setw -g window-status-format ' #I#[fg=colour237]:#[fg=colour250]#W#[fg=colour244]#F '

# Pane border colors
set -g pane-border-style 'fg=colour238'
set -g pane-active-border-style 'fg=colour51'

# Vi mode for copy
setw -g mode-keys vi
bind-key -T copy-mode-vi v send -X begin-selection
bind-key -T copy-mode-vi y send -X copy-selection-and-cancel
```

**Apply configuration:**
```bash
# Reload inside tmux
# Press: Ctrl+b then :
source-file ~/.tmux.conf

# Or use the r binding from config above
# Press: Ctrl+a then r
```

---

## :octicons-workflow-16: Common Workflows

### Development Session

```bash
# Create development session
tmux new -s dev

# Inside tmux:
# Ctrl+b | - Split vertically (code left, terminal right)
# Ctrl+b - - Split horizontally (logs bottom)
# Ctrl+b arrow - Navigate between panes

# Result: 3-pane layout
# +------------------+----------+
# |                  |          |
# |  Code Editor     | Terminal |
# |                  |          |
# +------------------+----------+
# |      Logs / Tests           |
# +-----------------------------+
```

### Remote Server Monitoring

```bash
# SSH to server
ssh user@server

# Start tmux session
tmux new -s monitoring

# Create windows for different services
# Ctrl+b c - New window for logs
# Ctrl+b c - New window for htop
# Ctrl+b c - New window for docker

# Detach (Ctrl+b d) and logout
# SSH back later, reattach: tmux a -t monitoring
```

### Pair Programming

```bash
# Person A creates session
tmux new -s pair

# Person B connects (same user or separate account)
tmux attach -t pair

# Both see the same screen, both can type
# Perfect for remote pair programming
```

---

## :octicons-terminal-16: Advanced Commands

```bash
# Session management
tmux new -s name                    # New named session
tmux attach -t name                 # Attach to session
tmux switch -t name                 # Switch to session
tmux ls                             # List sessions
tmux kill-session -t name           # Kill session
tmux rename-session -t old new      # Rename session

# Window management
tmux new-window -n name             # New named window
tmux select-window -t :0            # Select window by index
tmux rename-window name             # Rename current window
tmux move-window -t :3              # Move window to index 3
tmux swap-window -s 2 -t 1          # Swap windows 2 and 1

# Pane management
tmux split-window -h                # Split horizontal
tmux split-window -v                # Split vertical
tmux select-pane -t :.+             # Select next pane
tmux resize-pane -D 10              # Resize down 10 cells
tmux resize-pane -U 10              # Resize up 10 cells
tmux resize-pane -L 10              # Resize left 10 cells
tmux resize-pane -R 10              # Resize right 10 cells
tmux swap-pane -s 0 -t 1            # Swap panes

# Layouts
tmux select-layout even-horizontal  # Evenly split horizontal
tmux select-layout even-vertical    # Evenly split vertical
tmux select-layout main-horizontal  # Main pane top
tmux select-layout main-vertical    # Main pane left
tmux select-layout tiled            # Tile all panes
```

---

## :octicons-light-bulb-16: Pro Tips

- **Use Ctrl+a prefix** - Easier to reach than Ctrl+b (like GNU Screen)
- **Mouse mode is OK** - Don't let purists shame you, it's convenient
- **Name your sessions** - `tmux new -s project` beats `tmux-0`
- **Use zoom** - `Ctrl+b z` to fullscreen a pane temporarily
- **Copy mode is powerful** - `Ctrl+b [` then navigate with vi keys
- **Detach often** - Long-running tasks? Detach and close terminal
- **Save layouts** - Use scripts to recreate window/pane setups
- **Resurrect plugin** - Save/restore entire tmux environments
- **Synchronize panes** - `Ctrl+b :setw synchronize-panes` - type in all panes at once
- **Use tmuxinator** - Define project layouts in YAML

---

## :octicons-alert-16: Common Gotchas

- **Colors broken** - Set `TERM=screen-256color` or `xterm-256color` in config
- **Nested tmux sessions** - Don't start tmux inside tmux (detach first)
- **Clipboard doesn't work** - Install `reattach-to-user-namespace` (macOS) or `xclip` (Linux)
- **Mouse scroll not working** - Enable mouse mode: `set -g mouse on`
- **Prefix key conflicts** - Ctrl+b conflicts with vim? Change to Ctrl+a
- **Can't resize panes** - Check mouse mode, or use `Ctrl+b arrow` + arrow keys
- **Session persists after reboot** - Use tmux-continuum plugin for auto-save/restore
- **Status bar ugly** - Use powerline or tmux themes (tokyo-night, dracula)
- **Too many sessions** - Run `tmux ls`, clean up with `tmux kill-session -t name`

---

## :octicons-link-16: Resources

**Official:**
- **[TMUX Manual](https://man7.org/linux/man-pages/man1/tmux.1.html)** - Complete reference
- **[GitHub](https://github.com/tmux/tmux)** - Source code and issues
- **[Wiki](https://github.com/tmux/tmux/wiki)** - Community wiki

**Plugins:**
- **[TPM (Tmux Plugin Manager)](https://github.com/tmux-plugins/tpm)** - Plugin manager
- **[tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect)** - Save/restore sessions
- **[tmux-continuum](https://github.com/tmux-plugins/tmux-continuum)** - Auto-save sessions
- **[tmux-sensible](https://github.com/tmux-plugins/tmux-sensible)** - Sensible defaults

**Tools:**
- **[tmuxinator](https://github.com/tmuxinator/tmuxinator)** - Manage complex tmux sessions
- **[tmuxp](https://github.com/tmux-python/tmuxp)** - Python-based tmux session manager

**Learning:**
- **[tmux Cheat Sheet](https://tmuxcheatsheet.com/)** - Quick reference
- **[The Tao of tmux](https://leanpub.com/the-tao-of-tmux)** - Free book

**Communities:**
- **[r/tmux](https://reddit.com/r/tmux)** - Reddit community

---

**Last Updated:** 2026-02-03

**Tags:** tmux, terminal-multiplexer, terminal, cli, session-management, development-tools, productivity
