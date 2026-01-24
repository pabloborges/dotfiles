# Add ASDF to PATH
if [ -f "$HOME/.asdf/asdf.sh" ]; then
  . "$HOME/.asdf/asdf.sh"
fi
if [ -f "$HOME/.asdf/completions/asdf.bash" ]; then
  . "$HOME/.asdf/completions/asdf.bash"
fi

# Modern aliases
alias ls='eza --icons'
alias ll='eza --icons -la'
alias tree='eza --icons --tree'
alias cat='bat'
alias grep='rg'
alias find='fd'
