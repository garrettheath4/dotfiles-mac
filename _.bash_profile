# ~/.bash_profile: executed by bash(1) for login shells and Terminal.app sessions on macOS
# (e.g. login via ssh or direct console login without GUI)

# .bashrc sourcing order of operations:
# 1) Set PS1 bash prompt --------------------- .bash_profile (from dotfiles)
# 2) Source system-level script (if any) ----- /etc/bashrc
# 3) Set bash user aliases ------------------- .bashrc       (this script; from dotfiles)
# 4) Source OS-specific script (if any) ------ .bashrc.os.*  (from dotfiles)
# 5) Source machine-specific script (if any) - .bashrc.local

# If not running interactively (e.g. scp), don't do anything
# Source; https://stackoverflow.com/a/40956958/1360295
case $- in
	*i*) ;;
	*) return;;
esac

ENABLE_DEBUG=1

emojify () {
	echo "$1" | sed -e 's/^Yes /✅ /' -e 's/^No /❌ /'
}

debug () {
	if [ "$ENABLE_DEBUG" != 1 ]; then
		return
	fi
	if [ "$1" = -T ]; then
		shift
		echo "       $(emojify "$1")"
	else
		emojify "$1"
	fi
}

tick () {
	if [ "$ENABLE_DEBUG" != 1 ]; then
		return
	fi
	tick_micro=$(echo "$(gdate +%s.%N) * 1000000 / 1" | bc)
}

tock () {
	if [ "$ENABLE_DEBUG" != 1 ]; then
		return
	fi
	tock_micro=$(echo "$(gdate +%s.%N) * 1000000 / 1" | bc)
	delta=$((tock_micro - tick_micro))
	LC_NUMERIC=C LC_COLLATE=C
	printf '%g\n' "$(echo "scale=3; ${delta}/1000" | bc)"
}

tockDebug () {
	if [ "$ENABLE_DEBUG" != 1 ]; then
		return
	fi
	printf '%4.0fms %s\n' "$(tock)" "$(emojify "$1")"
}

debug -T 'Yes interactive'

if ! command -v gdate >/dev/null 2>&1; then
	# shellcheck disable=SC2016
	debug -T 'No gdate installed (for showing load times; install with `brew install coreutils`)'
	ENABLE_DEBUG=0
fi

# Source system's global definitions
tick
if [ -f /etc/bashrc ]; then
	# shellcheck disable=SC1091 disable=SC2039
	source /etc/bashrc
	tockDebug "Yes /etc/bashrc"
else
	tockDebug 'No /etc/bashrc'
fi

# Add user bin and sbin folders to PATH
tick
# [[ is not POSIX compatible so using alternative from https://stackoverflow.com/a/20460402/1360295
if [ -d "$HOME/bin" ] && [ -n "${PATH##*$HOME/bin*}" ]; then
	export PATH="$PATH:$HOME/bin"
	tockDebug "Yes ~/bin"
else
	tockDebug 'No ~/bin'
fi

tick
if [ -d "$HOME/sbin" ] && [ -n "${PATH##*$HOME/sbin*}" ]; then
	export PATH="$PATH:$HOME/sbin"
	tockDebug "Yes ~/bin"
else
	tockDebug 'No ~/sbin'
fi

export VISUAL=vim

# Tmux-specific commands (only run if Tmux is installed)
# This should go at the top of .bash_profile since we don't need to worry about
# setting up THIS shell if we're just going to launch Tmux with its own shell so
# setting up THIS shell doesn't matter if Tmux is installed (until Tmux exits)
tick
if command -v tmux >/dev/null 2>&1; then
	# Tmux is installed
	if [ -z "${TMUX+defined}" ]; then
		# This is NOT a Tmux session
		if [ "$ITERM_PROFILE" = "Hotkey" ] || [ "$ITERM_PROFILE" = "Hotkey Window" ]; then
			# This is an iTerm2 window with the Hotkey profile
			tockDebug "Yes Launching tmux-name..."
			tmux-name
		else
			tockDebug 'Not hotkey'
		fi
	fi
fi

# Source user's local definitions
# I recommend putting a custom command prompt in .bash_profile.local
# like: export PS1="\u@\h:\W$(tput sgr0) \$ "
# shellcheck source=../.bash_profile.local disable=SC1091
tick
if [ -f ~/.bash_profile.local ]; then
	# shellcheck disable=SC1090 disable=SC2039
	source ~/.bash_profile.local
	tockDebug "Yes ~/.bash_profile.local"
else
	tockDebug 'No ~/.bash_profile.local'
fi

# Add background color to command prompt
# (the \[ and \] in BlueBgPS and ResetColorsPS indicate that those characters are
# unprintable and to not include them in the string width counting)
# Bash Prompt Customization: https://wiki.archlinux.org/index.php/Bash/Prompt_customization
# Terminal Codes intro: http://wiki.bash-hackers.org/scripting/terminalcodes
tick
BlueBgPS="\\[$(tput setab 4)\\]"
ResetColorsPS="\\[$(tput sgr0)\\]"
export PS1="${BlueBgPS}${PS1}${ResetColorsPS}"
export PS2="${BlueBgPS}${PS2}${ResetColorsPS}"
tockDebug "Yes PS1"

