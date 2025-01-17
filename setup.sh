#!/usr/bin/env bash +e

if ! command -v brew &> /dev/null; then
  echo "brew could not be found. Install brew and oh-my-zsh and try again"
  exit 1
fi

SCRIPT_DIR=$(dirname $0)

brew tap homebrew/command-not-found # Suggests packages to be installed if a command cannot be found

echo "Installing dependencies and other useful commands"
brew install --quiet applite bat coreutils eza fd font-fira-code-nerd-font ghostty git git-extras httpie jq neovim \
  procs rbenv ripgrep ruby-build sd sourcetree starship tldr tmux wget zsh zsh-completions zsh-syntax-highlighting

echo "Adding symlinks"
ln -sf ~/dotfiles/.aliases ~/.aliases
ln -sf ~/dotfiles/.gemrc ~/.gemrc
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.gitignore_global ~/.gitignore_global
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sd ~/dotfiles/.zprofile ~/.zprofile
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/tmux ~/.tmux
ln -sf ~/dotfiles/config/nvim ~/.config/nvim
ln -sf ~/dotfiles/config/starship.toml ~/.config/starship.toml
ln -sf ~/dotfiles/config/todo.cfg ~/.todo.cfg
ln -sf $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ~/dotfiles/zsh/after/zsh-syntax-highlighting.zsh

mkdir -p $SCRIPT_DIR/zsh/custom/
echo "\
# You can put files here to add functionality separated per file, which
# will be ignored by git.\
" > $SCRIPT_DIR/zsh/custom/example.zsh

echo "Your system is ready! Reloading the shell..."
exec ${SHELL} -l
