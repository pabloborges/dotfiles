# Setup Scripts

This directory contains automation scripts for setting up and managing your macOS development environment.

## Setup Flow

The main setup process follows this sequence:

```
make setup
    ↓
scripts/setup.sh
    ↓
1. Check for Homebrew installation
2. scripts/install.sh → brew bundle install
3. scripts/stow.sh → create symlinks
4. scripts/macos-defaults.sh → configure system
```

## Script Details

### `setup.sh`
Main entry point that orchestrates the entire setup process:
- Validates prerequisites (macOS, Homebrew)
- Calls other scripts in the correct order
- Handles errors gracefully

### `install.sh`
Installs all Homebrew dependencies:
- Runs `brew bundle` using the repository Brewfile
- Installs tools, casks, and fonts
- Updates Homebrew before installation

### `stow.sh`
Creates symbolic links using GNU Stow:
- Iterates through all directories in `config/`
- Creates symlinks to `$HOME` using `stow -d config -t $HOME`
- Ensures proper ownership and permissions

### `unstow.sh`
Removes all symlinks:
- Safely removes all Stow-managed symlinks
- Useful for resetting the configuration

### `macos-defaults.sh`
Configures macOS system defaults for power users:
- **Idempotent**: Safe to run multiple times
- **Documented**: Each setting includes comments
- **Modular**: Organized by function categories

## macOS System Defaults

This script configures sensible defaults across multiple system areas:

### Finder
- Show hidden files and all file extensions
- Display status bar, path bar, and full paths
- Search current folder by default
- Use list view by default
- Show ~/Library folder
- Avoid creating .DS_Store files on network/USB volumes

### Dock
- Auto-hide with no delay
- Fast Mission Control animations
- Minimize windows into app icon
- Don't rearrange spaces automatically
- Show indicator lights for open applications

### Trackpad & Mouse
- Maximum tracking speed for both trackpad and mouse
- Enable two-finger secondary click

### Keyboard
- Fastest key repeat rate and shortest delay
- Disable press-and-hold (enables key repeat)
- Disable auto-correct, smart quotes, and smart dashes
- Enable full keyboard access for all controls
- Use function keys as standard function keys

### Screenshots
- Save to `~/Screenshots` directory (auto-created)
- PNG format without window shadows
- Include date in filename
- Show thumbnail after capture

### System UI
- Expand save/print panels by default
- Save to disk (not iCloud) by default
- Disable Resume system-wide
- Show battery percentage in menu bar
- Disable automatic app termination

### Applications
- **Activity Monitor**: Show all processes, visualize CPU in Dock
- **TextEdit**: Plain text mode with UTF-8 encoding
- **Terminal**: UTF-8 only, secure keyboard entry
- **App Store**: Enable automatic updates and background downloads
- **Photos**: Prevent auto-open when devices are plugged in
- **Chrome**: Use system print dialog, expand print panel

## Running Scripts Individually

You can run scripts independently of the Makefile:

```bash
# Install dependencies only
./scripts/install.sh

# Create symlinks only
./scripts/stow.sh

# Apply macOS defaults only
./scripts/macos-defaults.sh

# Remove all symlinks
./scripts/unstow.sh
```

## Customization

### Modifying macOS Defaults

Edit `macos-defaults.sh` to customize any setting:
- Each `defaults write` command is commented with options
- Change boolean values (`true`/`false`) to toggle settings
- Adjust numeric values for speeds, sizes, delays
- Modify string values for paths and preferences

### Adding New Defaults

Add new configuration functions following the existing pattern:

```bash
configure_new_tool() {
  log_info "Configuring New Tool..."
  
  # Add your defaults write commands here
  defaults write com.apple.NewTool SomeSetting -bool true
}
```

Then call the function in `main()`.

### Safe Script Execution

The scripts include safety measures:
- **Error handling**: `set -euo pipefail` for robust error handling
- **macOS check**: Validates running on macOS before proceeding
- **Graceful failures**: Some operations use `|| true` to avoid breaking the entire script
- **Logging**: Colored output for better visibility of operations

## Troubleshooting Script Issues

**Permission denied**:
```bash
chmod +x scripts/*.sh
```

**Homebrew not found**:
- Install Homebrew first: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
- Or run the full `make setup` which includes Homebrew installation

**Stow conflicts**:
- Run `make unstow` first to clean up existing symlinks
- Then run `make stow` to recreate them

**macOS defaults not applying**:
- Some settings require logging out or restarting
- Run the script multiple times safely (it's idempotent)
- Check System Preferences to verify changes