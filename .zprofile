# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Homebrew completions
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
autoload -Uz compinit
compinit

