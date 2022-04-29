# ~/.zshrc

# Z Shell startup order of operations:
# 1. /etc/zshenv
# 2.   ~/.zshenv
# 3. /etc/zprofile (IF login shell)
# 4.   ~/.zprofile (IF login shell)
# 5. /etc/zshrc    (IF interactive)
# 6.   ~/.zshrc    (IF interactive)
# 7. /etc/zlogin   (IF login shell)
# 8.   ~/.zlogin   (IF login shell)

echo "Running ~/.zshrc" 1>&2

source ~/.ghkrc

# Source user's local-only initialization script
# I recommend putting a custom command prompt in .zshrc.local
# like: export PS1='%n@%m %/ $ '
# shellcheck source=../.zshrc.local disable=SC1091 disable=SC2088
tickDebug '~/.zshrc.local'
if [ -f ~/.zshrc.local ]; then
	# shellcheck disable=SC1090 disable=SC2039
	source ~/.zshrc.local
	tockDebug "Yes ~/.zshrc.local"
else
	tockDebug 'No ~/.zshrc.local'
fi

# TODO: Colorize Z Shell prompt (`PS1` environment variable)

# TODO: Setup oh-my-zsh
