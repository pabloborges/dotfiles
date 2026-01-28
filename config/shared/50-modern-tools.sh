# Add ASDF to PATH (prioritize over system tools)
if [ -f "$(brew --prefix asdf)/libexec/asdf.sh" ]; then
	. "$(brew --prefix asdf)/libexec/asdf.sh"
	# Ensure asdf shims and bin are first in PATH (avoid duplicates)
	if [[ ":$PATH:" != *":$HOME/.asdf/bin:"* ]]; then
		export PATH="$HOME/.asdf/bin:$HOME/.asdf/shims:$PATH"
	fi
fi

# ASDF completions (Bash only, Zsh uses fpath)
if [ -n "$BASH_VERSION" ]; then
	if [ -f "/opt/homebrew/etc/bash_completion.d/asdf" ]; then
		. "/opt/homebrew/etc/bash_completion.d/asdf"
	elif [ -f "/usr/local/etc/bash_completion.d/asdf" ]; then
		. "/usr/local/etc/bash_completion.d/asdf"
	elif [ -f "$HOME/.asdf/completions/asdf.bash" ]; then
		. "$HOME/.asdf/completions/asdf.bash"
	fi
fi

# Modern tools aliases
alias l='eza --icons --git -lah'
alias ls='eza --icons'
alias ll='eza --icons -la'
alias tree='eza --icons --tree --level=2'
alias cat='bat --style=plain --pager never'
alias grep='rg'
alias find='fd'
