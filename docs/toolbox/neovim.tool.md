---
title: Neovim
description: Modern Vim fork with Lua configuration and LSP support - your terminal text editor that doesn't suck
---

# :lucide-code: Neovim

Modern Vim fork built for extensibility. Native LSP, Lua configuration, Tree-sitter syntax, async everything. Vim keybindings without the technical debt. No Vimscript hell, just Lua.

!!! tip "Why NeoVim over Vim"
    Built-in LSP client, better plugin architecture, Lua configuration, active development, and Tree-sitter integration. Vim compatibility mode exists if you need it.
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
<div class="ref-cards" markdown>

- :lucide-book: [NeoVim Docs](https://neovim.io/doc/) — Official documentation (`:help` inside Neovim)
- :lucide-github: [GitHub](https://github.com/neovim/neovim) — 85k stars, source, issues
- :lucide-wiki: [Wiki](https://github.com/neovim/neovim/wiki) — FAQ, tips, migration guides
- :lucide-code: [API docs](https://neovim.io/doc/user/api.html) — Lua API reference

</div>

**Learning:**
<div class="ref-cards" markdown>

- :lucide-book-open: [Learn Lua in Y minutes](https://learnxinyminutes.com/docs/lua/) — Lua primer (30 min)
- :lucide-terminal: [`:Tutor`](https://neovim.io/doc/user/tutor.html) — Built-in interactive tutorial
- :lucide-rocket: [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) — Start here for your own config
- :lucide-star: [Awesome Neovim](https://github.com/rockerBOO/awesome-neovim) — The definitive curated plugin list

</div>

**Communities:**
<div class="ref-cards" markdown>

- :lucide-reddit: [r/neovim](https://reddit.com/r/neovim) — 200k+ members, daily config showcases
- :lucide-message-square: [Neovim Discourse](https://neovim.discourse.group/) — Official forum, RFCs
- :lucide-message-circle: [Neovim Discord](https://discord.gg/neovim) — Active chat, plugin dev
- :lucide-github: [GitHub Discussions](https://github.com/neovim/neovim/discussions) — Q&A, show and tell

</div>

---

**Last Updated:** 2026-06-01 | **Vibe Check:** :lucide-flame: **Editor of the Gods** - Neovim is the modern Vim reincarnation. Lua config, LSP integration, tree-sitter parsing. Steep learning curve but unmatched editing speed. If you live in the terminal, this is your editor.

**Tags:** neovim, vim, text-editor, lua, lsp, tree-sitter, terminal, cli, development-tools
