if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
else
  echo "\033[1;31mstarship could not be found. Run:\033[0m"
  echo "brew install starship"
  echo "ln -s \$DOTFILES/config/starship.toml ~/.config/starship.toml"
  echo "\033[1;31mAnd try again\033[0m"
fi
