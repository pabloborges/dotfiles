# Pablo's dotfiles

## Prerequisites

- [Homebrew](https://brew.sh/)
- [Oh My Zsh](https://ohmyz.sh/)

## Setup

### Clone repo:
```sh
 git clone --recurse-submodules git@github.com:pabloborges/dotfiles.git ~/dotfiles
```

### Install the Command Line Tools:
```sh
xcode-select --install
```

### Run `brew doctor` and address warnings
The `setup.sh` script relies heavily on `brew`.

### Run setup:
```sh
cd ~/dotfiles
./setup.sh
```

### Change the font to 'FiraCode Nerd Font Mono'
- iTerm2
- VS Code

### Recommended: Install VSCode Dark+.itermcolors
Neovim is configured to use the `VSCode Dark+` colorscheme. It's recommended to use the same colors for iTerm2: [VSCode Dark+.itermcolors](https://github.com/pabloborges/dotfiles/blob/main/extras/VSCode%20Dark%2B.itermcolors).

