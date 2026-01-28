# Add Homebrew to PATH
if [ -d "/opt/homebrew/bin" ]; then
	export PATH="/opt/homebrew/bin:$PATH"
fi
if [ -d "/usr/local/bin" ]; then
	export PATH="/usr/local/bin:$PATH"
fi

# Load Homebrew bash completions
if [ -n "$BASH_VERSION" ]; then
	if [ -f "/opt/homebrew/etc/profile.d/bash_completion.sh" ]; then
		. "/opt/homebrew/etc/profile.d/bash_completion.sh"
	elif [ -f "/usr/local/etc/profile.d/bash_completion.sh" ]; then
		. "/usr/local/etc/profile.d/bash_completion.sh"
	fi
fi
