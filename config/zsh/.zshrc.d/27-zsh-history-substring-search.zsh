# Load zsh history substring search
. "$(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh"

# Bind up and down arrows to substring search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down