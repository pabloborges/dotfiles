#!/usr/bin/env bash
#
# macOS System Defaults Configuration
#
# This script configures sensible defaults for macOS power users.
# It's idempotent - safe to run multiple times.
#
# Usage: ./scripts/macos-defaults.sh
#        make defaults

set -euo pipefail

# Colors for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly NC='\033[0m' # No Color

log_info() {
  echo -e "${GREEN}→${NC} $1"
}

log_warning() {
  echo -e "${YELLOW}⚠${NC} $1"
}

log_error() {
  echo -e "${RED}✗${NC} $1"
}

# Check if running on macOS
check_macos() {
  if [[ "$(uname)" != "Darwin" ]]; then
    log_error "This script is only for macOS"
    exit 1
  fi
}

# Finder settings
configure_finder() {
  log_info "Configuring Finder..."

  # Show hidden files by default
  # Change to "false" to hide hidden files
  defaults write com.apple.finder AppleShowAllFiles -bool true

  # Show all filename extensions
  # Change to "false" to hide extensions for known file types
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true

  # Show status bar at bottom of Finder windows
  # Displays item count and available space
  defaults write com.apple.finder ShowStatusBar -bool true

  # Show path bar at bottom of Finder windows
  # Displays the full path to current location
  defaults write com.apple.finder ShowPathbar -bool true

  # Display full POSIX path as Finder window title
  # Shows complete file path in window title bar
  defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

  # Keep folders on top when sorting by name
  # Folders appear before files in lists
  defaults write com.apple.finder _FXSortFoldersFirst -bool true

  # Search the current folder by default
  # When searching, defaults to "This Mac" if set to "SCev"
  # "SCcf" = Search current folder
  defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

  # Disable warning when changing a file extension
  # Removes confirmation dialog
  defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

  # Use list view in all Finder windows by default
  # Options: "icnv" = Icon view, "Nlsv" = List view, "clmv" = Column view, "glyv" = Gallery view
  defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

  # Show the ~/Library folder
  # Makes Library visible in Finder
  chflags nohidden ~/Library

  # Show the /Volumes folder
  # Makes mounted volumes visible
  # sudo chflags nohidden /Volumes 2>/dev/null || true

  # Avoid creating .DS_Store files on network volumes
  # Prevents metadata files on network shares
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

  # Avoid creating .DS_Store files on USB volumes
  # Prevents metadata files on external drives
  defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

  # Disable disk image verification
  # Speeds up DMG mounting
  defaults write com.apple.frameworks.diskimages skip-verify -bool true
  defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
  defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

  # Show item info near icons on the desktop and in other icon views
  defaults write com.apple.finder ShowItemInfo -bool true

  # Enable snap-to-grid for icons on the desktop and in other icon views
  /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist 2>/dev/null || true
  /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist 2>/dev/null || true
  /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist 2>/dev/null || true
}

# Dock settings
configure_dock() {
  log_info "Configuring Dock..."

  # Automatically hide and show the Dock
  # Dock slides in when mouse moves to edge
  defaults write com.apple.dock autohide -bool true

  # Remove the auto-hiding Dock delay
  # Dock appears instantly when mouse moves to edge
  # Set to 0.5 for a slight delay, 0 for instant
  defaults write com.apple.dock autohide-delay -float 0

  # Speed up Mission Control animations
  # Reduces animation time when entering/exiting Mission Control
  # Set to 0.1 for very fast, 0.15 for fast, 0.2 for moderate
  defaults write com.apple.dock expose-animation-duration -float 0.1

  # Group windows by application in Mission Control
  defaults write com.apple.dock expose-group-apps -bool true

  # Don't automatically rearrange Spaces based on most recent use
  # Keeps spaces in the order you arranged them
  defaults write com.apple.dock mru-spaces -bool false

  # Minimize windows into their application's icon
  # Windows minimize into the app icon instead of a separate dock icon
  defaults write com.apple.dock minimize-to-application -bool true

  # Show indicator lights for open applications
  # Small dot appears under running apps
  defaults write com.apple.dock show-process-indicators -bool true

  # Don't show recent applications in Dock
  # Removes the "Recent Applications" section
  defaults write com.apple.dock show-recents -bool false

  # Set the icon size of Dock items
  # Size in pixels (default: 48, range: 16-128)
  defaults write com.apple.dock tilesize -int 48

  # Set Dock position on screen
  # Options: "left", "bottom", "right"
  defaults write com.apple.dock orientation -string "bottom"

  # Make Dock icons of hidden applications translucent
  # Visually indicates which apps are hidden
  defaults write com.apple.dock showhidden -bool true
}

