# Load zsh-autosuggestions for Fish-like inline suggestions
if command -v brew &>/dev/null; then
    BREW_PREFIX="$(brew --prefix)"
    source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" 2>/dev/null
fi
