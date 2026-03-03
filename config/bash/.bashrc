# Detect Homebrew location and add to PATH if not already present
if ! command -v brew &>/dev/null; then
	for loc in "/opt/homebrew/bin/brew" "$HOME/homebrew/bin/brew" "/usr/local/bin/brew"; do
		if [ -x "$loc" ]; then
			export PATH="$(dirname "$loc"):$PATH"
			break
		fi
	done
fi

# ASDF completions
if command -v brew &>/dev/null; then
	if [ -f "$(brew --prefix)/etc/bash_completion.d/asdf" ]; then
		. "$(brew --prefix)/etc/bash_completion.d/asdf"
	elif [ -f "$HOME/.asdf/completions/asdf.bash" ]; then
		. "$HOME/.asdf/completions/asdf.bash"
	fi
fi

# --- Zoxide ---
if command -v zoxide &>/dev/null; then
	eval "$(zoxide init bash)"
fi
