########
# Alias
########
alias ys="yarn start"

# macOS has no `md5sum`, so use `md5` as a fallback
command -v md5sum > /dev/null || alias md5sum="md5"
# macOS has no `sha1sum`, so use `shasum` as a fallback
command -v sha1sum > /dev/null || alias sha1sum="shasum"
# Reload the shell (i.e. invoke as a login shell)
alias reload="exec ${SHELL} -l"

########
# Functions
########
command -v gdate > /dev/null && when() { gdate -I -d "$*" }

########
# Globalias filter (don't expand)
########
GLOBALIAS_FILTER_VALUES=(grep l rspec z)
