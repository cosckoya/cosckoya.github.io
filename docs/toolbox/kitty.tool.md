---
title: Kitty
description: GPU-accelerated terminal emulator - fast rendering, tabs, splits, images, ligatures, and scriptable
---

# :lucide-monitor: Kitty

GPU-accelerated terminal emulator. Fast rendering, native tabs/splits, image protocol, ligature support, keyboard-driven. Written in C and Python. No Electron bloat. Renders everything on GPU for instant response.

!!! tip "Why Kitty"
    GPU rendering (smooth scrolling), built-in tabs/splits (no tmux needed), image display, font ligatures, scriptable with Python, cross-platform.

## Quick Hits

=== ":lucide-list-check: Essential Commands"

    **macOS:**
    ```bash
    brew install --cask kitty
    ```

    **Ubuntu/Debian:**
    ```bash
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

    # Create desktop entry
    ln -sf ~/.local/kitty.app/bin/kitty ~/.local/bin/
    cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
    ```

    **Arch Linux:**
    ```bash
    sudo pacman -S kitty
    ```

    **From source:**
    ```bash
    git clone https://github.com/kovidgoyal/kitty
    cd kitty
    make
    ```

    **Verify:**
    ```bash
    kitty --version
    # kitty 0.32.0
    ```

=== ":lucide-bolt: Common Patterns"

    **Launch:**
    ```bash
    # Default
    kitty

    # With specific config
    kitty --config /path/to/kitty.conf

    # Single instance mode
    kitty --single-instance

    # With command
    kitty nvim
    ```

    **Key bindings (default):**
    - `Ctrl+Shift+Enter` - New window
    - `Ctrl+Shift+T` - New tab
    - `Ctrl+Shift+Q` - Close window/tab
    - `Ctrl+Shift+Right/Left` - Next/previous tab
    - `Ctrl+Shift+[` - Previous window
    - `Ctrl+Shift+]` - Next window
    - `Ctrl+Shift+F` - Search scrollback
    - `Ctrl+Shift+L` - Layout selector

