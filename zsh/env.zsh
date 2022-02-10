if command -v greadlink &> /dev/null; then
  SCRIPT_DIR=$(dirname $0)
  export DOTFILES=$(greadlink -f $SCRIPT_DIR/..)
else
  echo "coreutils could not be found. Run 'brew install coreutils' and try again"
fi
