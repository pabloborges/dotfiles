# Source shared configs first, then zsh-specific configs
# Note: Stow symlinks shared files directly to $HOME, not to a .shared directory
for file in "$HOME"/[0-9][0-9]-*.sh; do
  [ -r "$file" ] && source "$file"
done

if [ -d "$HOME/.zshrc.d" ]; then
  for file in "$HOME/.zshrc.d"/*.zsh; do
    [ -r "$file" ] && source "$file"
  done
fi
