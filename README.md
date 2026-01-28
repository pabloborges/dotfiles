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
- Comprehensive shell completions and syntax highlighting
- Sensible macOS defaults for power users

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
- `make defaults` - Configure macOS system defaults (idempotent)
- `make clean` - Clean up temporary files

## Documentation

- [Configuration Management (config/)](./config/README.md) - How Stow packages, shared configs, and shell setups work
- [Setup Scripts (scripts/)](./scripts/README.md) - Details on installation and macOS system defaults

## License

Released under the [MIT License](https://opensource.org/licenses/MIT).
