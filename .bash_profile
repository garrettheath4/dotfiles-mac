# ~/.bash_profile

# bash startup order of operations:
# 1. /etc/profile    (IF login shell)
# 2. /etc/bashrc     (IF login shell; called from /etc/profile)
# 3. ~/.bash_profile (IF login shell)
# 4. ~/.bash_login   (IF login shell)
# 5. ~/.profile      (IF login shell)
# 6. ~/.bashrc       (IF interactive non-login shell OR remote shell)
# 7. BASH_ENV        (IF non-interactive)

# If not running interactively (e.g. scp), don't do anything
# Source; https://stackoverflow.com/a/40956958/1360295
case $- in
	*i*) ;;
	*) return;;
esac

if [ "$ENABLE_DEBUG" = 1 ]; then
	echo "Running ~/.bash_profile" 1>&2
fi

if [ -r ~/.ghkrc ]; then
	# shellcheck source=.ghkrc
	source ~/.ghkrc

	# Source user's local-only initialization script
	# I recommend putting a custom command prompt in .bash_profile.local
	# like: PS1="\u@\h:\W$(tput sgr0) \$ "
	# shellcheck source=../.bash_profile.local disable=SC1091 disable=SC2088
	tickDebug '~/.bash_profile.local'
	if [ -f ~/.bash_profile.local ]; then
		# shellcheck disable=SC1090 disable=SC2039
		source ~/.bash_profile.local
		tockDebug "Yes ~/.bash_profile.local"
	else
		tockDebug 'No ~/.bash_profile.local'
	fi

	# Decorate terminal prompt using oh-my-git
	tickDebug 'oh-my-git'
	# shellcheck disable=SC1090 disable=SC2039
	if test -f ~/dotfiles/oh-my-git/prompt.sh ; then
		source "$_"
		tockDebug 'Yes oh-my-git'
	else
		tockDebug 'No oh-my-git'
	fi

	# read-alias is only required for Bash since this functionality is built-in
	# to Z Shell
	tickDebug 'read-alias'
	which_alias="alias | command which --tty-only --read-alias --show-dot --show-tilde"
	if $which_alias which 2>/dev/null ; then
		# shellcheck disable=SC2139
		alias which="$which_alias"
		tockDebug "Yes read-alias"
	else
		tockDebug 'No read-alias'
	fi

	# shellcheck disable=SC2088
	tickDebug '~/.git-completion.bash'
	# shellcheck source=../.git-completion.bash disable=SC1091
	if [ -x ~/.git-completion.bash ]; then
		# shellcheck disable=SC2039
		source ~/.git-completion.bash
		tockDebug "Yes ~/.git-completion.bash"
	else
		tockDebug 'No ~/.git-completion.bash'
	fi

	# Enable Bash completion scripts from Homebrew installs if Homebrew and
	# Homebrew:bash-completion are installed.
	# bash-completion can be installed with: `brew install bash-completion`
	tickDebug 'Homebrew bash_completion'
	# shellcheck source=/usr/local/etc/bash_completion disable=SC1091
	if (command -v brew >/dev/null 2>&1) && test -f "$(brew --prefix)/etc/bash_completion"; then
		# shellcheck disable=SC2039
		source "$_"
		tockDebug 'Yes Homebrew bash_completion'
	elif type brew &>/dev/null; then
		HOMEBREW_PREFIX="$(brew --prefix)"
		if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
			source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
		else
			for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
				[[ -r "$COMPLETION" ]] && source "$COMPLETION"
			done
		fi
	else
		tockDebug 'No Homebrew bash_completion'
	fi

	# >>>> Vagrant command completion (start)
	tickDebug 'Vagrant bash_completion'
	vagrantGems=/opt/vagrant/embedded/gems/
	if (command -v vagrant >/dev/null 2>&1) && [ -d $vagrantGems ]; then
		# shellcheck disable=SC2012
		vagrantCompletion="$vagrantGems$(ls $vagrantGems | tail -n1)/gems/vagrant-*/contrib/bash/completion.sh"
		# shellcheck disable=SC2086
		if [ -f $vagrantCompletion ]; then
			# shellcheck disable=SC2086 source=/opt/vagrant/embedded/gems/2.2.18/gems/vagrant-2.2.18/contrib/bash/completion.sh
			source $vagrantCompletion
			tockDebug 'Yes Vagrant bash_completion'
		else
			tockDebug 'No Vagrant bash_completion'
		fi
	else
		tockDebug 'No Vagrant'
	fi
	# <<<<  Vagrant command completion (end)
else
	echo 'ERROR: ~/.ghkrc not found; skipping.' 1>&2
fi

# Add background color to command prompt
# (the \[ and \] in BlueBgPS and ResetColorsPS indicate that those characters are
# unprintable and to not include them in the string width counting)
# Bash Prompt Customization: https://wiki.archlinux.org/index.php/Bash/Prompt_customization
# Terminal Codes intro: http://wiki.bash-hackers.org/scripting/terminalcodes
BlueBgPS="\\[$(tput setab 4)\\]"
ResetColorsPS="\\[$(tput sgr0)\\]"
PS1="${BlueBgPS}\\h:\\W \\u${ResetColorsPS}\\$ "

