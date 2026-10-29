# Setup Scripts

Every script works from any directory and needs no admin rights. You normally run them through `make`.

## Setup flow

`make setup` runs `setup.sh`, which:

1. Checks that Homebrew is installed and stops if it isn't
2. Runs `install.sh`: `brew update` and `brew bundle` on the repo `Brewfile`
3. Runs `stow.sh`: symlinks every package in `config/`
4. Runs `colima-autostart.sh`: starts colima at login
5. Runs `git-setup.sh`: prompts for your git identity
6. Runs `macos-defaults.sh`: applies the system defaults below

`setup.sh` stops at the first step that fails.

## Scripts

### `install.sh`
Runs `brew update`, then `brew bundle` on the repo `Brewfile` (formulae, casks and fonts).

### `stow.sh`
Links or unlinks Stow packages: `stow.sh [--delete] [package...]`
- Without arguments it handles every directory in `config/`; otherwise only the named packages
- Links with `stow --restow`, so running it again also removes stale links
- `--delete` removes the symlinks; this is what `make unstow` runs
- Creates `~/.config` first, so Stow never replaces that directory with a single symlink into the repo
- Links into `$HOME`; set `STOW_TARGET` to link into another directory (e.g. a `mktemp -d` dry run)

If a package has a conflict, the script skips it, still links the rest, and lists the conflicts at the end. A conflict means a real file already exists where a link should go. The script exits 1 if any package was skipped. It exits 2 on an unknown package name, before changing anything.

### `colima-autostart.sh`
Installs a user LaunchAgent that runs `colima start` at login:
- Writes `~/Library/LaunchAgents/com.github.abiosoft.colima.plist` and loads it
- Sets `XDG_CONFIG_HOME` so colima uses the VM in `~/.config/colima`. `brew services start colima` doesn't set it, so colima would boot a new, empty VM from `~/.colima` instead
- Logs to `~/Library/Logs/colima.log`
- Safe to re-run; skips if colima is not installed

### `git-setup.sh`
Prompts for your git name, email and an optional GPG signing key. It writes them to `~/.gitconfig.local`, which `.gitconfig` includes. If that file already exists, it changes nothing.

### `macos-defaults.sh`
Applies the defaults below with `defaults write`. It's safe to run again; each setting has a comment showing its options. It then restarts Finder, Dock, SystemUIServer and Activity Monitor. Some settings only take effect after you log out. Settings that need sudo are commented out.

## macOS defaults

### Finder
- Show hidden files, all extensions, status bar, path bar, and the full path in the title
- Folders first, search the current folder, list view by default
- No warning when changing an extension
- Show `~/Library`; show item info and snap icons to grid
- No `.DS_Store` on network or USB volumes; skip disk image verification

### Dock and Mission Control
- Auto-hide with no delay; 48px icons at the bottom; hidden apps translucent
- Minimize windows into their app icon; hide recent apps
- Fast Mission Control animation, windows grouped by app, Spaces not reordered

### Trackpad and mouse
- Maximum tracking speed
- Two-finger secondary click

### Keyboard
- Fastest key repeat and shortest delay; press-and-hold disabled
- Auto-capitalization, smart dashes and quotes, period substitution, and autocorrect disabled
- Full keyboard access for all controls

### Screenshots
- Saved to `~/Screenshots` (created if missing) as PNG with the date in the name
- No window shadow; thumbnail preview on

### System UI
- Save and print panels expanded; new documents save to disk rather than iCloud
- Printer app quits when jobs finish
- No "downloaded app" quarantine prompt; no crash reporter dialog
- Resume and automatic app termination disabled
- Faster window resizing, medium sidebar icons, battery percentage in the menu bar
- No automatic emoji substitution in Messages

### Apps
- **Activity Monitor**: opens the main window, shows all processes sorted by CPU, CPU history in the Dock icon
- **TextEdit**: plain text, UTF-8
- **Terminal.app**: UTF-8 only, Secure Keyboard Entry, no line marks
- **Software Update / App Store**: daily checks, background downloads, security updates and app auto-updates, restart allowed for macOS updates
- **Photos**: doesn't open when a device is plugged in
- **Chrome**: system print dialog, expanded print panel

## Customizing defaults

Edit the matching `configure_*` function in `macos-defaults.sh`. To add an area, write a new `configure_<area>` function and call it from `main()`.

## Troubleshooting

- **`⚠ Skipped: <package>`** from `make stow`: a real file exists where a link should go, and the output names it. Back it up if you need its settings, remove it, then run `make stow` again.
- **Homebrew not found**: install it from [brew.sh](https://brew.sh), then run `make setup` again.
- **A default didn't apply**: log out and back in; some settings only load at login.
