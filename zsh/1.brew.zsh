# Initialize Homebrew. This file must be sourced before any other files.
eval "$(/opt/homebrew/bin/brew shellenv)"

# Brew completion. See: https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi
