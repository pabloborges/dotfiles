# Initialize Starship prompt
if [ -n "${BASH_VERSION:-}" ]; then
  eval "$(starship init bash)"
elif [ -n "${ZSH_VERSION:-}" ]; then
  eval "$(starship init zsh)"
fi
