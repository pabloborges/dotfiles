# General shell aliases (git and other shortcuts)

# Git
alias gst='git status'
alias gco='git checkout'
alias gc='git commit'
alias ga='git add'
alias gb='git branch'
alias gl='git pull'
alias glog='git log --oneline --graph --decorate'

# Docker
alias compose="docker compose"

# Claude
alias claude-serena='claude --system-prompt="$(serena prompts print-cc-system-prompt-override)"'
