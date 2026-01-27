# Source shared configs first, then bash-specific configs
# Note: Stow symlinks shared files directly to $HOME, not to a .shared directory
for file in "$HOME"/[0-9][0-9]-*.sh; do
  [ -r "$file" ] && . "$file"
done

if [ -d "$HOME/.bashrc.d" ]; then
  for file in "$HOME/.bashrc.d"/*.sh; do
    [ -r "$file" ] && . "$file"
  done
fi
