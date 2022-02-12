# Pablo's dotfiles

## Prerequisites

- [Homebrew](https://brew.sh/)
- [Oh My Zsh](https://ohmyz.sh/)

## Setup

### Install dependencies and other useful commands
```sh
brew install coreutils git git-extras ripgrep starship tldr todo-txt wget zsh zsh-completions zsh-syntax-highlighting
```

### Clone repo:
```sh
git clone git@github.com:pabloborges/dotfiles.git ~/dotfiles
```

### Add symlinks
```sh
ln -sf ~/dotfiles/.aliases ~/.aliases
ln -sf ~/dotfiles/.gemrc ~/.gemrc
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.gitignore_global ~/.gitignore_global
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/config/starship.toml ~/.config/starship.toml
ln -sf ~/dotfiles/config/todo.cfg ~/.todo.cfg
```

### (Optional) Install Solarized Dark Higher Contrast
The default Solarized Dark theme that comes with iTerm2, doesn't work well with `zsh-completions`.
