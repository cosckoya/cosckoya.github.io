---
title: TMUX
description: Terminal multiplexer for persistent sessions, split panes, and window management - work survives disconnects
---

# :lucide-layers: TMUX

Terminal multiplexer. Split terminals, create windows, detach/reattach sessions. SSH connection drops? Session survives. Long-running processes? Background them. Multiple terminals? One window. The Swiss Army knife of terminal management.

!!! tip "Why TMUX"
    Persistent sessions survive disconnects, split panes for multi-tasking, window management without GUI, pair programming over SSH, scriptable layouts.

## Quick Hits

=== ":lucide-list-check: Essential Commands"

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

=== ":lucide-bolt: Common Patterns"

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

=== ":lucide-flame: Pro Tips & Gotchas"

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
    
    **Pro Tips:**
    
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
    
    **Common Gotchas:**
    
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

## :lucide-star: Project & Author

| Aspect | Detail |
|--------|--------|
| **Creator** | [Nicholas Marriott](https://github.com/nicm) — original author, active maintainer |
| **Current maintainer** | [Thomas Adam](https://github.com/thomasadam) — primary maintainer since 2020 |
| **License** | ISC (permissive, similar to MIT) |
| **Language** | C |
| **Stars** | ~35k |
| **Since** | 2007 (initial release), actively maintained |
| **History** | tmux was created because GNU Screen was stagnant. Nicholas wanted a modern, BSD-licensed alternative with proper 256-color support and a clean codebase. It's now the de-facto terminal multiplexer for Unix systems. |

---

## :lucide-compass: Ecosystem & Customization

**Alternatives:**

| Tool | Why consider | Trade-off |
|------|-------------|-----------|
| **tmux** | Standard, runs everywhere, huge ecosystem | Old codebase, C is hard to contribute to |
| **[Zellij](https://zellij.dev/)** | Rust, layout system, plugin system | Newer, smaller ecosystem |
| **[screen](https://www.gnu.org/software/screen/)** | Ships with every Linux distro | Ancient, no 256-color by default |

**Plugin ecosystem (TPM):**
<div class="ref-cards" markdown>

- :lucide-puzzle: [TPM](https://github.com/tmux-plugins/tpm) — Plugin manager (essential)
- :lucide-refresh-ccw: [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect) — Save/restore sessions across reboots
- :lucide-clock: [tmux-continuum](https://github.com/tmux-plugins/tmux-continuum) — Auto-save every 15 minutes
- :lucide-settings: [tmux-sensible](https://github.com/tmux-plugins/tmux-sensible) — Sensible defaults everyone should use
- :lucide-clipboard: [tmux-yank](https://github.com/tmux-plugins/tmux-yank) — System clipboard integration

</div>

**Notable configs & themes:**
<div class="ref-cards" markdown>

- :lucide-star: [gpakosz/.tmux](https://github.com/gpakosz/.tmux) — Most popular tmux config (12k+ stars)
- :lucide-palette: [tmux-themepack](https://github.com/jimeh/tmux-themepack) — Status bar themes
- :lucide-palette: [dracula/tmux](https://github.com/dracula/tmux) — Dracula theme status bar
- :lucide-palette: [catppuccin/tmux](https://github.com/catppuccin/tmux) — Catppuccin theme

</div>

**Session managers:**
<div class="ref-cards" markdown>

- :lucide-wrench: [tmuxinator](https://github.com/tmuxinator/tmuxinator) — YAML-defined project layouts
- :lucide-wrench: [tmuxp](https://github.com/tmux-python/tmuxp) — Python session manager (works with tmuxinator files)

</div>

---

## :lucide-link: Resources

**Official:**
<div class="ref-cards" markdown>

- :lucide-book: [TMUX Manual](https://man7.org/linux/man-pages/man1/tmux.1.html) — Complete reference
- :lucide-github: [GitHub](https://github.com/tmux/tmux) — Source, issues, releases
- :lucide-wiki: [Wiki](https://github.com/tmux/tmux/wiki) — FAQ, tips, troubleshooting

</div>

**Learning:**
<div class="ref-cards" markdown>

- :lucide-book-open: [The Tao of tmux](https://leanpub.com/the-tao-of-tmux) — Free book by Tony Narlock
- :lucide-list: [tmux Cheat Sheet](https://tmuxcheatsheet.com/) — Quick visual reference
- :lucide-terminal: [tmux Guide](https://github.com/tmux/tmux/wiki/Getting-Started) — Official getting started

</div>

**Tools:**
<div class="ref-cards" markdown>

- :lucide-wrench: [tmuxinator](https://github.com/tmuxinator/tmuxinator) — YAML session manager
- :lucide-wrench: [tmuxp](https://github.com/tmux-python/tmuxp) — Python session manager
- :lucide-palette: [tmux-themepack](https://github.com/jimeh/tmux-themepack) — Status bar themes
- :lucide-puzzle: [TPM](https://github.com/tmux-plugins/tpm) — Plugin manager

</div>

**Communities:**
<div class="ref-cards" markdown>

- :lucide-reddit: [r/tmux](https://reddit.com/r/tmux) — Config showcases, troubleshooting
- :lucide-message-square: [GitHub Issues](https://github.com/tmux/tmux/issues) — Bug reports, feature requests

</div>

---

**Last Updated:** 2026-06-01 | **Vibe Check:** :lucide-window: **Terminal Multiplexer Essential** - TMUX is the difference between a terminal and a terminal *workstation*. Persistent sessions survive SSH disconnects. Split panes, window management, copy mode with vim bindings. Non-negotiable for remote development.

**Tags:** tmux, terminal-multiplexer, terminal, cli, session-management, development-tools, productivity
