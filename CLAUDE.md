# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a macOS dotfiles configuration managed with GNU Stow. Each directory in `config/` is a Stow package that gets symlinked to the user's home directory.

## Common Commands

```bash
make setup      # Full setup for a new machine (install + stow)
make install    # Install Homebrew dependencies from Brewfile
make stow       # Create symlinks using GNU Stow
make unstow     # Remove all symlinks
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

Both bash and zsh use a modular configuration system:
- Main files (`.bashrc`, `.zshrc`) source all files from their respective `.d/` directories
- Files are loaded in numeric order (10-, 20-, 30-, etc.)
- This allows easy addition of new configurations without editing the main rc file

Current loading order:
1. `10-homebrew.*` - PATH setup for Homebrew
2. `20-zsh-completions.zsh` (zsh only) - Enable completions
3. `25-zsh-syntax-highlighting.zsh` (zsh only) - Enable syntax highlighting
4. `27-zsh-history-substring-search.zsh` (zsh only) - Better history search
5. `30-zoxide.*` - Initialize zoxide for directory jumping
6. `40-starship.*` - Initialize Starship prompt
7. `45-globalias.zsh` (zsh only) - Enable alias expansion on space
8. `50-modern-tools.*` - ASDF and modern tool aliases (eza, bat, fd, etc.)
9. `55-aliases.*` - General shell aliases

### Setup Flow

1. `make setup` → `scripts/setup.sh`
2. Checks for Homebrew installation
3. Calls `scripts/install.sh` → runs `brew bundle`
4. Calls `scripts/stow.sh` → creates symlinks for all config packages

## Key Configuration Files

- **Brewfile**: All Homebrew dependencies (tools, casks, fonts)
- **config/starship/.config/starship.toml**: Catppuccin Powerline prompt (Macchiato theme)
- **config/git/.gitconfig**: Git configuration with global gitignore reference
- **config/ghostty/.config/ghostty/config**: Terminal emulator with Catppuccin theme

## Adding New Tools

1. Add the tool to `Brewfile`
2. Create `config/<tool-name>/` directory
3. Add configuration files with paths relative to `$HOME`
4. Run `make stow` to create symlinks

## Important Notes

- All shell configs use `command -v` checks to handle missing tools gracefully
- ASDF configuration won't error if not yet initialized
- The repository uses numeric prefixes (10-, 20-, 30-) for load ordering
- Update documentation (README.md and CLAUDE.md) when adding, modifying, or removing config files, tools, capabilities, or changing project structure
