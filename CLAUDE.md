# CLAUDE.md

Guidance for Claude Code working in this repository.

## What this is

macOS dotfiles managed with GNU Stow. Each directory in `config/` is a Stow
package whose contents mirror `$HOME` and get symlinked there (e.g.
`config/starship/.config/starship.toml` → `~/.config/starship.toml`).

## Common Commands

```bash
make setup      # Full setup for a new machine (install + stow + defaults)
make install    # Install Homebrew dependencies from Brewfile
make stow       # Create symlinks using GNU Stow
make unstow     # Remove all symlinks
make defaults   # Configure macOS system defaults (idempotent)
make clean      # Remove temporary files (*.swp, *~)
```

## Where to look

Read these on demand rather than duplicating them here:

- **`config/README.md`** — Stow packages, directory structure, shell config
  architecture, `.zshrc.d/` loading order, adding new tools.
- **`scripts/README.md`** — setup flow, individual scripts, and the full list
  of macOS defaults applied by `scripts/macos-defaults.sh`.
- **`config/nvim/.config/nvim/init.lua`** — the entire Neovim config
  (kickstart.nvim-based, single file: plugins, LSP servers, formatters).
- **`Brewfile`** — all Homebrew dependencies (tools, casks, fonts).

## Conventions & gotchas

- **Zsh is primary; bash is a self-contained fallback.** Zsh config lives in
  `config/zsh/.config/zsh/.zshrc.d/`, sourced in numeric order — the `NN-`
  prefix controls load order, so pick the number deliberately when adding a
  file. `config/bash/.bashrc` inlines its own copy of the equivalent setup.
- **No admin privileges required.** `make setup` runs entirely without sudo;
  any sudo-requiring features in `scripts/macos-defaults.sh` are commented out.
- **Guard optional tools.** Shell configs use `command -v <tool>` checks so a
  missing tool never errors (asdf init, zoxide, starship, etc.).
- **Homebrew location is detected dynamically** via `brew --prefix`; never
  hardcode `/opt/homebrew` or `/usr/local` in configs.
- **Git identity** is not committed: `config/git/.gitconfig` `[include]`s
  `~/.gitconfig.local`, created interactively by `scripts/git-setup.sh`.
- **Update docs when structure changes.** Adjust the relevant subdirectory
  README (`config/` or `scripts/`) — not this file — when adding, removing, or
  changing tools/configs.
