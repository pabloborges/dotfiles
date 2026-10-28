#!/usr/bin/env bash

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

main() {
  echo "📦 Installing dependencies..."

  # Update Homebrew
  echo "Updating Homebrew..."
  brew update

  # Install Brewfile dependencies
  if [ -f "$REPO_ROOT/Brewfile" ]; then
    echo "Installing Brewfile dependencies..."
    brew bundle --file="$REPO_ROOT/Brewfile"
  else
    echo "❌ Brewfile not found"
    exit 1
  fi

  echo "✅ Dependencies installed"
}

main "$@"
