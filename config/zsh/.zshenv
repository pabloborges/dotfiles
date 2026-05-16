# ########################
# Environment variables  #
# ########################

# Default editor for the terminal (git commits, crontab, etc.)
# --wait blocks until the file/window is closed, required for $EDITOR usage
export EDITOR="zed --wait"
export VISUAL="$EDITOR"

# Set the default pager to less (instead of more) for better navigation
export PAGER=less

# Set ~/.config as the default location for user-specific configuration files
export XDG_CONFIG_HOME=$HOME/.config

# Set the zsh configuration directory within XDG_CONFIG_HOME
export ZDOTDIR=$XDG_CONFIG_HOME/zsh

# Ensure that the GPG agent can prompt for passphrases in the terminal
export GPG_TTY=$(tty)

# remove repeated entries from $PATH
# zsh uses $path array along with $PATH
typeset -U PATH path
