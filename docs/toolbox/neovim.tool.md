---
title: NeoVim
description: Modern Vim fork with Lua configuration and LSP support - your terminal text editor that doesn't suck
---

# :octicons-code-16: NeoVim

Modern Vim fork built for extensibility. Native LSP, Lua configuration, Tree-sitter syntax, async everything. Vim keybindings without the technical debt. No Vimscript hell, just Lua.

!!! tip "Why NeoVim over Vim"
    Built-in LSP client, better plugin architecture, Lua configuration, active development, and Tree-sitter integration. Vim compatibility mode exists if you need it.

---

## :octicons-zap-16: Quick Start

=== "Installation"

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

=== "Basic Configuration"

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

=== "Plugin Manager"

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

---

## :octicons-package-16: Essential Plugins

### Core Setup

```lua
require("lazy").setup({
  -- Colorscheme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight-night]])
    end,
  },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup()
      vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>')
    end,
  },

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files)
      vim.keymap.set('n', '<leader>fg', builtin.live_grep)
      vim.keymap.set('n', '<leader>fb', builtin.buffers)
    end,
  },

  -- Treesitter (syntax highlighting)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "python", "javascript", "bash" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- LSP config
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      -- Example: Python LSP
      lspconfig.pyright.setup{}
      -- Example: Lua LSP
      lspconfig.lua_ls.setup{}
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = {
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'path' },
        },
      })
    end,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = { theme = 'tokyonight' }
      })
    end,
  },

  -- Git signs
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },

  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },

  -- Comment toggling
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
})
```

---

## :octicons-terminal-16: LSP Setup

**Install language servers:**

```bash
# Python
npm install -g pyright

# JavaScript/TypeScript
npm install -g typescript typescript-language-server

# Lua
brew install lua-language-server  # macOS
# or
cargo install stylua              # Formatter

# Bash
npm install -g bash-language-server

# Go
go install golang.org/x/tools/gopls@latest

# Rust
rustup component add rust-analyzer
```

**LSP keybindings:**

```lua
-- Add to init.lua after LSP setup
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  end,
})
```

---

## :octicons-light-bulb-16: Pro Tips

- **Use `:checkhealth`** - Diagnose issues with your setup
- **Learn Lua basics** - `:help lua-guide`, it's simpler than Vimscript
- **Use `vim.keymap.set()`** - Modern keymap API, forget `nnoremap`
- **Lazy load plugins** - Don't load everything at startup
- **Keep config modular** - Split into `~/.config/nvim/lua/` modules
- **Read plugin docs** - Each plugin has `:help plugin-name`
- **Use built-in features** - LSP, Tree-sitter, file explorer are built-in
- **`:Telescope` everything** - File search, grep, git, LSP symbols

---

## :octicons-alert-16: Common Gotchas

- **Python provider issues** - Run `:checkhealth provider`, install `pynvim`
- **Clipboard not working** - Install `xclip` (Linux) or use `pbcopy` (macOS)
- **Slow startup** - Profile with `nvim --startuptime startup.log`, lazy load plugins
- **LSP not attaching** - Check `:LspInfo`, ensure language server is installed
- **Tree-sitter errors** - Run `:TSUpdate` after installing
- **Config not loading** - Check file path: `~/.config/nvim/init.lua` (not `.vim`)
- **Plugins not installing** - Run `:Lazy sync` manually
- **Color scheme broken** - Enable `termguicolors` in terminal emulator

---

## :octicons-link-16: Resources

**Official:**
- **[NeoVim Docs](https://neovim.io/doc/)** - Official documentation
- **[GitHub](https://github.com/neovim/neovim)** - Source code and issues
- **[Wiki](https://github.com/neovim/neovim/wiki)** - Community wiki

**Learning:**
- **[kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)** - Minimal starter config
- **[Learn Lua in Y minutes](https://learnxinyminutes.com/docs/lua/)** - Lua primer
- **`:Tutor`** - Built-in Vim tutorial (run in nvim)

**Communities:**
- **[r/neovim](https://reddit.com/r/neovim)** - Reddit community (200k+ members)
- **[Neovim Discourse](https://neovim.discourse.group/)** - Official forum

**Awesome Plugins:**
- **[Awesome Neovim](https://github.com/rockerBOO/awesome-neovim)** - Curated plugin list

---

**Last Updated:** 2026-02-03

**Tags:** neovim, vim, text-editor, lua, lsp, tree-sitter, terminal, cli, development-tools
