---
title: TMUX
description: Terminal multiplexer for persistent sessions, split panes, and window management - work survives disconnects
---

# :lucide-layers: TMUX

Terminal multiplexer. Split terminals, create windows, detach/reattach sessions. SSH connection drops? Session survives. Long-running processes? Background them. Multiple terminals? One window. The Swiss Army knife of terminal management.

!!! tip "Why TMUX"
    Persistent sessions survive disconnects, split panes for multi-tasking, window management without GUI, pair programming over SSH, scriptable layouts.
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
