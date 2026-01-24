# Add ASDF to PATH
if [ -f "$HOME/.asdf/asdf.sh" ]; then
  . "$HOME/.asdf/asdf.sh"
fi
if [ -f "$HOME/.asdf/completions/asdf.bash" ]; then
  . "$HOME/.asdf/completions/asdf.bash"
fi

# Modern tools aliases
alias l='eza --icons --git -lah'
alias ls='eza --icons'
alias ll='eza --icons -la'
alias tree='eza --icons --tree --level=2'
alias cat='bat --style=plain --pager never'
alias grep='rg'
alias find='fd'
