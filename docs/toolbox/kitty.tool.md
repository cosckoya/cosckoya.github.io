---
title: Kitty
description: GPU-accelerated terminal emulator - fast rendering, tabs, splits, images, ligatures, and scriptable
---

# :lucide-monitor: Kitty

GPU-accelerated terminal emulator. Fast rendering, native tabs/splits, image protocol, ligature support, keyboard-driven. Written in C and Python. No Electron bloat. Renders everything on GPU for instant response.

!!! tip "Why Kitty"
    GPU rendering (smooth scrolling), built-in tabs/splits (no tmux needed), image display, font ligatures, scriptable with Python, cross-platform.
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
