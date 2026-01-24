#!/usr/bin/env bash

set -euo pipefail

# Colors for output
GREEN='\033[0;32m'
NC='\033[0m' # No Color

main() {
  echo "🔗 Symlinking dotfiles..."

  # Check if GNU Stow is installed
  if ! command -v stow &> /dev/null; then
    echo "❌ GNU Stow is not installed. Please run: make install"
    exit 1
  fi

  # Use stow to create symlinks for all directories in config/
  for dir in config/*/; do
    if [ -d "$dir" ]; then
      local pkg_name
      pkg_name=$(basename "$dir")
      echo -e "${GREEN}→${NC} Stowing $pkg_name"
      stow -d config -t "$HOME" "$pkg_name" 2>/dev/null || true
    fi
  done

  echo "✅ Symlinks created"
}

main "$@"
