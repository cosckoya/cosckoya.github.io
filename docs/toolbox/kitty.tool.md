---
title: Kitty
description: GPU-accelerated terminal emulator - fast rendering, tabs, splits, images, ligatures, and scriptable
---

# :fontawesome-solid-desktop: Kitty

GPU-accelerated terminal emulator. Fast rendering, native tabs/splits, image protocol, ligature support, keyboard-driven. Written in C and Python. No Electron bloat. Renders everything on GPU for instant response.

!!! tip "Why Kitty"
    GPU rendering (smooth scrolling), built-in tabs/splits (no tmux needed), image display, font ligatures, scriptable with Python, cross-platform.

---

## :fontawesome-solid-bolt: Quick Start

=== "Installation"

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

=== "Basic Usage"

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

=== "Configuration"

    **Config location:** `~/.config/kitty/kitty.conf`

    **Basic config:**
    ```bash
    # ============================================
    # KITTY CONFIGURATION
    # ============================================

    # Font
    font_family      JetBrains Mono
    bold_font        auto
    italic_font      auto
    bold_italic_font auto
    font_size        13.0

    # Font features
    disable_ligatures never

    # Cursor
    cursor_shape block
    cursor_blink_interval 0

    # Scrollback
    scrollback_lines 10000

    # Mouse
    mouse_hide_wait 3.0
    url_color #0087bd
    url_style curly

    # Window
    remember_window_size  yes
    initial_window_width  1200
    initial_window_height 800
    window_padding_width  5

    # Tabs
    tab_bar_edge top
    tab_bar_style powerline
    tab_powerline_style slanted

    # Terminal bell
    enable_audio_bell no
    visual_bell_duration 0.0

    # Color scheme (Tokyo Night Storm)
    background #24283b
    foreground #c0caf5
    selection_background #2e3c64
    selection_foreground #c0caf5
    cursor #c0caf5
    cursor_text_color #1a1b26

    # Black
    color0 #1d202f
    color8 #4e5173

    # Red
    color1 #f7768e
    color9 #f7768e

    # Green
    color2  #9ece6a
    color10 #9ece6a

    # Yellow
    color3  #e0af68
    color11 #e0af68

    # Blue
    color4  #7aa2f7
    color12 #7aa2f7

    # Magenta
    color5  #bb9af7
    color13 #bb9af7

    # Cyan
    color6  #7dcfff
    color14 #7dcfff

    # White
    color7  #a9b1d6
    color15 #c0caf5

    # ============================================
    # KEYBINDINGS
    # ============================================

    # Window management
    map ctrl+shift+enter new_window
    map ctrl+shift+w close_window
    map ctrl+shift+] next_window
    map ctrl+shift+[ previous_window

    # Tab management
    map ctrl+shift+t new_tab
    map ctrl+shift+q close_tab
    map ctrl+shift+right next_tab
    map ctrl+shift+left previous_tab
    map ctrl+shift+. move_tab_forward
    map ctrl+shift+, move_tab_backward

    # Layouts
    map ctrl+shift+l next_layout
    map ctrl+shift+alt+t goto_layout tall
    map ctrl+shift+alt+s goto_layout stack

    # Font size
    map ctrl+shift+equal change_font_size all +1.0
    map ctrl+shift+minus change_font_size all -1.0
    map ctrl+shift+0 change_font_size all 0

    # Scrollback
    map ctrl+shift+k show_scrollback

    # Search
    map ctrl+shift+f show_scrollback

    # Copy/Paste
    map ctrl+shift+c copy_to_clipboard
    map ctrl+shift+v paste_from_clipboard

    # ============================================
    # PERFORMANCE
    # ============================================

    repaint_delay 10
    input_delay 3
    sync_to_monitor yes
    ```

---

## :fontawesome-solid-paintbrush: Themes & Color Schemes

### Popular Themes

```bash
# Tokyo Night
# https://github.com/davidmathers/tokyo-night-kitty-theme

# Dracula
# https://draculatheme.com/kitty

# Catppuccin
# https://github.com/catppuccin/kitty

# Nord
# https://www.nordtheme.com/ports/kitty

# Gruvbox
# https://github.com/morhetz/gruvbox
```

### Install Theme

```bash
# Clone themes repository
git clone --depth 1 https://github.com/dexpota/kitty-themes.git ~/.config/kitty/kitty-themes

# Link theme
ln -sf ~/.config/kitty/kitty-themes/themes/tokyo_night.conf ~/.config/kitty/theme.conf

# Include in kitty.conf
echo "include ./theme.conf" >> ~/.config/kitty/kitty.conf
```

### Switch Themes

```bash
# Create theme switcher alias in .zshrc
alias kitty-theme='kitty +kitten themes'

# Run theme browser
kitty-theme
```

---

## :fontawesome-solid-box: Kittens (Plugins)

**Built-in kittens:**

```bash
# Diff files with image support
kitty +kitten diff file1.txt file2.txt

# Browse themes
kitty +kitten themes

# Show unicode input
kitty +kitten unicode_input

# Show clipboard history
kitty +kitten clipboard

# SSH with shell integration
kitty +kitten ssh user@host

# Transfer files over SSH
kitty +kitten transfer file.txt user@host:/path/
```

