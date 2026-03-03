# Source all zsh configs from .zshrc.d/
if [ -d "${ZDOTDIR:-$HOME/.config/zsh}/.zshrc.d" ]; then
  for zsh_file in "${ZDOTDIR:-$HOME/.config/zsh}/.zshrc.d/"*.zsh; do
    [ -r "$zsh_file" ] && [ -f "$zsh_file" ] && source "$zsh_file"
  done
fi
