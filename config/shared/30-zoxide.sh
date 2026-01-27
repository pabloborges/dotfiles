# Load zoxide - smart directory jumper
if command -v zoxide &>/dev/null; then
	# Detect shell and use appropriate init
	if [ -n "${BASH_VERSION:-}" ]; then
		eval "$(zoxide init bash)"
	elif [ -n "${ZSH_VERSION:-}" ]; then
		eval "$(zoxide init zsh)"
	else
		# Fallback to POSIX
		eval "$(zoxide init posix)"
	fi
fi
