##########
# Aliases
##########

# common
alias l="eza --icons --git -lah"
alias reload="exec ${SHELL} -l" # Reload the shell
alias tree="eza --tree --level=2"
alias ys="yarn start"

# docker
alias compose="docker compose"

# dotfiles
alias aliases="nvim $0"
alias zshrc="nvim ~/.zshrc"

# git
alias gap="git add --patch"
alias gc="git commit -v"
alias gcl="git clone --recurse-submodules"
alias gco="git checkout"
alias gl="git pull"
alias glol="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'"
alias gp="git push -u"
alias gst="git status"

# sourcetree
alias stree="open -a SourceTree ."

# projects
alias notes="nvim ~/Documents/notes/iCloud"

# ruby
alias be="bundle exec"
alias rgrb="rg --type ruby --type erb --files-with-matches"
# e.g. with-spec touch app/models/user.rb
with-spec() { ruby -e "puts '$2', '$2'.sub(/^app\/(.*)\.rb/, 'spec/\1_spec.rb')" | xargs $1 }

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
