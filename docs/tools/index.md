# My Favorite Tools
## ZSH
Zsh, short for Z shell, is a powerful command-line shell for Unix-like operating systems. It is renowned for its advanced features, including improved tab completion, spelling correction, and powerful scripting capabilities. Zsh is highly customisable, allowing users to tailor their shell environment to their specific needs.

=== "Documentation"
    - [ZSH.org](https://www.zsh.org)
    - [ArchWiki - ZSH](https://wiki.archlinux.org/title/zsh)
    - [A User's Guide to the Z-Shell](https://zsh.sourceforge.io/Guide/zshguide.html)
    - [ZSH Cheatsheet](https://github.com/ohmyzsh/ohmyzsh/wiki/Cheatsheet)
    - [ZSH DevHints](https://devhints.io/zsh)
=== "Customization"
    - [Zinit](https://github.com/zdharma-continuum/zinit)
    - [Oh my ZSH](https://ohmyz.sh)
=== "Plugins"
    - [Awesome ZSH Plugins](https://github.com/unixorn/awesome-zsh-plugins)

## NeoVim
NeoVim is a highly extensible text editor designed to enable efficient text editing. It builds on the strengths of Vim, offering improved user experience, modern features, and better plugin integration. Its open-source nature encourages contributions from the community, fostering rapid development and innovation.
=== "Documentation"
    - [NeoVim](https://neovim.io/)
    - [Vim-plug](https://github.com/junegunn/vim-plug)
    - [Lazy](https://github.com/folke/lazy.nvim)
=== "Plugins"
    - [NERDTree](https://github.com/preservim/nerdtree)
    - [fzf.vim](https://github.com/junegunn/fzf.vim)
    - [Vim-Prettier](https://github.com/prettier/vim-prettier)
    - [Lightline](https://github.com/itchyny/lightline.vim)
=== "Git Repositories"
    - [Vim Kickstarter](https://github.com/nvim-lua/kickstart.nvim)
    - [Awesome Neovim](https://github.com/rockerBOO/awesome-neovim)
=== "Learn"
    - [VIM adventures](https://vim-adventures.com)

## Tmux
Tmux is a terminal multiplexer that allows users to run multiple terminal sessions within a single window. It enables users to detach and reattach sessions, making it easy to manage long-running processes. Tmux also supports window splitting, session management, and extensive customisation, enhancing productivity in the terminal.
=== "Documentation"
    - [Tmux](https://github.com/tmux/tmux)
    - [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)

## ASDF
ASDF is a versatile version manager for managing multiple runtime versions of different languages. It supports a wide range of programming languages and tools, enabling seamless switching between different versions for development projects. ASDF's plugin architecture allows easy extension, making it a flexible tool for developers.

??? example "ASDF Command line basics"
    ASDF UPDATE
    ```bash
    $> asdf update --head
    ```

    LIST PLUGIN
    ```bash
    $> asdf plugin list all
    ```

    ADD PLUGIN
    ```bash
    $> asdf plugin add <plugin_name>
    ```

    LIST PLUGIN VERSIONS
    ```bash
    $> asdf list all <plugin_name>
    ```

    INSTALL PLUGIN
    ```bash
    # Install latest plugin version
    $> asdf install <plugin_name>

    # Install a selected plugin version
    $> asdf install <plugin_name> <plugin_version>
    ```

    SETUP A PLUGIN VERSION
    ```bash
    $> asdf global <plugin_name> <plugin_version> # Set the package global version
    $> asdf local <plugin_name> <plugin_version>  # Set the package local version
    $> asdf shell <plugin_name> <plugin_version>  # Set the package in the current shell
    ```

=== "Documentation"
    - [ASDF](https://asdf-vm.com)

## Obisidan
Obsidian is a powerful note-taking and knowledge management application that uses plain text Markdown files. It offers features like backlinking, graph views, and plugins to help users create interconnected and structured notes. Obsidian's flexibility and customisability make it ideal for personal knowledge management and project organisation.
=== "Documentation"
    - [Obsidian](https://obsidian.md)
    === "Community"
    - [r/ObsidianMD](https://www.reddit.com/r/ObsidianMD/)

## Pimp my Desktop
=== "Themes"
    - [Dracula Theme](https://draculatheme.com)
