---
title: Neovim
description: Modern Vim that doesn't suck - LSP, Lua, TreeSitter, and actually good defaults
tags:
  - editor
  - vim
  - neovim
  - development
---

# Neovim

Vim fork that fixed everything Vim got wrong. Native LSP, Lua config, TreeSitter syntax, async everything. VSCode users keep switching once they see LazyVim. The terminal editor that's actually modern.

______________________________________________________________________

## Quick Hits

=== "🎯 Essential Commands & Config"

    ```bash
    # Launch Neovim
    nvim

    # Open specific file
    nvim file.txt

    # Open at specific line
    nvim +42 file.txt

    # Open multiple files in splits
    nvim -o file1.txt file2.txt  # horizontal
    nvim -O file1.txt file2.txt  # vertical

    # Check health (diagnose issues)
    :checkhealth

    # Update plugins (with lazy.nvim)
    :Lazy update

    # Config file location
    ~/.config/nvim/init.lua  # Lua config
    # or
    ~/.config/nvim/init.vim  # Vimscript (legacy)

    # Install LSP server
    :LspInstall pyright  # Python example
    ```

    **Real talk:**

    - Config in Lua, not Vimscript (way better)
    - Built-in LSP (no more CoC.nvim hacks)
    - Tree Sitter for syntax highlighting (faster, more accurate)
    - Async everything (no more blocking operations)
    - Use LazyVim/NvChad for instant modern setup

=== "⚡ Common Patterns"

    ```lua
    -- Minimal init.lua config
    -- Set leader key
    vim.g.mapleader = " "

    -- Basic options
    vim.opt.number = true          -- Line numbers
    vim.opt.relativenumber = true  -- Relative line numbers
    vim.opt.mouse = 'a'            -- Enable mouse
    vim.opt.ignorecase = true      -- Case insensitive search
    vim.opt.smartcase = true       -- Unless capital letter used
    vim.opt.expandtab = true       -- Use spaces instead of tabs
    vim.opt.shiftwidth = 2         -- Indent size
    vim.opt.tabstop = 2            -- Tab size

    -- Key mappings
    local keymap = vim.keymap.set

    -- Save file
    keymap('n', '<leader>w', ':w<CR>')

    -- Quit
    keymap('n', '<leader>q', ':q<CR>')

    -- Split navigation
    keymap('n', '<C-h>', '<C-w>h')
    keymap('n', '<C-j>', '<C-w>j')
    keymap('n', '<C-k>', '<C-w>k')
    keymap('n', '<C-l>', '<C-w>l')
    ```

=== "🔥 Pro Tips & Gotchas"

    - **Distributions:** LazyVim or NvChad for instant IDE-like setup
    - **LSP:** Native LSP is game-changer (autocomplete, go-to-def, hover)
    - **Plugin manager:** lazy.nvim is the standard now (faster than packer)
    - **Tree Sitter:** Better syntax highlighting, text objects, refactoring
    - **Lua rocks:** Learn Lua basics, Vimscript is dead
    - **Performance:** 10x faster than Vim for large files
    - **Tmux:** Pairs perfectly with tmux for terminal workflow
    - **Learning curve:** Steep but worth it. Use vimtutor first
    - **Muscle memory:** Takes 2-3 weeks to match VSCode speed
    - **When NOT to use:** Quick config edits (use nano), GUI-only workflows

______________________________________________________________________

## Learning Paths

### 🎓 Free Resources

