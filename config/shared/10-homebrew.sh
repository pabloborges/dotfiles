# Add Homebrew to PATH (dynamic detection)
if command -v brew &>/dev/null; then
	export PATH="$(brew --prefix)/bin:$PATH"
fi

# Load Homebrew bash completions (dynamic detection)
if [ -n "$BASH_VERSION" ] && command -v brew &>/dev/null; then
	if [ -f "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]; then
		. "$(brew --prefix)/etc/profile.d/bash_completion.sh"
	fi
fi
