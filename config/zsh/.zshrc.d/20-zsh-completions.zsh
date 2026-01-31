# Load zsh completions
# Homebrew site-functions (contains brew, asdf, etc.)
fpath=("$(brew --prefix)/share/zsh/site-functions" $fpath)
 
# Additional zsh-completions package
fpath=("$(brew --prefix)/share/zsh-completions" $fpath)

# Initialize completion system
autoload -Uz compinit && compinit
