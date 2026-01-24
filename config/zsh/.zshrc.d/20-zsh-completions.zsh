# Load zsh completions
if [ -d "/opt/homebrew/share/zsh-completions" ]; then
  fpath+=("/opt/homebrew/share/zsh-completions")
fi
if [ -d "/usr/local/share/zsh-completions" ]; then
  fpath+=("/usr/local/share/zsh-completions")
fi

# Initialize completion system
autoload -Uz compinit && compinit
