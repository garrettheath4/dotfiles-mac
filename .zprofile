echo "Running ~/.zprofile" 1>&2

source ~/.ghk_profile

# Source user's local-only initialization script
# I recommend putting a custom command prompt in .zprofile.local
# like: export PS1='%n@%m %/ $ '
# shellcheck source=../.zprofile.local disable=SC1091 disable=SC2088
tickDebug '~/.zprofile.local'
if [ -f ~/.zprofile.local ]; then
	# shellcheck disable=SC1090 disable=SC2039
	source ~/.zprofile.local
	tockDebug "Yes ~/.zprofile.local"
else
	tockDebug 'No ~/.zprofile.local'
fi

# TODO: Colorize Z Shell prompt (`PS1` environment variable)

# TODO: Setup oh-my-zsh
