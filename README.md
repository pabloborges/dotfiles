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

### Install Solarized Dark Higher Contrast (required for `zsh-completions` to work)
The default Solarized Dark theme that comes with iTerm2 interprests the gray colour as equal as the background. To fix this, install [extras/Solarized Dark Higher Contrast.itermcolors](https://github.com/pabloborges/dotfiles/blob/main/extras/Solarized%20Dark%20Higher%20Contrast.itermcolors).
