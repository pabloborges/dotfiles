# Load fzf shell integration (Ctrl-R, Ctrl-T, Alt-C)
if command -v fzf &>/dev/null; then
	source <(fzf --zsh)
fi

# UP/DOWN: cycle history filtered by what's already typed (prefix match).
# Empty line cycles full history. fuzzy search remains on Ctrl-R.
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Bind both normal (^[[A) and application-mode (^[OA) arrow sequences
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[OA' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
bindkey '^[OB' down-line-or-beginning-search
