# Configuration Management

This directory contains all dotfiles configurations managed by GNU Stow. Each subdirectory is a "package" that gets symlinked to your home directory.

## GNU Stow Overview

Stow creates symbolic links from files in this directory to your home directory (`~`). For example:

- `config/starship/.config/starship.toml` → `~/.config/starship.toml`
- `config/git/.gitconfig` → `~/.gitconfig`
- `config/bash/.bashrc` → `~/.bashrc`

This approach keeps your configurations organized while making them available in their expected locations.

## Directory Structure

```
config/
├── bash/           # Bash shell configuration
├── shared/         # Shell-agnostic configurations
├── zsh/            # Zsh shell configuration
├── git/            # Git settings and global ignore
├── starship/       # Starship prompt configuration
├── nvim/           # Neovim editor configuration
├── ghostty/        # Ghostty terminal emulator
├── gh/             # GitHub CLI settings
└── lazygit/        # Lazygit UI configuration
```

## Shell Configuration Architecture

This project uses a hybrid approach to minimize duplication between Bash and Zsh:

### Shared Configuration (`config/shared/`)

Shell-agnostic configurations that work with both shells:

- `10-homebrew.sh` - PATH setup for Homebrew + bash completions
- `30-zoxide.sh` - Initialize zoxide for directory jumping
- `40-starship.sh` - Initialize Starship prompt (includes shell detection)
- `50-modern-tools.sh` - ASDF and modern tool aliases (eza, bat, fd, etc.)
- `55-aliases.sh` - General shell aliases

### Shell-Specific Configuration

**Bash (`config/bash/`)**:
- `.bashrc` - Main configuration file that loads shared configs
- `.bash_profile` - Sources `.bashrc` for login shells

**Zsh (`config/zsh/`)**:
- `.zshrc` - Main configuration file that loads shared configs
- `.zprofile` - Sources `.zshrc` for login shells
- `.zshrc.d/` - Zsh-specific enhancements loaded after shared configs:
  - `20-zsh-completions.zsh` - Enhanced completions for Homebrew tools
  - `25-zsh-syntax-highlighting.zsh` - Syntax highlighting
  - `27-zsh-history-substring-search.zsh` - Better history search
  - `45-globalias.zsh` - Alias expansion on space

### Loading Order

1. **Shared configs** are loaded first by both shells
2. **Shell-specific configs** are loaded after (Zsh only, Bash uses integrated completions)

## Package Details

### Development Tools

**Git (`config/git/`)**:
- `.gitconfig` - Git settings (editor, pager, diff settings)
- `.gitignore_global` - Common ignore patterns for all projects

**Neovim (`config/nvim/`)**:
- `init.lua` - Modern Lua-based configuration with React development workflow
- `lazy-lock.json` - Plugin lockfile for reproducible setup

**GitHub CLI (`config/gh/`)**:
- `config.yml` - Aliases and settings for GitHub CLI

**Lazygit (`config/lazygit/`)**:
- `config.yml` - Git UI configuration with Catppuccin theme

### Terminal & Shell

**Starship (`config/starship/`)**:
- `starship.toml` - Catppuccin Powerline prompt (Macchiato theme)

**Ghostty (`config/ghostty/`)**:
- `config` - Terminal emulator with Catppuccin Macchiato theme
- `themes/` - Custom Catppuccin themes (Macchiato, Mocha)

## Adding New Tools

To add a new tool to your dotfiles:

1. **Add to Brewfile** (if it's a Homebrew package):
   ```bash
   brew "new-tool"
   ```

2. **Create configuration directory**:
   ```bash
   mkdir -p config/new-tool/
   ```

3. **Add configuration files** with paths relative to `$HOME`:
   ```
   config/new-tool/.config/new-tool/config
   ```

4. **Create symlinks**:
   ```bash
   make stow
   ```

5. **Test the configuration** and make any needed adjustments

## Stow Commands

The Makefile provides convenient Stow commands:

- `make stow` - Create all symlinks
- `make unstow` - Remove all symlinks
- Manual: `stow -d config -t $HOME <package>`

## Managing Packages

Each subdirectory in `config/` is an independent Stow package:

- **Individual management**: `stow -d config nvim` (only stow nvim package)
- **Package removal**: `stow -d config -D nvim` (remove nvim symlinks)
- **Listing packages**: `ls -d config/*/` shows all available packages

This modular approach makes it easy to:
- Enable/disable specific tools
- Share individual configurations with others
- Maintain clean separation between different tool setups