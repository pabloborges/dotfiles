#!/usr/bin/env bash

set -euo pipefail

# Colors for output
RED='\033[0;31m'
NC='\033[0m' # No Color

main() {
  echo "🔗 Removing symlinks..."

  # Check if GNU Stow is installed
  if ! command -v stow &> /dev/null; then
    echo "❌ GNU Stow is not installed"
    exit 1
  fi

  # Use stow to delete symlinks for all directories in config/
  for dir in config/*/; do
    if [ -d "$dir" ]; then
      local pkg_name
      pkg_name=$(basename "$dir")
      echo -e "${RED}→${NC} Unstowing $pkg_name"
      stow -D -d config -t "$HOME" "$pkg_name" 2>/dev/null || true
    fi
  done

  echo "✅ Symlinks removed"
}

main "$@"
