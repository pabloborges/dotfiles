# Fix "Under a 'dumb' terminal" error for Starship and other tools
# This happens in non-interactive sessions (pipes, some IDE terminals, etc.)
if [ "$TERM" = "dumb" ]; then
	export TERM="xterm-256color"
fi
