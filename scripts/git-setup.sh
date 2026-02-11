#!/usr/bin/env bash

set -euo pipefail

GITCONFIG_LOCAL="$HOME/.gitconfig.local"

main() {
  if [ -f "$GITCONFIG_LOCAL" ]; then
    echo "✅ Git user config already exists at $GITCONFIG_LOCAL, skipping"
    return
  fi

  echo "🔧 Setting up Git user identity..."
  echo "   This will be saved to $GITCONFIG_LOCAL (not tracked by Git)"
  echo ""

  read -rp "Git name: " git_name
  read -rp "Git email: " git_email

  read -rp "GPG signing key (leave empty to skip): " git_signingkey

  {
    echo "[user]"
    echo "  name = $git_name"
    echo "  email = $git_email"
    if [ -n "$git_signingkey" ]; then
      echo "  signingkey = $git_signingkey"
      echo ""
      echo "[commit]"
      echo "  gpgsign = true"
    fi
  } > "$GITCONFIG_LOCAL"

  echo ""
  echo "✅ Git user config saved to $GITCONFIG_LOCAL"
}

main "$@"
