# Dotfiles

A comprehensive and extensible dotfiles configuration for macOS.

## Features

- Modern CLI tools (eza, fd, ripgrep, bat, tldr, starship, zoxide)
- Development tools (git, git-delta, git-extras, gh, lazygit, neovim)
- Container management (docker, colima, docker-compose)
- Productivity apps (ghostty, raycast)
- ASDF version manager
- Starship prompt with Catppuccin Powerline (Machiatto theme)
- Nerd fonts (Fira Code, Iosevka)
- GNU Stow for easy management
- Automatic Homebrew PATH configuration
- Zsh completions, syntax highlighting, and history substring search
- Directory jumping with zoxide

## Prerequisites

- macOS
- Homebrew

## Quick Start

Run the setup command to install all dependencies and configure your environment:

```bash
make setup
```

Restart your shell to see changes. After setup, you can initialize ASDF (optional):
```bash
asdf init
```

Or use the individual commands:

```bash
make install   # Install dependencies
make stow      # Symlink dotfiles to home directory
```

## Available Commands

- `make help` - Show all available commands
- `make setup` - Install and configure all dependencies for a new machine
- `make install` - Install dependencies using Homebrew
- `make stow` - Symlink dotfiles to home directory
- `make unstow` - Remove symlinks from home directory
- `make clean` - Clean up temporary files

## Structure

```
.
├── Makefile              # Main entry point for commands
├── Brewfile              # Homebrew dependencies
├── README.md             # This file
├── config/               # Configuration packages (managed by GNU Stow)
│   ├── bash/             # Bash configuration
│   │   ├── .bashrc       # Main bashrc (sources .bashrc.d)
│   │   └── .bashrc.d/    # Bash snippets (loaded in numeric order)
│   │       ├── 10-homebrew.sh
│   │       ├── 30-zoxide.sh
│   │       ├── 40-starship.sh
│   │       ├── 50-modern-tools.sh
│   │       └── 55-aliases.sh
│   ├── gh/               # GitHub CLI configuration
│   │   └── .config/gh/config.yml
│   ├── ghostty/          # Ghostty terminal configuration
│   │   └── .config/ghostty/config
│   ├── git/              # Git configuration
│   │   ├── .gitconfig
│   │   └── .gitignore_global
│   ├── lazygit/          # Lazygit configuration
│   │   └── Library/Application Support/lazygit/config.yml
│   ├── nvim/             # Neovim configuration
│   │   └── .config/nvim/init.lua
│   ├── starship/         # Starship prompt configuration
│   │   └── .config/starship.toml
│   └── zsh/              # Zsh configuration
│       ├── .zshrc        # Main zshrc (sources .zshrc.d)
│       └── .zshrc.d/     # Zsh snippets (loaded in numeric order)
│           ├── 10-homebrew.zsh
│           ├── 20-zsh-completions.zsh
│           ├── 25-zsh-syntax-highlighting.zsh
│           ├── 30-zoxide.zsh
│           ├── 40-starship.zsh
│           ├── 45-globalias.zsh
│           ├── 50-modern-tools.zsh
│           └── 55-aliases.zsh
└── scripts/              # Setup scripts
    ├── setup.sh          # Main setup script
    ├── install.sh        # Install Homebrew dependencies
    ├── stow.sh           # Create symlinks
    └── unstow.sh         # Remove symlinks
```

## Configuration Management

This project uses GNU Stow for managing dotfiles. Each directory in `config/` is a Stow package that gets symlinked to your home directory.

For example, the starship configuration is stored in `config/starship/.config/starship.toml` and gets symlinked to `~/.config/starship.toml`.

## Adding New Tools

To add a new tool:

1. Add it to the `Brewfile`
2. Create a configuration directory in `config/<tool-name>/`
3. Add configuration files to the appropriate locations
4. Run `make stow` to symlink the new configuration

## Customization

### Starship Theme

The Starship prompt is configured with the Catppuccin Powerline preset using the Machiatto theme. To customize, edit `config/starship/.config/starship.toml`.

### Shell Configuration

Shell-specific configurations are in `config/bash/.bashrc.d/` and `config/zsh/.zshrc.d/`. Each file is sourced in numeric order:

**Bash:**
- `10-homebrew.sh` - Adds Homebrew binaries to PATH
- `30-zoxide.sh` - Loads zoxide for directory jumping
- `40-starship.sh` - Initializes starship prompt
- `50-modern-tools.sh` - Configures ASDF and modern aliases (eza, fd, ripgrep, bat, etc.)
- `55-aliases.sh` - General shell aliases

**Zsh:**
- `10-homebrew.zsh` - Adds Homebrew binaries to PATH
- `20-zsh-completions.zsh` - Loads zsh completions from Homebrew
- `25-zsh-syntax-highlighting.zsh` - Loads syntax highlighting for Zsh
- `27-zsh-history-substring-search.zsh` - Enables history substring search
- `30-zoxide.zsh` - Loads zoxide for directory jumping
- `40-starship.zsh` - Initializes starship prompt
- `45-globalias.zsh` - Enables alias expansion on space
- `50-modern-tools.zsh` - Configures ASDF and modern aliases (eza, fd, ripgrep, bat, etc.)
- `55-aliases.zsh` - General shell aliases

ASDF configuration handles missing initialization files gracefully, so it won't cause errors if not yet initialized.

### Tool Configurations

- **Git** - `config/git/.gitconfig` - Git settings (editor, pager, diff settings) with global gitignore
- **Global gitignore** - `config/git/.gitignore_global` - Common ignore patterns for all git projects
- **Neovim** - `config/nvim/.config/nvim/init.lua` - Modern Lua-based Neovim config
- **Lazygit** - `config/lazygit/Library/Application Support/lazygit/config.yml` - Git UI with Catppuccin theme
- **Ghostty** - `config/ghostty/.config/ghostty/config` - Terminal emulator with Catppuccin Macchiato theme
- **GitHub CLI** - `config/gh/.config/gh/config.yml` - Aliases for common gh commands

### Docker Setup

Docker and related tools are installed via Homebrew. To start Colima:

```bash
colima start
```

This provides a Docker daemon on macOS with minimal setup.

### Directory Jumping with zoxide

The `z` command (provided by zoxide) allows you to quickly jump to frequently visited directories. After using your shell for a while, zoxide will learn your most common directories:

```bash
z dotfiles    # Jump to dotfiles directory
z docs        # Jump to most recently visited docs directory
zi docs       # Interactive search with fzf (if installed)
```

Zoxide is a modern, faster replacement for z written in Rust. It builds a database of your directory usage and ranks directories by frequency and recency. The more you use a directory, the faster it will be to jump to it with `z`.

## Troubleshooting

**Command not found after new shell:**
```bash
# Restart your shell or manually source:
source ~/.bashrc   # for bash
source ~/.zshrc    # for zsh
```

**Verify tools are installed:**
```bash
which eza fd rg bat starship nvim gh lazygit
```

**Check symlinks:**
```bash
ls -la ~/.bashrc ~/.zshrc ~/.config/starship.toml
```

## License
Released under the [MIT License](https://opensource.org/licenses/MIT).