=== ":lucide-flame: Pro Tips & Gotchas"

    **Config essentials (`~/.config/kitty/kitty.conf`):**

    ```bash
    font_family      JetBrains Mono
    font_size        13.0
    cursor_shape     block
    scrollback_lines 10000
    window_padding_width  5
    tab_bar_style    powerline
    enable_audio_bell no
    ```

    Full config templates: [kitty-themes](https://github.com/dexpota/kitty-themes), [Catppuccin Kitty](https://github.com/catppuccin/kitty)

    **Tips:**
    - **`kitty +kitten ssh`** — SSH with full shell integration (image display, URL hints)
    - **`Ctrl+Shift+E`** — URL hints: highlights links/paths on screen; type to open
    - **`kitty --single-instance`** — opens new windows in existing instance
    - **Custom kittens** — write Python scripts for custom keybindings/automation
    - **Remote control** — `allow_remote_control yes` + `kitty @` for scripting from outside

    **Gotchas:**
    - **Font not found** — Install Nerd Fonts or JetBrains Mono
    - **Colors wrong** — Set `TERM=xterm-kitty` in shell config
    - **Clipboard broken** — Install `xclip` or `xsel` on Linux
    - **Images not showing over SSH** — Use `kitty +kitten ssh`, not plain SSH

---

## :lucide-star: Project & Author

| Aspect | Detail |
|--------|--------|
| **Author** | [Kovid Goyal](https://kovidgoyal.net/) — also created [calibre](https://calibre-ebook.com/) (the e-book manager, 200k+ stars) |
| **License** | GPL-3.0 |
| **Language** | C (renderer) + Python (kittens, tooling) |
| **Stars** | ~25k |
| **Since** | 2017 (initial release), actively maintained |
| **Philosophy** | GPU-accelerated rendering, keyboard-driven, scriptable. No Electron. No web tech. Just a terminal. |

Kovid Goyal built Kitty because existing terminals couldn't keep up with his needs — smooth scrolling, image display, and real keyboard control. He's been maintaining it solo alongside calibre for years. The result is one of the fastest, most feature-rich terminals available.

---

## :lucide-compass: Ecosystem & Customization

**Alternatives worth knowing:**

| Terminal | Why consider | Trade-off |
|----------|-------------|-----------|
| **Kitty** | GPU rendering, image protocol, kittens | Python-based kittens (slower than compiled plugins) |
| **[Alacritty](https://alacritty.org/)** | GPU-accelerated, Rust, minimal | No tabs/splits (needs tmux), no images |
| **[WezTerm](https://wezfurlong.org/wezterm/)** | GPU-accelerated, Lua config, multiplexer | Heavier dependency tree, fewer themes |
| **[Foot](https://codeberg.org/dnkl/foot)** | Wayland-native, minimal, fast | Linux-only, no GPU |

**Customization ecosystem:**
<div class="ref-cards" markdown>

- :lucide-palette: [kitty-themes](https://github.com/dexpota/kitty-themes) — 200+ community themes (Catppuccin, Tokyo Night, etc.)
- :lucide-refresh-ccw: [Theme switcher](https://sw.kovidgoyal.net/kitty/kittens/themes/) — Built-in `kitty +kitten themes` browser
- :lucide-git-compare: [Diff tool](https://sw.kovidgoyal.net/kitty/kittens/diff/) — Side-by-side image-aware `kitty +kitten diff`
- :lucide-clipboard: [Clipboard](https://sw.kovidgoyal.net/kitty/kittens/clipboard/) — History-aware `kitty +kitten clipboard`

</div>

**Notable integrations:**
<div class="ref-cards" markdown>

- :lucide-code: [image.nvim](https://github.com/3rd/image.nvim) — Display images inline in Kitty + Neovim
- :lucide-folder: [Ranger](https://github.com/ranger/ranger) — File manager with image preview protocol
- :lucide-terminal: [Kitty SSH](https://sw.kovidgoyal.net/kitty/ssh/) — `kitty +kitten ssh` preserves all terminal features remotely

</div>

---

## :lucide-link: Resources

**Official:**
<div class="ref-cards" markdown>

- :lucide-book: [Kitty Documentation](https://sw.kovidgoyal.net/kitty/) — Complete reference
- :lucide-github: [GitHub](https://github.com/kovidgoyal/kitty) — Source, issues, discussions
- :lucide-history: [Changelog](https://sw.kovidgoyal.net/kitty/changelog/) — Version history

</div>

**Themes:**
<div class="ref-cards" markdown>

- :lucide-palette: [kitty-themes](https://github.com/dexpota/kitty-themes) — 200+ community themes
- :lucide-palette: [Catppuccin Kitty](https://github.com/catppuccin/kitty) — Pastel theme port
- :lucide-palette: [Tokyo Night Kitty](https://github.com/davidmathers/tokyo-night-kitty-theme) — Popular dark theme

</div>

**Learning:**
<div class="ref-cards" markdown>

- :lucide-book-open: [Kitty Config Reference](https://sw.kovidgoyal.net/kitty/conf/) — All config options
- :lucide-terminal: [Kitty SSH Tutorial](https://sw.kovidgoyal.net/kitty/ssh/) — Remote setup guide
- :lucide-code: [Kitten Tutorial](https://sw.kovidgoyal.net/kitty/kittens/custom/) — Write your own kittens

</div>

**Communities:**
<div class="ref-cards" markdown>

- :lucide-message-square: [GitHub Discussions](https://github.com/kovidgoyal/kitty/discussions) — Official Q&A
- :lucide-reddit: [r/KittyTerminal](https://reddit.com/r/KittyTerminal) — User showcase, configs, themes

</div>

---

**Last Updated:** 2026-06-01 | **Vibe Check:** :lucide-tv: **GPU-Accelerated Power** - Fastest terminal emulator with GPU rendering. Built-in image display, tabs, and kitten remote control. Excellent font rendering and ligature support. If you live in the terminal, kitty makes everything feel instant.

**Tags:** kitty, terminal-emulator, terminal, gpu-accelerated, terminal, cli, productivity, development-tools
