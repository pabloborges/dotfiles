#!/usr/bin/env bash

set -euo pipefail

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
  ./scripts/install.sh

  # Setup stow
  ./scripts/stow.sh

  # Configure Git user identity
  ./scripts/git-setup.sh

  # Configure macOS defaults
  ./scripts/macos-defaults.sh

  echo "✨ Setup complete! Please restart your shell to see changes."
}

main "$@"
