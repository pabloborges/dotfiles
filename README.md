# Dotfiles

macOS dotfiles managed with GNU Stow and Homebrew. Setup needs no admin rights.

## What's included

- **Shell**: zsh with fzf, fzf-tab, autosuggestions, syntax highlighting, zoxide and a Starship prompt; bash as a minimal fallback
- **CLI tools**: eza, bat, ripgrep, fd, jq, httpie, tealdeer, htop
- **Development**: git with delta, gh, lazygit, Neovim (kickstart.nvim), asdf, worktrunk, opencode
- **Containers**: colima with the docker CLI, buildx and compose, started at login
- **Apps and fonts**: Ghostty, Raycast, Fira Code and Iosevka Nerd Fonts
- **Theme**: Catppuccin across Ghostty, Neovim and Starship
- **macOS defaults**: Finder, Dock, keyboard, screenshots and more

The [`Brewfile`](./Brewfile) has the full list.

## Quick start

Install [Homebrew](https://brew.sh), then:

```bash
git clone https://github.com/pabloborges/dotfiles.git ~/dotfiles
cd ~/dotfiles
make setup
```

`make setup` installs the Brewfile, links the configs, starts colima at login, prompts for your git name and email, and applies the macOS defaults. Restart your shell afterwards.

If a file already exists where a link should go, `make stow` skips that package, lists the file, and exits non-zero. Move the file aside and run `make stow` again.

## Commands

| Command | Description |
|---|---|
| `make help` | List all targets |
| `make setup` | Full setup for a new machine |
| `make install` | Install Homebrew dependencies |
| `make stow` | Symlink configs into `$HOME` |
| `make unstow` | Remove those symlinks |
| `make defaults` | Apply macOS defaults (safe to re-run) |
| `make colima-autostart` | Start colima at login |
| `make clean` | Remove editor temp files |

## Machine-local settings

These files are gitignored, so you create them on each machine:

- `~/.gitconfig.local`: git name, email and signing key. `make setup` writes it.
- `~/.config/zsh/.zshrc.d/99-local.zsh`: extra environment variables, PATH entries and secrets.

## Documentation

- [`config/README.md`](./config/README.md): packages, zsh module load order, adding a tool
- [`scripts/README.md`](./scripts/README.md): setup flow, scripts, macOS defaults applied

## License

[MIT](./MIT-LICENSE)
