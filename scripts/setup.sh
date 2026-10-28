#!/usr/bin/env bash

set -euo pipefail

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

main() {
  echo "🚀 Setting up dotfiles..."

  # Check if Homebrew is installed
  if ! command -v brew &> /dev/null; then
    echo "❌ Homebrew is not installed. Please install it first:"
    echo "   /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    exit 1
  fi

  echo "✅ Homebrew found"

  # Install dependencies
  "$SCRIPTS_DIR"/install.sh

  # Setup stow
  "$SCRIPTS_DIR"/stow.sh

  # Start colima at login
  "$SCRIPTS_DIR"/colima-autostart.sh

  # Configure Git user identity
  "$SCRIPTS_DIR"/git-setup.sh

  # Configure macOS defaults
  "$SCRIPTS_DIR"/macos-defaults.sh

  echo "✨ Setup complete! Please restart your shell to see changes."
}

main "$@"
