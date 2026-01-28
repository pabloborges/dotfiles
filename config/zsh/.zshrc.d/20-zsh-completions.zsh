# Load zsh completions
# Homebrew site-functions (contains brew, asdf, etc.)
if [ -d "/opt/homebrew/share/zsh/site-functions" ]; then
  fpath=("/opt/homebrew/share/zsh/site-functions" $fpath)
fi
if [ -d "/usr/local/share/zsh/site-functions" ]; then
  fpath=("/usr/local/share/zsh/site-functions" $fpath)
fi

# Additional zsh-completions package
if [ -d "/opt/homebrew/share/zsh-completions" ]; then
  fpath=("/opt/homebrew/share/zsh-completions" $fpath)
fi
if [ -d "/usr/local/share/zsh-completions" ]; then
  fpath=("/usr/local/share/zsh-completions" $fpath)
fi

# Initialize completion system
autoload -Uz compinit && compinit
