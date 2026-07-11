---
title: NeoVim
description: Modern Vim fork with Lua configuration and LSP support - your terminal text editor that doesn't suck
---

# :lucide-code: NeoVim

Modern Vim fork built for extensibility. Native LSP, Lua configuration, Tree-sitter syntax, async everything. Vim keybindings without the technical debt. No Vimscript hell, just Lua.

!!! tip "Why NeoVim over Vim"
    Built-in LSP client, better plugin architecture, Lua configuration, active development, and Tree-sitter integration. Vim compatibility mode exists if you need it.

## Quick Hits

=== ":lucide-list-check: Essential Commands"

    **macOS:**
    ```bash
    brew install neovim
    ```

    **Ubuntu/Debian:**
    ```bash
    sudo apt install neovim
    ```

    **Arch Linux:**
    ```bash
    sudo pacman -S neovim
    ```

    **From source (latest):**
    ```bash
    git clone https://github.com/neovim/neovim
    cd neovim
    make CMAKE_BUILD_TYPE=Release
    sudo make install
    ```

=== ":lucide-bolt: Common Patterns"

    **Config location:** `~/.config/nvim/init.lua`

    ```lua
    -- Basic settings
    vim.opt.number = true              -- Line numbers
    vim.opt.relativenumber = true      -- Relative line numbers
    vim.opt.mouse = 'a'                -- Enable mouse
    vim.opt.ignorecase = true          -- Case-insensitive search
    vim.opt.smartcase = true           -- Case-sensitive if uppercase used
    vim.opt.hlsearch = false           -- No search highlighting
    vim.opt.wrap = false               -- No line wrapping
    vim.opt.breakindent = true         -- Preserve indentation in wrapped text
    vim.opt.tabstop = 4                -- Tab = 4 spaces
    vim.opt.shiftwidth = 4             -- Indent = 4 spaces
    vim.opt.expandtab = true           -- Spaces instead of tabs
    vim.opt.termguicolors = true       -- True color support

    -- Leader key
    vim.g.mapleader = ' '              -- Space as leader key
    vim.g.maplocalleader = ' '

    -- Basic keymaps
    vim.keymap.set('n', '<leader>w', ':w<CR>')        -- Save
    vim.keymap.set('n', '<leader>q', ':q<CR>')        -- Quit
    vim.keymap.set('n', '<leader>e', ':Ex<CR>')       -- File explorer
    ```

    **Real talk:**
    - Start simple - don't copy massive configs
    - Learn one feature at a time
    - Use `:help` for everything
    - Leader key choice matters (space is popular)

=== ":lucide-flame: Pro Tips & Gotchas"

    **lazy.nvim (recommended):**

    ```lua
    -- Bootstrap lazy.nvim
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
      vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
      })
    end
    vim.opt.rtp:prepend(lazypath)

    -- Setup plugins
    require("lazy").setup({
      -- Your plugins here
    })
    ```

    **Why lazy.nvim:**
    - Lazy loading out of the box
    - Fast startup times
    - Simple configuration
    - No learning curve
    
    **Pro Tips:**
    
    - **Use `:checkhealth`** - Diagnose issues with your setup
    - **Learn Lua basics** - `:help lua-guide`, it's simpler than Vimscript
    - **Use `vim.keymap.set()`** - Modern keymap API, forget `nnoremap`
    - **Lazy load plugins** - Don't load everything at startup
    - **Keep config modular** - Split into `~/.config/nvim/lua/` modules
    - **Read plugin docs** - Each plugin has `:help plugin-name`
    - **Use built-in features** - LSP, Tree-sitter, file explorer are built-in
    - **`:Telescope` everything** - File search, grep, git, LSP symbols
    
    **Common Gotchas:**
    
    - **Python provider issues** - Run `:checkhealth provider`, install `pynvim`
    - **Clipboard not working** - Install `xclip` (Linux) or use `pbcopy` (macOS)
    - **Slow startup** - Profile with `nvim --startuptime startup.log`, lazy load plugins
    - **LSP not attaching** - Check `:LspInfo`, ensure language server is installed
    - **Tree-sitter errors** - Run `:TSUpdate` after installing
    - **Config not loading** - Check file path: `~/.config/nvim/init.lua` (not `.vim`)
    - **Plugins not installing** - Run `:Lazy sync` manually
    - **Color scheme broken** - Enable `termguicolors` in terminal emulator

---

## :lucide-star: Project & Author

