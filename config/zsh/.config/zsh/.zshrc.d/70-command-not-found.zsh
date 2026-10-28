# Ubuntu-style command-not-found handler backed by Homebrew.
# When an unknown command is run, suggest the Homebrew formula that
# provides it (via `brew which-formula --explain`), or fall back to the
# standard "command not found" error.
# See: https://docs.brew.sh/Command-Not-Found

if [[ -r "$HOMEBREW_REPOSITORY/Library/Homebrew/command-not-found/handler.sh" ]]; then
    source "$HOMEBREW_REPOSITORY/Library/Homebrew/command-not-found/handler.sh"
fi