# Trackpad and Mouse settings
configure_trackpad() {
  log_info "Configuring Trackpad & Mouse..."

  # Set trackpad tracking speed
  # Range: 0 (slow) to 3 (fast)
  # Default is around 1, maximum is 3
  defaults write NSGlobalDomain com.apple.trackpad.scaling -float 3

  # Set mouse tracking speed
  # Range: 0 (slow) to 3 (fast)
  defaults write NSGlobalDomain com.apple.mouse.scaling -float 3

  # Enable secondary click with two fingers
  # Right-click by tapping with two fingers
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
  defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true
  defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

  # To enable tap to click: defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
  # To enable three-finger drag: requires accessibility settings
}

# Keyboard settings
configure_keyboard() {
  log_info "Configuring Keyboard..."

  # Set a blazingly fast keyboard repeat rate
  # Values: KeyRepeat (lower = faster), InitialKeyRepeat (delay before repeat)
  # KeyRepeat: 2 = very fast, 6 = fast (default: 6, minimum: 2)
  # InitialKeyRepeat: 15 = very short, 25 = short (default: 25, minimum: 15)
  defaults write NSGlobalDomain KeyRepeat -int 2
  defaults write NSGlobalDomain InitialKeyRepeat -int 15

  # Disable press-and-hold for keys in favor of key repeat
  # Allows holding down keys to repeat them (good for vim-style navigation)
  # Set to "true" to enable press-and-hold for accented characters
  defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

  # Disable automatic capitalization
  # Prevents iOS-style auto-capitalization
  defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

  # Disable smart dashes
  # Prevents automatic conversion of -- to em dash
  defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

  # Disable automatic period substitution
  # Prevents double-space from inserting a period
  defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

  # Disable smart quotes
  # Prevents automatic conversion of straight quotes to curly quotes
  defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

  # Disable auto-correct
  # Stops automatic spelling corrections as you type
  defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

  # Enable full keyboard access for all controls
  # Tab between all controls in dialogs (not just text fields)
  # 1 = Text boxes and lists only, 3 = All controls
  defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
}

# Screenshot settings
configure_screenshots() {
  log_info "Configuring Screenshots..."

  # Create Screenshots directory if it doesn't exist
  mkdir -p "${HOME}/Screenshots"

  # Save screenshots to ~/Screenshots instead of Desktop
  # Change path to move screenshots elsewhere
  defaults write com.apple.screencapture location -string "${HOME}/Screenshots"

  # Save screenshots in PNG format
  # Options: "PNG", "JPG", "GIF", "PDF", "TIFF"
  # PNG offers best quality, JPG for smaller file size
  defaults write com.apple.screencapture type -string "PNG"

  # Disable shadow in screenshots
  # Removes the drop shadow around window screenshots
  # Set to "true" to include shadow
  defaults write com.apple.screencapture disable-shadow -bool true

  # Include date in screenshot filename
  # Set to "false" to exclude date/time
  defaults write com.apple.screencapture include-date -bool true

  # Show thumbnail after taking screenshot
  # Small preview appears in corner for quick editing
  # Set to "false" to disable thumbnail
  defaults write com.apple.screencapture show-thumbnail -bool true
}

# System UI/UX settings
configure_system_ui() {
  log_info "Configuring System UI/UX..."

  # Expand save panel by default
  # Shows full file browser in save dialogs
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

  # Expand print panel by default
  # Shows all printing options
  defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
  defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

  # Save to disk (not to iCloud) by default
  # New documents save locally unless you specify iCloud
  defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

  # Automatically quit printer app once the print jobs complete
  # Prevents printer app from staying open
  defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

  # Disable the "Are you sure you want to open this application?" dialog
  # Removes warning when opening downloaded applications
  defaults write com.apple.LaunchServices LSQuarantine -bool false

  # Disable Resume system-wide
  # Prevents apps from reopening windows on restart
  defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

  # Disable automatic termination of inactive apps
  # Prevents macOS from closing apps automatically
  defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

  # Reveal IP address, hostname, OS version when clicking the clock in login window
  # Useful for system administrators
  # sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

  # Restart automatically if the computer freezes
  # System will automatically reboot after a system freeze
  # sudo systemsetup -setrestartfreeze on 2>/dev/null || true

  # Disable Notification Center
  # Removes notification center completely
  # Set to "false" to enable notification center
  # launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2>/dev/null || true

  # Disable the crash reporter
  # Set to "basic" or "developer" to enable
  defaults write com.apple.CrashReporter DialogType -string "none"

  # Set sidebar icon size to medium
  # Options: 1 = Small, 2 = Medium, 3 = Large
  defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

  # Increase window resize speed for Cocoa applications
  # Makes window resizing feel snappier
  defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

  # Disable automatic emoji substitution
  # Prevents text like :) from becoming emoji
  defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false

  # Menu bar: show battery percentage
  # Displays exact battery percentage in menu bar
  defaults write com.apple.menuextra.battery ShowPercent -string "YES"
}

