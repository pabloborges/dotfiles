# Load fzf shell integration (Ctrl-R, Ctrl-T, Alt-C)
source <(fzf --zsh)

# Bind UP arrow to fzf history search instead of default Ctrl-R
bindkey '^[[A' fzf-history-widget
