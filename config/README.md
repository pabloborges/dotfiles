# Configuration Packages

Each directory here is a [GNU Stow](https://www.gnu.org/software/stow/) package. Its contents mirror `$HOME`, and `make stow` symlinks them into place:

- `config/git/.gitconfig` → `~/.gitconfig`
- `config/starship/.config/starship.toml` → `~/.config/starship.toml`
- `config/zsh/.config/zsh/` → `~/.config/zsh/` (the whole directory is one link)

Because these are symlinks, editing `~/.config/...` edits the file in this repo.

## Packages

| Package | Links | Notes |
|---|---|---|
| `bash` | `~/.bashrc`, `~/.bash_profile` | Self-contained fallback shell |
| `gh` | `~/.config/gh/` | Aliases and editor; `hosts.yml` (auth state) is gitignored |
| `ghostty` | `~/.config/ghostty/` | Catppuccin Macchiato, Iosevka Nerd Font, `ssh-env` integration |
| `git` | `~/.gitconfig`, `~/.gitignore_global` | delta pager, rebase-on-pull, rerere; identity in `~/.gitconfig.local` |
| `lazygit` | `~/.config/lazygit/config.yml` | delta as diff renderer, nvim as editor |
| `nvim` | `~/.config/nvim/` | Single-file kickstart.nvim config (`init.lua`): Catppuccin Macchiato, Copilot via blink.cmp, diffview, oil.nvim |
| `starship` | `~/.config/starship.toml` | Catppuccin Powerline prompt, Mocha palette |
| `zsh` | `~/.zshenv`, `~/.config/zsh/` | Primary shell, see below |

## Zsh

`~/.zshenv` sets `XDG_CONFIG_HOME`, `ZDOTDIR=~/.config/zsh`, `EDITOR` and de-duplicates `PATH`. `.zshrc` then sources every `.zshrc.d/*.zsh` in numeric order:

| File | Purpose |
|---|---|
| `05-terminal.zsh` | Replace `TERM=dumb` so prompts and plugins work |
| `10-homebrew.zsh` | `brew shellenv`: PATH, `fpath`, `HOMEBREW_PREFIX` / `HOMEBREW_REPOSITORY` for later modules |
| `20-zsh-completions.zsh` | Extra completions, `compinit`, case-insensitive and substring matching |
| `21-fzf-tab.zsh` | fzf-powered completion menu (after `compinit`, before 25/26) |
| `22-fzf.zsh` | fzf key bindings (Ctrl-R, Ctrl-T, Alt-C); Up/Down search history by typed prefix |
| `25-zsh-syntax-highlighting.zsh` | Command-line syntax highlighting |
| `26-zsh-autosuggestions.zsh` | Fish-style inline suggestions |
| `30-zoxide.zsh` | `z` directory jumper |
| `40-starship.zsh` | Starship prompt |
| `45-globalias.zsh` | Expand aliases on Space (Ctrl-Space inserts a plain space) |
| `50-modern-tools.zsh` | asdf shims on PATH; `ls`/`cat`/`grep`/`find` aliased to eza/bat/rg/fd when installed |
| `55-aliases.zsh` | git and docker shortcuts |
| `60-functions.zsh` | `getenv [file]`: export variables from a `.env` file |
| `65-worktrunk.zsh` | Worktrunk (`wt`) shell integration |
| `70-command-not-found.zsh` | Suggest the Homebrew formula for an unknown command |
| `99-local.zsh` | Machine-local settings and secrets; gitignored, create it yourself |

Every module checks that its tool is installed, so a missing tool doesn't cause startup errors.

## Bash

`.bashrc` contains its own small setup (Homebrew, asdf, zoxide) and shares no files with zsh. `.bash_profile` sources it for login shells.

## Adding a tool

1. Add it to the `Brewfile` and run `make install`.
2. Create `config/<tool>/` with paths relative to `$HOME`, e.g. `config/<tool>/.config/<tool>/config`.
3. Run `make stow` (or `./scripts/stow.sh <tool>`).
4. For shell integration, add a guarded `.zshrc.d/NN-<tool>.zsh`, numbered by what it must load after.
5. Add the package or module to the tables above.

## Stow commands

- `make stow` / `make unstow`: link or unlink every package.
- `./scripts/stow.sh [--delete] <package>...`: link or unlink only the named packages.

See [`scripts/README.md`](../scripts/README.md#stowsh) for conflict handling.
