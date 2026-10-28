# Homebrew environment: exports HOMEBREW_PREFIX and prepends bin/sbin to PATH
_brew="$(command -v brew)"
if [ -z "$_brew" ]; then
	for loc in "/opt/homebrew/bin/brew" "$HOME/homebrew/bin/brew" "/usr/local/bin/brew"; do
		if [ -x "$loc" ]; then
			_brew="$loc"
			break
		fi
	done
fi
if [ -n "$_brew" ]; then
	eval "$("$_brew" shellenv bash)"
fi
unset _brew loc

# ASDF: prepend shims to PATH + load completions
# asdf >= 0.16 (Go rewrite) dropped asdf.sh; the binary lives on PATH via
# Homebrew and shims must be prepended manually.
if command -v asdf &>/dev/null; then
	export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
fi
if [ -n "${HOMEBREW_PREFIX:-}" ] && [ -f "$HOMEBREW_PREFIX/etc/bash_completion.d/asdf" ]; then
	. "$HOMEBREW_PREFIX/etc/bash_completion.d/asdf"
elif [ -f "$HOME/.asdf/completions/asdf.bash" ]; then
	. "$HOME/.asdf/completions/asdf.bash"
fi

# --- Zoxide ---
if command -v zoxide &>/dev/null; then
	eval "$(zoxide init bash)"
fi