tick
# shellcheck source=../.git-completion.bash disable=SC1091
if [ -x ~/.git-completion.bash ]; then
	# shellcheck disable=SC2039
	source ~/.git-completion.bash
	tockDebug "Yes ~/.git-completion.bash"
else
	tockDebug 'No ~/.git-completion.bash'
fi

# Enable Bash completion scripts from Homebrew installs if Homebrew and Homebrew:bash-completion are installed
# bash-completion can be installed with: brew install bash-completion
tick
# shellcheck source=/usr/local/etc/bash_completion disable=SC1091
if (command -v brew >/dev/null 2>&1) && test -f "$(brew --prefix)/etc/bash_completion"; then
	# shellcheck disable=SC2039
	source "$_"
	tockDebug "Yes Homebrew bash_completion"
else
	tockDebug 'No Homebrew bash_completion'
fi

# Enable color support of ls and also add handy aliases
tick
if [ -x /usr/bin/dircolors ]; then
	if [ -r ~/.dircolors ]; then
		eval "$(dircolors -b ~/.dircolors)"
	else
		eval "$(dircolors -b)"
	fi

	alias ls='ls --color=auto'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
	tockDebug 'Yes dircolors'
else
	tockDebug 'No dircolors'
fi

# Set the editor to Vim if it is installed
tick
if command -v vim >/dev/null 2>&1; then
	EDITOR=$(command -v vim)
	export EDITOR
	alias vimro="vim -RMn"
	tockDebug "Yes EDITOR=vim"
else
	tockDebug 'No EDITOR=vim'
fi

# User aliases
tick
which_alias="alias | command which --tty-only --read-alias --show-dot --show-tilde"
if $which_alias which 2>/dev/null ; then
	# shellcheck disable=SC2139
	alias which="$which_alias"
	tockDebug "Yes read-alias"
else
	tockDebug 'No read-alias'
fi

tick
alias ls='ls -G'
alias lss='ls -haGl'
alias lsr='ls -haGlt'
alias lsrr='ls -haGlt | head'
alias rm='~/bin/trash'
alias rmm='command rm'
alias pss='ps aux | head -n1; ps aux | fgrep -v grep | fgrep'
alias top='top -u -R -s 2 -stats user,pid,command,cpu,time,state,th,csw,ports,vsize'
alias woman='man'
alias reverse='tail -r'
alias reload='source ~/.bash_profile'
alias incognito='unset HISTFILE'
# If youtube-dl is installed be sure to also install ffmpeg with 'brew install ffmpeg'
# Alias source: https://github.com/rg3/youtube-dl/issues/8017#issuecomment-167382308
alias youtube-dl='echo "youtube-dl -f bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best"; youtube-dl -f bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best'
alias docker-clean='docker rm $(docker ps -a -q); docker rmi $(docker images -q)'

## Git shortcuts
alias ggp='git-pull-push'
alias ggu='git-branches-status'
alias ggb='git branch'
alias ggs='git status'
alias ggd="git diff -- . ':!package-lock.json' ':!Pipfile.lock'"
alias ggdi='git diff --word-diff'
alias gga='git add'
alias ggc='git commit -m'
alias ggl='git log --pretty=oneline --abbrev-commit'

## Other terminal shortcuts
alias mvnt='mvn dependency:tree -Dverbose | vim "+set bt=nofile" -'
alias mvnv='mvn versions:display-dependency-updates | less'

tockDebug "Yes aliases"

ifDistIsThenSource () {
	tick
	if [ "$#" -ne 2 ] || [ -z "$1" ] || [ -z "$2" ]; then
		echo "ERROR: ifDistIsThenSource needs two non-empty args" 1>&2
		echo "Usage: ifDistIsThenSource: Ubuntu ~/.bashrc.os.ubuntu" 1>&2
		return 1
	fi
	if ( command -v lsb_release 1>/dev/null 2>&1 && lsb_release -i | grep -F "$1" 1>/dev/null 2>&1 ); then
		if [ -r "$2" ]; then
			# shellcheck disable=SC1090 disable=SC2039
			source "$2"
			tockDebug "Yes $2."
		else
			tockDebug "No exec $2."
		fi
	fi
}

# Bootstrap based on OS/Disto
ifDistIsThenSource "Raspbian" ~/.bashrc.os.raspbian

# Decorate terminal prompt using oh-my-git
tick
# shellcheck disable=SC1090 disable=SC2039
if test -f ~/dotfiles/oh-my-git/prompt.sh ; then
	source "$_"
	tockDebug "Yes oh-my-git"
else
	tockDebug "Yes oh-my-git"
fi

if command -v tmux >/dev/null 2>&1 && test -n "${TMUX+defined}"; then
	# This IS a Tmux session
	if command -v ssh-name >/dev/null 2>&1; then
		alias ssh='ssh-name'
		if [ -f ~/bin/cd-wrapper-tmux ]; then
			# shellcheck disable=SC1090 disable=SC2039
			source ~/bin/cd-wrapper-tmux
			tockDebug "Yes ssh-name & cd-wrapper-tmux"
		else
			tockDebug "No cd-wrapper-tmux"
		fi
	else
		tockDebug "No ssh-name"
	fi
fi


# vim: set ft=sh:
