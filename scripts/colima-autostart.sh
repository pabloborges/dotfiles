#!/usr/bin/env bash

set -euo pipefail

# Starts colima at login via a user LaunchAgent. `brew services start colima`
# is not used because its agent only sets PATH: without XDG_CONFIG_HOME, colima
# falls back to ~/.colima and boots a fresh, empty VM instead of the one in
# ~/.config/colima.

LABEL="com.github.abiosoft.colima"
PLIST="$HOME/Library/LaunchAgents/$LABEL.plist"

main() {
  if ! command -v colima &>/dev/null; then
    echo "⚠️  colima is not installed, skipping autostart"
    return
  fi

  local brew_prefix
  brew_prefix="$(brew --prefix)"

  echo "🐳 Configuring colima to start at login..."

  mkdir -p "$(dirname "$PLIST")" "$HOME/Library/Logs"
  cat >"$PLIST" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>$LABEL</string>
  <key>ProgramArguments</key>
  <array>
    <string>$brew_prefix/bin/colima</string>
    <string>start</string>
  </array>
  <key>EnvironmentVariables</key>
  <dict>
    <key>PATH</key>
    <string>$brew_prefix/bin:$brew_prefix/sbin:/usr/bin:/bin:/usr/sbin:/sbin</string>
    <key>HOME</key>
    <string>$HOME</string>
    <key>XDG_CONFIG_HOME</key>
    <string>$HOME/.config</string>
  </dict>
  <key>RunAtLoad</key>
  <true/>
  <key>StandardOutPath</key>
  <string>$HOME/Library/Logs/colima.log</string>
  <key>StandardErrorPath</key>
  <string>$HOME/Library/Logs/colima.log</string>
</dict>
</plist>
EOF

  # Reload so plist changes take effect; bootout fails harmlessly if not loaded
  launchctl bootout "gui/$(id -u)/$LABEL" 2>/dev/null || true
  launchctl bootstrap "gui/$(id -u)" "$PLIST"

  echo "✅ colima will start at login (logs: ~/Library/Logs/colima.log)"
}

main "$@"
