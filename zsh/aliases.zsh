##########
# Aliases
##########

# common
alias l="exa -lah --git --icons"
alias reload="exec ${SHELL} -l" # Reload the shell
alias tree="exa --tree --level=2"
alias ys="yarn start"

# dotfiles
alias aliases="nvim $0"

# git
alias gap="git add --patch"
alias gc="git commit -v"
alias gcl="git clone --recurse-submodules"
alias gco="git checkout"
alias gl="git pull"
alias glol="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'"
alias gp="git push -u"
alias gst="git status"

# projects
alias notes="nvim ~/Documents/notes/iCloud"

# macOS has no `md5sum`, so use `md5` as a fallback
command -v md5sum > /dev/null || alias md5sum="md5"
# macOS has no `sha1sum`, so use `shasum` as a fallback
command -v sha1sum > /dev/null || alias sha1sum="shasum"

########
# Functions
########
command -v gdate > /dev/null && when() { gdate -I -d "$*" }
notify() { osascript -e "display notification \"$*\"" }

########
# Globalias filter (don't expand)
########
GLOBALIAS_FILTER_VALUES=(grep l rspec z)
