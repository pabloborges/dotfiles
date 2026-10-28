# Homebrew environment: the only module that asks brew where it lives.
# Exports HOMEBREW_PREFIX / HOMEBREW_REPOSITORY for later modules, prepends
# bin/sbin to PATH, and adds site-functions to fpath. Prepending after macOS's
# path_helper (/etc/zprofile) keeps Homebrew ahead of /usr/bin. PATH is made
# unique here too: nested shells inherit ZDOTDIR and skip ~/.zshenv, so its
# `typeset -U` never runs and shellenv would add duplicates.
typeset -U PATH path
_brew="$(command -v brew)"
if [[ -z "$_brew" ]]; then
	for loc in "/opt/homebrew/bin/brew" "$HOME/homebrew/bin/brew" "/usr/local/bin/brew"; do
		if [[ -x "$loc" ]]; then
			_brew="$loc"
			break
		fi
	done
fi

if [[ -n "$_brew" ]]; then
	eval "$("$_brew" shellenv zsh)"
else
	echo "Warning: Homebrew not found (searched PATH, /opt/homebrew, ~/homebrew, /usr/local)" >&2
fi
unset _brew loc
