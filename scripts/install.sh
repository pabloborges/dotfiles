#!/usr/bin/env bash

set -euo pipefail

main() {
  echo "📦 Installing dependencies..."

  # Update Homebrew
  echo "Updating Homebrew..."
  brew update

  # Install Brewfile dependencies
  if [ -f "Brewfile" ]; then
    echo "Installing Brewfile dependencies..."
    brew bundle --file=Brewfile
  else
    echo "❌ Brewfile not found"
    exit 1
  fi

  echo "✅ Dependencies installed"
}

main "$@"
