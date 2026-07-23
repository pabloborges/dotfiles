# Add ASDF shims to PATH (prioritize over system tools)
# asdf >= 0.16 (Go rewrite) dropped asdf.sh; the binary lives on PATH via
# Homebrew and shims must be prepended manually. Completions are provided
# separately (zsh: _asdf on fpath, bash: bash_completion.d/asdf).
if command -v asdf >/dev/null 2>&1; then
	export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
fi

# Modern tools aliases
alias l='eza --icons --git -lah'
alias ls='eza --icons'
alias ll='eza --icons -la'
alias tree='eza --icons --tree --level=2'
alias cat='bat --style=plain --pager never'
alias grep='rg'
alias find='fd'
