HOMEBREW_COMMAND_NOT_FOUND_HANDLER="$(brew --repository)/Library/Homebrew/command-not-found/handler.sh"
if [ -f "$HOMEBREW_COMMAND_NOT_FOUND_HANDLER" ]; then
  source "$HOMEBREW_COMMAND_NOT_FOUND_HANDLER";
fi
