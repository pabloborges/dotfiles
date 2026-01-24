# Load zsh history substring search
if [ -f "/opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh" ]; then
  . "/opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
fi
if [ -f "/usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh" ]; then
  . "/usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
fi

# Bind up and down arrows to substring search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down