| Aspect | Detail |
|--------|--------|
| **Vim creator** | [Bram Moolenaar](https://www.moolenaar.net/) (1961–2023) — created Vim in 1991. RIP. |
| **Neovim creator** | [Justin Keyes (tarruda)](https://github.com/tarruda) — started the fork in 2014 |
| **Neovim maintainer** | [Justin M. Keyes (justinmk)](https://github.com/justinmk) — project lead since 2014, with [community team](https://github.com/neovim/neovim/blob/master/MAINTAINORS.md) |
| **License** | Apache 2.0 (Neovim) / Vim (original Vim) |
| **Language** | C (core), Lua (config/plugins), Vimscript (legacy compat) |
| **Stars** | ~85k |
| **Since** | Vim: 1991 / Neovim: 2014 (first stable: 2015) |
| **History** | Neovim forked Vim to refactor the codebase, add async support, built-in LSP, and Lua as a first-class config language. It succeeded: most Vim users have migrated. Bram Moolenaar supported the fork before his passing. The project is now the de-facto standard modal editor. |

---

## :lucide-compass: Ecosystem & Customization

**Distributions (full config packs):**

| Distro | Vibe | Best for |
|--------|------|----------|
| **[LazyVim](https://www.lazyvim.org/)** | Batteries-included, LunarVim successor | Most users — sensible defaults, easy customization |
| **[NvChad](https://nvchad.com/)** | Fast, UI-focused, dark theme | People who want a beautiful editor out of the box |
| **[AstroNvim](https://astronvim.com/)** | Modular, community-driven | Users who like to pick and choose |
| **[kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)** | Minimal, educational | Learning to build your own config |

**Core plugins everyone uses:**

| Plugin | Purpose | Notes |
|--------|---------|-------|
| **[lazy.nvim](https://github.com/folke/lazy.nvim)** | Plugin manager | De-facto standard, lazy loading, 36k stars |
| **[Telescope](https://github.com/nvim-telescope/telescope.nvim)** | Fuzzy finder | Files, grep, buffers, LSP, git — everything |
| **[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)** | Syntax parsing | Better highlighting, code navigation, folding |
| **[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)** | LSP integration | 100+ language servers, zero-config for many |
| **[nvim-cmp](https://github.com/hrsh7th/nvim-cmp)** | Autocompletion | LSP + buffer + path + snippet sources |
| **[Comment.nvim](https://github.com/numToStr/Comment.nvim)** | Comment toggling | `gc` to comment, `gb` for block comments |

**LSP servers to install:**
```bash
npm install -g pyright typescript typescript-language-server bash-language-server
brew install lua-language-server      # macOS
go install golang.org/x/tools/gopls@latest
rustup component add rust-analyzer
```

---

## :lucide-link: Resources

**Official:**
- :lucide-book: [NeoVim Docs](https://neovim.io/doc/) — Official documentation (`:help` inside Neovim)
- :lucide-github: [GitHub](https://github.com/neovim/neovim) — 85k stars, source, issues
- :lucide-wiki: [Wiki](https://github.com/neovim/neovim/wiki) — FAQ, tips, migration guides
- :lucide-code: [Neovim API docs](https://neovim.io/doc/user/api.html) — Lua API reference

**Learning:**
- :lucide-book-open: [Learn Lua in Y minutes](https://learnxinyminutes.com/docs/lua/) — Lua primer (30 min)
- :lucide-terminal: [`:Tutor`](https://neovim.io/doc/user/tutor.html) — Built-in interactive tutorial (run `:Tutor`)
- :lucide-rocket: [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) — Start here for your own config
- :lucide-star: [Awesome Neovim](https://github.com/rockerBOO/awesome-neovim) — The definitive curated plugin list

**Communities:**
- :lucide-reddit: [r/neovim](https://reddit.com/r/neovim) — 200k+ members, daily config showcases
- :lucide-message-square: [Neovim Discourse](https://neovim.discourse.group/) — Official forum, RFCs
- :lucide-message-circle: [Neovim Discord](https://discord.gg/neovim) — Active chat, plugin dev
- :lucide-github: [GitHub Discussions](https://github.com/neovim/neovim/discussions) — Q&A, show and tell

---

**Last Updated:** 2026-06-01 | **Vibe Check:** :lucide-flame: **Editor of the Gods** - Neovim is the modern Vim reincarnation. Lua config, LSP integration, tree-sitter parsing. Steep learning curve but unmatched editing speed. If you live in the terminal, this is your editor.

**Tags:** neovim, vim, text-editor, lua, lsp, tree-sitter, terminal, cli, development-tools
