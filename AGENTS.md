# AGENTS.md

macOS dotfiles managed with GNU Stow. Every directory in `config/` is a Stow
package that mirrors `$HOME`; `make stow` symlinks it into place. `make help`
lists the entry points.

## Before you edit

- **The home directory is the repo.** `~/.config/zsh`, `~/.config/nvim`,
  `~/.gitconfig` etc. are symlinks into `config/`, so editing either path edits
  the same file and takes effect immediately. Directory-level links also mean
  tools write runtime state into the repo (zsh history, `.zcompdump`, nvim
  `lazy-lock.json`); add such files to `.gitignore`.
- **This repo is public.** Keep machine- and employer-specific values (work
  accounts, internal URLs, CA paths, API keys) out of tracked files. They belong
  in the gitignored locals: `config/zsh/.config/zsh/.zshrc.d/99-local.zsh` and
  `~/.gitconfig.local` (created by `scripts/git-setup.sh`). gh's `hosts.yml` is
  ignored for the same reason.
- **No sudo.** `make setup` must run without admin rights; sudo-only defaults in
  `scripts/macos-defaults.sh` stay commented out.

## Shell config

- **Zsh is primary; bash is a self-contained fallback.** `.bashrc` deliberately
  inlines its own minimal setup instead of sharing files with zsh. Mirror
  relevant zsh changes there by hand.
- **`.zshrc.d/NN-*.zsh` load in numeric order**; choose `NN` by dependency
  (e.g. fzf-tab must load after `compinit` in 20 and before the widgets in 25/26).
- **`10-homebrew.zsh` is the only module that calls `brew`.** It runs
  `brew shellenv` once; later modules read `$HOMEBREW_PREFIX` /
  `$HOMEBREW_REPOSITORY`. Each `brew` call costs ~30ms of startup.
- **Guard every optional tool**: `command -v <tool>` before init or aliasing,
  `[[ -r <file> ]]` before sourcing. A missing tool must leave the standard
  command working and print nothing.
- **Nested shells skip `~/.zshenv`.** They inherit `ZDOTDIR`, so non-exported
  state set there (e.g. `typeset -U PATH path`) is absent; `10-homebrew.zsh`
  re-applies it. Test with `env -u ZDOTDIR zsh -l -i -c exit` to get a
  fresh-terminal shell; stderr should be empty (`can't change option: zle` is
  harmless no-TTY noise).

## Scripts

- Scripts resolve the repo root from their own path and run from any directory.
- `scripts/stow.sh` honours `STOW_TARGET`; rehearse stow changes against a
  `mktemp -d` home before touching the real one.

## Docs

When adding, removing, or changing a tool or script, update `README.md`,
`config/README.md` (packages, shell modules) or `scripts/README.md` (setup
flow, scripts, macOS defaults) to match. `docs/plans/` holds dated design
records; leave them as written.
