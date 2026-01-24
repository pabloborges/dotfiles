# Source all files in .zshrc.d
if [ -d "$HOME/.zshrc.d" ]; then
  for file in "$HOME/.zshrc.d"/*.zsh; do
    [ -r "$file" ] && source "$file"
  done
fi
