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
	# Ensure brew bin is in PATH (in case it was found but not via our loop)
	[[ ":$PATH:" != *":$BREW_PREFIX/bin:"* ]] && export PATH="$BREW_PREFIX/bin:$PATH"

	# Load Homebrew bash completions
	if [ -n "$BASH_VERSION" ]; then
		if [ -f "$BREW_PREFIX/etc/profile.d/bash_completion.sh" ]; then
			. "$BREW_PREFIX/etc/profile.d/bash_completion.sh"
		fi
	fi
else
	# Fail with a helpful message
	echo "Error: Homebrew (brew) could not be found in PATH or standard locations."
	echo "Standard locations searched: /opt/homebrew, ~/homebrew, /usr/local"
fi
