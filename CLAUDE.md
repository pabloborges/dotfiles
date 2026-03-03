# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a macOS dotfiles configuration managed with GNU Stow. Each directory in `config/` is a Stow package that gets symlinked to the user's home directory.

## Common Commands

```bash
make setup      # Full setup for a new machine (install + stow + defaults)
make install    # Install Homebrew dependencies from Brewfile
make stow       # Create symlinks using GNU Stow
make unstow     # Remove all symlinks
make defaults   # Configure macOS system defaults (idempotent)
make clean      # Remove temporary files (*.swp, *~)
```

## Architecture

### Stow Package Structure

Each package in `config/` mirrors the home directory structure. For example:
- `config/starship/.config/starship.toml` → `~/.config/starship.toml`
- `config/git/.gitconfig` → `~/.gitconfig`
- `config/bash/.bashrc` → `~/.bashrc`

The `stow.sh` script iterates through all directories in `config/` and uses `stow -d config -t $HOME` to create symlinks.

### Shell Configuration Loading

Zsh is the primary shell. Bash config is a self-contained fallback.

**Zsh Configuration (`config/zsh/`):**
- `.zshrc` sources all files in `.zshrc.d/` in numeric order
- `.zshrc.d/` contains both general configs and zsh-specific enhancements

**Bash Configuration (`config/bash/`):**
- `.bashrc` is a single self-contained file with all configs inlined
- Includes bash-specific tool initialization (zoxide, starship, completions)

**Zsh Loading Order** (all in `config/zsh/.zshrc.d/`):
   - `05-terminal.zsh` - Terminal TERM fix for dumb terminals
   - `10-homebrew.zsh` - Dynamic Homebrew PATH detection via `brew --prefix`
   - `20-zsh-completions.zsh` - Enhanced completions for Homebrew tools
   - `21-fzf-tab.zsh` - Fuzzy TAB completion via fzf-tab (must load after compinit, before syntax-highlighting)
   - `22-fzf.zsh` - fzf shell integration + UP arrow bound to fuzzy history search
   - `25-zsh-syntax-highlighting.zsh` - Enable syntax highlighting
   - `26-zsh-autosuggestions.zsh` - Fish-like inline suggestions from history
   - `30-zoxide.zsh` - Initialize zoxide for directory jumping
   - `40-starship.zsh` - Initialize Starship prompt
   - `45-globalias.zsh` - Enable alias expansion on space
   - `50-modern-tools.zsh` - ASDF and modern tool aliases (eza, bat, fd, etc.)
   - `55-aliases.zsh` - General shell aliases (git, docker)
   - `60-functions.zsh` - Shell functions (getenv)
   - `65-worktrunk.zsh` - Worktrunk shell integration

### Setup Flow

1. `make setup` → `scripts/setup.sh`
2. Checks for Homebrew installation
3. Calls `scripts/install.sh` → runs `brew bundle`
4. Calls `scripts/stow.sh` → creates symlinks for all config packages
5. Calls `scripts/git-setup.sh` → prompts for Git user identity (name, email, optional GPG key) and writes `~/.gitconfig.local`
6. Calls `scripts/macos-defaults.sh` → configures macOS system defaults

## Key Configuration Files

- **Brewfile**: All Homebrew dependencies (tools, casks, fonts)
- **scripts/macos-defaults.sh**: macOS system defaults for power users (Finder, Dock, Keyboard, etc.)
- **config/starship/.config/starship.toml**: Catppuccin Powerline prompt (Macchiato theme)
- **config/git/.gitconfig**: Git configuration with global gitignore reference (uses `[include]` to load `~/.gitconfig.local` for user identity)
- **scripts/git-setup.sh**: Interactive Git user identity setup (creates `~/.gitconfig.local`)
- **config/ghostty/.config/ghostty/config**: Terminal emulator with Catppuccin theme and custom themes
- **config/nvim/.config/nvim/init.lua**: Neovim configuration based on kickstart.nvim

### Neovim Configuration

