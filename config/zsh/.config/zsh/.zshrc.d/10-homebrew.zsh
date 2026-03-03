# Detect Homebrew location and add to PATH if not already present
if ! command -v brew &>/dev/null; then
	for loc in "/opt/homebrew/bin/brew" "$HOME/homebrew/bin/brew" "/usr/local/bin/brew"; do
		if [ -x "$loc" ]; then
			export PATH="$(dirname "$loc"):$PATH"
			break
		fi
	done
fi

# Set up Homebrew environment if found
if command -v brew &>/dev/null; then
	BREW_PREFIX="$(brew --prefix)"

	# Always ensure Homebrew paths are at the front of PATH
	# This is necessary because macOS's /etc/zprofile runs path_helper which
	# reorders PATH and can put /usr/bin before /opt/homebrew/bin
	# Remove existing Homebrew paths first, then prepend them
	PATH="$(echo "$PATH" | tr ':' '\n' | grep -v "^$BREW_PREFIX" | tr '\n' ':' | sed 's/:$//')"
	export PATH="$BREW_PREFIX/bin:$BREW_PREFIX/sbin:$PATH"
else
	# Fail with a helpful message
	echo "Error: Homebrew (brew) could not be found in PATH or standard locations."
	echo "Standard locations searched: /opt/homebrew, ~/homebrew, /usr/local"
fi

# Reproduces Ubuntu's command-not-found for Homebrew users on macOS.
HOMEBREW_COMMAND_NOT_FOUND_HANDLER="$(brew --repository)/Library/Homebrew/command-not-found/handler.sh"
if [ -f "$HOMEBREW_COMMAND_NOT_FOUND_HANDLER" ]; then
	source "$HOMEBREW_COMMAND_NOT_FOUND_HANDLER";
fi
