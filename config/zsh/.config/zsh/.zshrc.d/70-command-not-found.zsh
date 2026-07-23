# Ubuntu-style command-not-found handler backed by Homebrew.
# When an unknown command is run, suggest the Homebrew formula that
# provides it (via `brew which-formula --explain`), or fall back to the
# standard "command not found" error.
# See: https://docs.brew.sh/Command-Not-Found

if command -v brew >/dev/null 2>&1; then
    HOMEBREW_COMMAND_NOT_FOUND_HANDLER="$(brew --repository)/Library/Homebrew/command-not-found/handler.sh"
    if [[ -f "$HOMEBREW_COMMAND_NOT_FOUND_HANDLER" ]]; then
        source "$HOMEBREW_COMMAND_NOT_FOUND_HANDLER"
    fi
    unset HOMEBREW_COMMAND_NOT_FOUND_HANDLER
fi