**Custom kitten example (`~/.config/kitty/search.py`):**

```python
from kitty.fast_data_types import send_text_to_child
from kittens.tui.handler import result_handler

def main(args):
    pass

@result_handler(no_ui=True)
def handle_result(args, answer, target_window_id, boss):
    search_term = ' '.join(args[1:])
    url = f'https://www.google.com/search?q={search_term}'
    send_text_to_child(target_window_id, f'open {url}\n')
```

---

## :fontawesome-solid-diagram-project: Layouts

**Built-in layouts:**

```bash
# Stack - One window fills screen
map ctrl+shift+alt+s goto_layout stack

# Tall - One window left, others stacked right
map ctrl+shift+alt+t goto_layout tall

# Fat - One window top, others stacked bottom
map ctrl+shift+alt+f goto_layout fat

# Grid - All windows in grid
map ctrl+shift+alt+g goto_layout grid

# Horizontal - All windows side by side
map ctrl+shift+alt+h goto_layout horizontal

# Vertical - All windows stacked vertically
map ctrl+shift+alt+v goto_layout vertical

# Splits - Custom splits
map ctrl+shift+alt+\ goto_layout splits
```

**Custom layout example:**

```bash
# In kitty.conf
enabled_layouts splits:split_axis=horizontal

# Create splits with commands
# Ctrl+Shift+Enter creates split in current layout
```

---

## :fontawesome-solid-image: Image Display

**Display images in terminal:**

```bash
# Using built-in icat kitten
kitty +kitten icat image.png

# With size limit
kitty +kitten icat --align=left image.png

# Clear images
kitty +kitten icat --clear

# In Python scripts
from kitty.images import ImageManager
im = ImageManager()
im.display('/path/to/image.png')
```

**Use cases:**
- Preview images in file managers (ranger, lf)
- Display plots in data science workflows
- Show diagrams in documentation
- Render graphics in TUI applications

---

## :fontawesome-solid-terminal: Shell Integration

**Automatic integration (ZSH example):**

```bash
# Add to .zshrc
if test -n "$KITTY_INSTALLATION_DIR"; then
    export KITTY_SHELL_INTEGRATION="enabled"
    autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
    kitty-integration
    unfunction kitty-integration
fi
```

**Features:**
- Jump between prompts with keyboard shortcuts
- Clone terminal state in new windows
- Extended keyboard protocol
- Automatically set window title

---

## :fontawesome-solid-lightbulb: Pro Tips

- **Use GPU rendering** - Enable `sync_to_monitor yes` for smoothness
- **Font ligatures** - JetBrains Mono, Fira Code work great
- **Single instance mode** - `kitty --single-instance` opens new tabs in existing window
- **SSH integration** - `kitty +kitten ssh` preserves shell integration
- **Scrollback search** - `Ctrl+Shift+F` with regex support
- **Detach mode** - Use `--session` flag to save/restore window layouts
- **Remote control** - Enable `allow_remote_control yes` for scripting
- **Custom kittens** - Write Python scripts for custom functionality
- **Image protocol** - Unique to Kitty, works in Neovim with image.nvim
- **Use hints kitten** - `Ctrl+Shift+E` to hint at URLs/paths on screen

---

## :fontawesome-solid-triangle-exclamation: Common Gotchas

- **Font not found** - Install Nerd Fonts or JetBrains Mono
- **Ligatures not working** - Enable `disable_ligatures never`
- **Clipboard broken** - Install `xclip` or `xsel` on Linux
- **Slow startup** - Disable `shell_integration` if not needed
- **Images not showing** - Check terminal size and image dimensions
- **SSH images broken** - Use `kitty +kitten ssh` instead of plain ssh
- **Colors wrong** - Set `TERM=xterm-kitty` in shell config
- **Tabs not showing** - Enable `tab_bar_edge top` or `bottom`
- **Key bindings conflict** - Remap in kitty.conf, prefix with `ctrl+shift`
- **Performance issues** - Disable cursor blinking, reduce scrollback

---

## :fontawesome-solid-link: Resources

**Official:**
- **[Kitty Documentation](https://sw.kovidgoyal.net/kitty/)** - Complete docs
- **[GitHub](https://github.com/kovidgoyal/kitty)** - Source code
- **[Changelog](https://sw.kovidgoyal.net/kitty/changelog/)** - Version history

**Themes:**
- **[Kitty Themes](https://github.com/dexpota/kitty-themes)** - 200+ themes
- **[Tokyo Night](https://github.com/davidmathers/tokyo-night-kitty-theme)** - Popular theme
- **[Catppuccin](https://github.com/catppuccin/kitty)** - Pastel theme

**Integration:**
- **[Neovim Image](https://github.com/3rd/image.nvim)** - Display images in Neovim
- **[Ranger](https://github.com/ranger/ranger)** - File manager with image preview
- **[LF](https://github.com/gokcehan/lf)** - Fast file manager

**Communities:**
- **[r/KittyTerminal](https://reddit.com/r/KittyTerminal)** - Reddit community
- **[GitHub Discussions](https://github.com/kovidgoyal/kitty/discussions)** - Official forum

---

**Last Updated:** 2026-02-03

**Tags:** kitty, terminal-emulator, terminal, gpu-accelerated, terminal, cli, productivity, development-tools
