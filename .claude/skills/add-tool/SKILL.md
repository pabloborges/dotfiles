---
name: add-tool
description: Guide for adding a new tool to the dotfiles
disable-model-invocation: true
argument-hint: "[tool-name]"
---

Add a new dotfiles package for: $ARGUMENTS

Steps:
1. Add the tool to `Brewfile`
2. Run `make install` to install the new dependency
3. Create `config/$0/` with config files mirroring `$HOME`
4. Run `make stow` to create symlinks
5. Update CLAUDE.md if the tool has notable configuration