# Activity Monitor settings
configure_activity_monitor() {
  log_info "Configuring Activity Monitor..."

  # Show the main window when launching Activity Monitor
  defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

  # Visualize CPU usage in the Activity Monitor Dock icon
  # Options: 0 = Application icon, 5 = CPU History, 6 = CPU Usage
  defaults write com.apple.ActivityMonitor IconType -int 5

  # Show all processes in Activity Monitor
  # Options: 100 = All Processes, 101 = My Processes
  defaults write com.apple.ActivityMonitor ShowCategory -int 100

  # Sort Activity Monitor results by CPU usage
  # Options: "CPUUsage", "processName", "realMemorySize", etc.
  defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
  defaults write com.apple.ActivityMonitor SortDirection -int 0
}

# TextEdit settings
configure_textedit() {
  log_info "Configuring TextEdit..."

  # Use plain text mode for new TextEdit documents
  # Set to "false" for rich text mode
  defaults write com.apple.TextEdit RichText -int 0

  # Open and save files as UTF-8 in TextEdit
  # UTF-8 encoding is the modern standard
  defaults write com.apple.TextEdit PlainTextEncoding -int 4
  defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4
}

# Terminal settings
configure_terminal() {
  log_info "Configuring Terminal..."

  # Only use UTF-8 in Terminal.app
  # Ensures proper character encoding
  defaults write com.apple.terminal StringEncodings -array 4

  # Enable Secure Keyboard Entry in Terminal.app
  # Prevents other applications from detecting keystrokes
  # See: https://security.stackexchange.com/a/47786/8918
  defaults write com.apple.terminal SecureKeyboardEntry -bool true

  # Disable the annoying line marks in Terminal
  # Removes line marks that appear in Terminal
  defaults write com.apple.Terminal ShowLineMarks -int 0
}

# App Store settings
configure_app_store() {
  log_info "Configuring App Store..."

  # Enable the automatic update check
  defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

  # Check for software updates daily, not just once per week
  defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

  # Download newly available updates in background
  defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

  # Install System data files & security updates
  defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

  # Turn on app auto-update
  defaults write com.apple.commerce AutoUpdate -bool true

  # Allow the App Store to reboot machine on macOS updates
  # Set to "false" to require manual restart
  defaults write com.apple.commerce AutoUpdateRestartRequired -bool true
}

# Photos settings
configure_photos() {
  log_info "Configuring Photos..."

  # Prevent Photos from opening automatically when devices are plugged in
  defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true
}

# Google Chrome settings
configure_chrome() {
  log_info "Configuring Google Chrome..."

  # Use the system print dialog in Chrome
  defaults write com.google.Chrome DisablePrintPreview -bool true
  defaults write com.google.Chrome.canary DisablePrintPreview -bool true

  # Expand the print dialog by default
  defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true
  defaults write com.google.Chrome.canary PMPrintingExpandedStateForPrint2 -bool true
}

# Main execution
main() {
  echo "⚙️  Configuring macOS defaults..."
  echo ""

  check_macos

  # Run all configuration functions
  configure_finder
  configure_dock
  configure_trackpad
  configure_keyboard
  configure_screenshots
  configure_system_ui
  configure_activity_monitor
  configure_textedit
  configure_terminal
  configure_app_store
  configure_photos
  configure_chrome

  echo ""
  log_warning "Some changes require logging out or restarting to take effect"

  # Restart affected applications
  log_info "Restarting affected applications..."

  for app in "Activity Monitor" "Finder" "Dock" "SystemUIServer"; do
    killall "${app}" &> /dev/null || true
  done

  echo ""
  echo "✨ macOS defaults configured successfully!"
}

main "$@"
