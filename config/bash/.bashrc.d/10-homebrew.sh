# Add Homebrew to PATH
if [ -d "/opt/homebrew/bin" ]; then
  export PATH="/opt/homebrew/bin:$PATH"
fi
if [ -d "/usr/local/bin" ]; then
  export PATH="/usr/local/bin:$PATH"
fi