- **[Neovim Docs](https://neovim.io/doc/)** - Official documentation
- **[kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)** - Best starting point for config
- **[Learn Vim (the hard way)](https://learnvimscriptthehardway.stevelosh.com/)** - Classic resource
- **[ThePrimeagen's Neovim Setup](https://www.youtube.com/watch?v=w7i4amO_zaE)** - Netflix engineer's config
- **[TJ DeVries YouTube](https://www.youtube.com/c/TJDeVries)** - Neovim core developer tutorials

### 🧪 Interactive Learning

- **[Vim Adventures](https://vim-adventures.com/)** - Learn Vim by playing a game
- **[VimGenius](http://www.vimgenius.com/)** - Interactive Vim tutorial
- **[openvim](https://www.openvim.com/)** - Interactive Vim tutorial in browser
- **vimtutor** - Built-in tutorial (run `vimtutor` in terminal)

### 🚀 Projects to Build

- **Beginner:** Complete vimtutor, customize basic init.lua with options
- **Intermediate:** Build your own config from scratch with LSP and Telescope
- **Advanced:** Create custom plugin in Lua for your workflow

______________________________________________________________________

## Community Pulse

### 🐦 Who to Follow

**Twitter/X:**

- [@neovim](https://twitter.com/neovim) - Official Neovim account
- [@teej_dv](https://twitter.com/teej_dv) - TJ DeVries, Neovim core dev
- [@ThePrimeagen](https://twitter.com/ThePrimeagen) - Netflix engineer, Vim enthusiast
- [@folke](https://twitter.com/folke) - lazy.nvim creator
- [@chrisatmachine](https://twitter.com/chrisatmachine) - Neovim content creator

**YouTube:**

- [ThePrimeagen](https://www.youtube.com/c/theprimeagen) - Workflows, tutorials, entertainment
- [TJ DeVries](https://www.youtube.com/c/TJDeVries) - Core dev, deep technical content
- [chris@machine](https://www.youtube.com/c/ChrisAtMachine) - Setup guides and tutorials
- [Dreams of Code](https://www.youtube.com/c/dreamsofcode) - Modern setups
- [Josean Martinez](https://www.youtube.com/c/JoseanMartinez) - Configuration tutorials

### 💬 Active Communities

- **[r/neovim](https://reddit.com/r/neovim)** - 150k+ members, configs, plugins, help
- **[Neovim Discord](https://discord.gg/neovim)** - Active community, quick help
- **[Neovim Matrix](https://matrix.to/#/#neovim:matrix.org)** - Official chat
- **[Stack Overflow: neovim](https://stackoverflow.com/questions/tagged/neovim)** - Technical Q&A

### 🎙️ Podcasts & Newsletters

- **[Changelog](https://changelog.com/)** - Developer tools and workflows
- **[Console Newsletter](https://console.dev/)** - Weekly dev tools digest
- **[Syntax.fm](https://syntax.fm/)** - Web dev, editor discussions

______________________________________________________________________

## Worth Checking

<div class="grid cards" markdown>

- 📚 __Official Stuff__

    ______________________________________________________________________

    [Neovim Docs](https://neovim.io/doc/)

    [Neovim GitHub](https://github.com/neovim/neovim)

    [Neovim News](https://neovim.io/news/)

    [API Documentation](https://neovim.io/doc/user/api.html)

- 🧪 __Hands-on__

    ______________________________________________________________________

    [vimtutor](https://vimschool.netlify.app/introduction/vimtutor/)

    [Vim Adventures](https://vim-adventures.com/)

    [openvim](https://www.openvim.com/)

- 💻 __Real Configs__

    ______________________________________________________________________

    [LazyVim](https://www.lazyvim.org/)

    [NvChad](https://nvchad.com/)

    [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)

    [AstroNvim](https://astronvim.com/)

- 🔥 __Deep Dives__

    ______________________________________________________________________

    [Neovim Lua Guide](https://github.com/nanotee/nvim-lua-guide)

    [LSP Configuration](https://github.com/neovim/nvim-lspconfig)

    [Plugin Development](https://github.com/nvim-lua/wishlist)

- 🛠️ __Essential Plugins__

    ______________________________________________________________________

    [lazy.nvim](https://github.com/folke/lazy.nvim)

    [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)

    [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)

    [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)

- 📰 __Updates__

    ______________________________________________________________________

    [Neovim Releases](https://github.com/neovim/neovim/releases)

    [r/neovim](https://reddit.com/r/neovim)

    [This Week in Neovim](https://dotfyle.com/this-week-in-neovim)

</div>

______________________________________________________________________

## Installation & Setup

### Install Neovim

```bash
# Ubuntu/Debian (may be outdated)
sudo apt install neovim

# Latest version (recommended)
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install neovim

# macOS (Homebrew)
brew install neovim

# Arch
sudo pacman -S neovim

# From AppImage (any Linux)
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim

# Build from source
git clone https://github.com/neovim/neovim
cd neovim && make CMAKE_BUILD_TYPE=Release
sudo make install

# Verify installation
nvim --version
```

### Quick Start with LazyVim

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup

# Install LazyVim
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

# Launch and wait for plugins to install
nvim

# That's it! Modern IDE in 30 seconds
```

### Minimal Config from Scratch

```bash
# Create config directory
mkdir -p ~/.config/nvim

# Create init.lua
nvim ~/.config/nvim/init.lua
```

```lua
-- ~/.config/nvim/init.lua

-- Set leader key (must be before lazy.nvim)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Install lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Basic options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.termguicolors = true

-- Essential plugins
require("lazy").setup({
  -- Theme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  },

  -- Fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
    },
  },

  -- Syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { "lua", "vim", "python", "javascript" },
        highlight = { enable = true },
      })
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require('lspconfig')
      -- Add your language servers here
      lspconfig.pyright.setup{}  -- Python
      lspconfig.tsserver.setup{} -- JavaScript/TypeScript
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
    },
  },

  -- File tree
  {
    "nvim-tree/nvim-tree.lua",
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle File Tree" },
    },
    config = true,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    config = true,
  },
})

-- Key mappings
local keymap = vim.keymap.set

-- Better window navigation
keymap('n', '<C-h>', '<C-w>h')
keymap('n', '<C-j>', '<C-w>j')
keymap('n', '<C-k>', '<C-w>k')
keymap('n', '<C-l>', '<C-w>l')

-- Resize with arrows
keymap('n', '<C-Up>', ':resize +2<CR>')
keymap('n', '<C-Down>', ':resize -2<CR>')
keymap('n', '<C-Left>', ':vertical resize -2<CR>')
keymap('n', '<C-Right>', ':vertical resize +2<CR>')

-- Better indenting
keymap('v', '<', '<gv')
keymap('v', '>', '>gv')

-- Move text up and down
keymap('v', 'J', ":m '>+1<CR>gv=gv")
keymap('v', 'K', ":m '<-2<CR>gv=gv")
```

______________________________________________________________________

## Common Workflows

### Developer Setup

```lua
-- Add language servers in lazy.nvim config
{
  "williamboman/mason.nvim",
  config = true,
},
{
  "williamboman/mason-lspconfig.nvim",
  config = function()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "pyright",
        "tsserver",
        "gopls",
        "rust_analyzer",
      },
    })
  end,
},
```

### Essential Vim Motions

```vim
" Navigation
h j k l          " Left, down, up, right
w b              " Word forward/backward
0 $              " Start/end of line
gg G             " Top/bottom of file
{ }              " Paragraph up/down
Ctrl-d Ctrl-u    " Half page down/up

" Editing
i a              " Insert before/after cursor
I A              " Insert start/end of line
o O              " New line below/above
dd               " Delete line
yy               " Copy line
p P              " Paste after/before
u Ctrl-r         " Undo/redo
.                " Repeat last command

" Search
/pattern         " Search forward
?pattern         " Search backward
n N              " Next/previous match
*                " Search word under cursor

" Visual mode
v                " Character visual
V                " Line visual
Ctrl-v           " Block visual

" Splits
:sp              " Horizontal split
:vsp             " Vertical split
Ctrl-w w         " Switch windows
Ctrl-w q         " Close window
```

### Pentester/SysAdmin Setup

```lua
-- Useful plugins for sys work
{
  "tpope/vim-fugitive",  -- Git integration
},
{
  "akinsho/toggleterm.nvim",  -- Better terminal
  config = true,
},
{
  "numToStr/Comment.nvim",  -- Easy commenting
  config = true,
},
```

______________________________________________________________________

**Last Updated:** 2026-01-14 **Vibe Check:** 🔥 **Hyped** - Neovim is dominating the terminal editor space. VSCode users switching daily once they see LazyVim. The modern Vim everyone wanted.
