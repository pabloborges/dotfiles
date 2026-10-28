#!/usr/bin/env bash
#
# Link (or unlink) Stow packages from config/ into the target directory.
#
# Usage: scripts/stow.sh [--delete] [package...]
#   No packages: every directory in config/.
#   --delete:    remove the package's symlinks instead of creating them.
#   STOW_TARGET: target directory (default: $HOME).
#
# Linking uses --restow, so re-running also prunes stale links. A package that
# conflicts with an existing real file is skipped (stow is all-or-nothing per
# package); the rest still run, conflicts are reported at the end, and the
# script exits 1. Unknown package names exit 2 before anything is touched.

set -euo pipefail

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PACKAGE_DIR="$REPO_ROOT/config"
TARGET="${STOW_TARGET:-$HOME}"

all_packages() {
  local dir
  for dir in "$PACKAGE_DIR"/*/; do
    basename "$dir"
  done
}

main() {
  local mode="--restow" verb="Stowing" color="$GREEN"
  if [ "${1:-}" = "--delete" ]; then
    mode="--delete" verb="Unstowing" color="$RED"
    shift
  fi

  if ! command -v stow &>/dev/null; then
    echo "❌ GNU Stow is not installed. Please run: make install"
    exit 1
  fi

  local packages=("$@")
  if [ ${#packages[@]} -eq 0 ]; then
    # shellcheck disable=SC2207 # package names never contain whitespace
    packages=($(all_packages))
  fi

  local pkg
  for pkg in "${packages[@]}"; do
    if [ ! -d "$PACKAGE_DIR/$pkg" ]; then
      echo "❌ Unknown package: $pkg"
      echo "   Available: $(all_packages | tr '\n' ' ')"
      exit 2
    fi
  done

  # Keep ~/.config a real directory; otherwise stow folds it into a symlink to
  # the first package's .config/ and unrelated apps write into the repo.
  [ "$mode" = "--delete" ] || mkdir -p "$TARGET/.config"

  echo "🔗 $verb into $TARGET..."

  local failed=() output
  for pkg in "${packages[@]}"; do
    echo -e "${color}→${NC} $verb $pkg"
    if ! output=$(stow "$mode" -d "$PACKAGE_DIR" -t "$TARGET" "$pkg" 2>&1); then
      failed+=("$pkg")
      echo "$output" | sed 's/^/    /'
    fi
  done

  if [ ${#failed[@]} -gt 0 ]; then
    echo ""
    echo -e "${YELLOW}⚠${NC}  Skipped: ${failed[*]}"
    echo "   Move or delete the conflicting files listed above, then re-run make stow."
    exit 1
  fi

  echo "✅ Done"
}

main "$@"