Based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) with agentic coding optimizations. Single-file `init.lua` using lazy.nvim plugin manager.

**Key plugins:**
- **blink.cmp** — Completion engine with LSP, snippets, and Copilot sources
- **copilot.lua + blink-cmp-copilot** — GitHub Copilot completions in the blink.cmp menu
- **Telescope** — Fuzzy finder for files, grep, LSP symbols
- **Treesitter** — Syntax highlighting (JS/TS/Lua/Bash/CSS/JSON/Markdown)
- **Mason** — Auto-installs LSP servers and tools
- **conform.nvim** — Format-on-save (prettier for JS/TS, stylua for Lua)
- **diffview.nvim** — Review git diffs inside nvim (`<leader>gd`, `<leader>gh`)
- **oil.nvim** — Filesystem navigation as a buffer (`-`)
- **gitsigns.nvim** — Git gutter signs
- **Catppuccin** — Macchiato theme (consistent with Ghostty and Starship)

**LSP servers:** ts_ls (TypeScript), eslint, tailwindcss, lua_ls
**Formatters:** prettier (JS/TS/JSON/CSS/HTML), stylua (Lua)

**Agentic coding features:**
- Auto-reload: Files edited by Claude Code are silently reloaded via `FocusGained`/`BufEnter`/`CursorHold` autocommands
- diffview.nvim: Review agent changes as unified diffs before committing
- oil.nvim: Navigate to new files created by agents

## Adding New Tools

1. Add the tool to `Brewfile`
2. Create `config/<tool-name>/` directory
3. Add configuration files with paths relative to `$HOME`
4. Run `make stow` to create symlinks

## Admin Privileges

**No admin privileges required** for the main setup. The `make setup` command works entirely without sudo:
- All scripts use user-level `defaults write` commands
- Optional system-level features (commented out in script) would require sudo but are not executed

## macOS System Defaults

The `scripts/macos-defaults.sh` script configures sensible defaults for power users:
- **Idempotent**: Safe to run multiple times
- **Documented**: Each setting has inline comments explaining what it does and how to modify it
- **Modular**: Organized into functions by category (Finder, Dock, Keyboard, etc.)
- **Categories**: Finder, Dock, Trackpad/Mouse, Keyboard, Screenshots, System UI, Activity Monitor, TextEdit, Terminal, App Store, Photos, Chrome

Key settings:
- Show hidden files, all extensions, status/path bars in Finder
- Auto-hide Dock with no delay, fast animations
- Maximum trackpad/mouse speed
- Fastest keyboard repeat rate, no press-and-hold
- Screenshots to ~/Screenshots as PNG without shadows
- Expanded save/print dialogs, save to disk by default
- Activity Monitor shows all processes

To customize: Edit `scripts/macos-defaults.sh` and modify any setting. Each line includes comments explaining the options.

## Homebrew Detection

The configuration dynamically detects Homebrew installation location using `brew --prefix`:
- Works with any Homebrew installation location (default `/opt/homebrew`, `/usr/local`, or custom paths)
- No hardcoded paths in shell configs
- PATH and completions automatically set from detected location
- Gracefully handles missing Homebrew (scripts use `command -v brew` checks)

## Shell Completions

**Zsh Completions:**
- Enhanced via `20-zsh-completions.zsh` with multiple paths:
  - Homebrew's `site-functions` (contains brew, asdf completions)
  - Additional `zsh-completions` package for extended tool support
- Proper fpath ordering ensures completions are available early

**Bash Completions:**
- Loaded inline in `.bashrc` from Homebrew's bash completion script
- Includes completions for brew, asdf, and other Homebrew-installed tools

## Important Notes

- All shell configs use `command -v` checks to handle missing tools gracefully
- ASDF configuration won't error if not yet initialized
- The repository uses numeric prefixes (10-, 20-, 30-) for load ordering
- The macOS defaults script is automatically run during `make setup` but can be run standalone with `make defaults`
- Update documentation (README.md and CLAUDE.md) when adding, modifying, or removing config files, tools, capabilities, or changing project structure
