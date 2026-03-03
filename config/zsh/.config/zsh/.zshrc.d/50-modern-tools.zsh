# Add ASDF to PATH (prioritize over system tools)
if [ -f "$(brew --prefix asdf)/libexec/asdf.sh" ]; then
	. "$(brew --prefix asdf)/libexec/asdf.sh"
fi

# Modern tools aliases
alias l='eza --icons --git -lah'
alias ls='eza --icons'
alias ll='eza --icons -la'
alias tree='eza --icons --tree --level=2'
alias cat='bat --style=plain --pager never'
alias grep='rg'
alias find='fd'
