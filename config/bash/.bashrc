# Source all files in .bashrc.d
if [ -d "$HOME/.bashrc.d" ]; then
  for file in "$HOME/.bashrc.d"/*.sh; do
    [ -r "$file" ] && . "$file"
  done
fi
