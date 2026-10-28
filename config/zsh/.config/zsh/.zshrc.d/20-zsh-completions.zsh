# Load zsh completions
# Homebrew site-functions (brew, asdf, etc.) are added to fpath by 10-homebrew.

# Additional zsh-completions package
[[ -d "$HOMEBREW_PREFIX/share/zsh-completions" ]] && fpath=("$HOMEBREW_PREFIX/share/zsh-completions" $fpath)

# Initialize completion system
autoload -Uz compinit && compinit

# Case-insensitive matching, then substring matching as fallback
# e.g., "read" matches "README.md", "file" matches "Brewfile"
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'l:|=* r:|=*'
