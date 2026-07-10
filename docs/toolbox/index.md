# :lucide-wrench: Toolbox

Terminal tools that make life bearable. Each one solves a specific problem — no fluff, no fashion frameworks.

---

## Quick Hits

=== ":lucide-list-check: Essential Tools"
    | Tool | What it does | Why bother |
    |------|-------------|------------|
    | **NeoVim** | Modal text editor, Neovim-hardened | Vim motions without the 1990s baggage |
    | **tmux** | Terminal multiplexer | Keep sessions alive when SSH drops |
    | **Kitty** | GPU-accelerated terminal | Fast, configurable, image rendering in terminal |
    | **ZSH + Zinit** | Shell + plugin manager | Sane defaults, async loading, no more `.bashrc` spaghetti |
    | **MISE** | Runtime version manager, env vars, task runner | Rust-based asdf replacement — faster, no shims, does more |

=== ":lucide-bolt: Workflow Integration"
    These tools are designed to work together:

    - **Kitty** runs **tmux** sessions with **NeoVim** inside
    - **ZSH** with **Zinit** loads completions for all the above
    - **MISE** manages runtimes across all projects
    - **tmux** persists sessions across kitty window splits

    **Why this works:** Each tool does one thing well. No IDE bloat, no lock-in. Drop any component and the rest still work.

=== ":lucide-fire: Pro Tips & Gotchas"
    **Tips:**
    - Use `tmux resurrect` + `tmux continuum` to auto-save/restore sessions across reboots
    - MISE's `legacy_version_file` setting lets you keep existing `.nvmrc` / `.ruby-version` files
    - Kitty's SSH integration (`kitten ssh`) beats OpenSSH for latency

    **Gotchas:**
    - More tools = more config drift. Keep dotfiles in version control
    - MISE requires shell hook — `eval "$(mise activate zsh)"` or tools won't auto-switch
    - tmux prefix key muscle memory is permanent once learned

---

## Reference

- :lucide-wrench: **NeoVim** — `toolbox/neovim.tool.md`
- :lucide-wrench: **tmux** — `toolbox/tmux.tool.md`
- :lucide-wrench: **Kitty** — `toolbox/kitty.tool.md`
- :lucide-wrench: **ZSH + Zinit** — `toolbox/zsh.tool.md`
- :lucide-wrench: **MISE** — `toolbox/mise.tool.md`

---

**Last Updated:** 2026-07-08 | **Vibe Check:** :lucide-wrench: **Toolbox** - Terminal tooling that doesn't get in your way.

**Tags:** toolbox, terminal, tools
