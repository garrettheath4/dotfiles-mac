# ~/.bash_profile: executed by bash(1) for login shells and Terminal.app sessions on macOS
# (e.g. login via ssh or direct console login without GUI)

# Source local definitions
# I recommend putting a custom command prompt in .bash_profile.local
# like: export PS1="\u@\h:\W$(tput sgr0) \$ "
# shellcheck disable=SC1091
# shellcheck source=../.bash_profile.local
test -f ~/.bash_profile.local -a -x ~/.bash_profile.local && . "$_"

# Add background color to command prompt
# (the \[ and \] in BlueBgPS and ResetColorsPS indicate that those characters are
# unprintable and to not include them in the string width counting)
# Bash Prompt Customization: https://wiki.archlinux.org/index.php/Bash/Prompt_customization
# Terminal Codes intro: http://wiki.bash-hackers.org/scripting/terminalcodes
BlueBgPS="\[$(tput setab 4)\]"
ResetColorsPS="\[$(tput sgr0)\]"
export PS1="${BlueBgPS}${PS1}${ResetColorsPS}"
export PS2="${BlueBgPS}${PS2}${ResetColorsPS}"

# shellcheck disable=SC1091
# shellcheck source=../.git-completion.bash
test -f ~/.git-completion.bash -a -x ~/.git-completion.bash && . "$_"

# Enable Bash completion scripts from Homebrew installs if Homebrew and Homebrew:bash-completion are installed
# bash-completion can be installed with: brew install bash-completion
(which brew >/dev/null 2>&1) && test -f "$(brew --prefix)/etc/bash_completion" && . "$_"

# User aliases
alias ls="ls -G"
alias lss="ls -haGl"
alias lsr="ls -haGlt"
alias lsrr="ls -haGlt | head"
alias rm="~/bin/trash"
alias rmm="command rm"
alias woman="man"
alias top="top -u -R -s 2 -stats user,pid,command,cpu,time,state,th,csw,ports,vsize"
alias reverse="tail -r"
alias incognito="unset HISTFILE"
alias reload="source ~/.bash_profile"

## Git shortcuts
alias ggp='git pull && test "$(git for-each-ref --format="%(push:track)" refs/heads)" != "" && git push || echo "Nothing to push."'
alias ggb='git branch'
alias ggs='git status'
alias ggd='git diff'
alias gga='git add'
alias ggc='git commit -m'
alias ggl='git log --pretty=oneline --abbrev-commit'

#  GUI app shortcuts
alias preview="open -a Preview"

vim_exec=/Applications/MacVim.app/Contents/MacOS/Vim
if [ -x "$vim_exec" ]; then
	# shellcheck disable=SC2139
	alias vim="$vim_exec"
	# shellcheck disable=SC2139
	alias gvim="$vim_exec -g"
	# shellcheck disable=SC2139
	alias vimro="$vim_exec -RMn"
else
	alias vimro="vim -RMn"
fi

# Add user bin and sbin folders to PATH
if [ -d "$HOME/bin" ] && [[ $PATH != *$HOME/bin* ]]; then
	export PATH="$PATH:$HOME/bin"
fi

if [ -d "$HOME/sbin" ] && [[ $PATH != *$HOME/sbin* ]]; then
	export PATH="$PATH:$HOME/sbin"
fi

# Setting PATH for Python 3.5
# The orginal version is saved in .bash_profile.pysave
if [ -d "/Library/Frameworks/Python.framework/Versions/3.5/bin" ]; then
	PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"
	export PATH
fi

# Tmux-specific commands (only run if Tmux is installed)
if which tmux >/dev/null 2>&1; then
	# Automatically start Tmux session if this is an iTerm2 window with the Hotkey profile
	if [ "$ITERM_PROFILE" = "Hotkey" ] || [ "$ITERM_PROFILE" = "Hotkey Window" ] && [ -z "${TMUX+defined}" ]; then
		if (tmux has-session 2>/dev/null); then
			tmux attach
		else
			tmux
		fi
	fi

	# If this is a TMUX session, automatically run some commands
	if [ -n "${TMUX}" ]; then
		# TMUX_PANE=%0
		if [ "$TMUX_PANE" = '%0' ]; then
			tmux rename-window 'Local'
		fi

		# From article: https://blog.no-panic.at/2015/04/21/set-tmux-pane-title-on-ssh-connections/
		# Source Gist:  https://gist.github.com/florianbeer/ee02c149a7e25f643491
		ssh() {
			if [ "$(ps -p "$(ps -p $$ -o ppid=)" -o comm=)" = "tmux" ]; then
				if [ "$(tmux display-message -p '#W')" = "bash" ]; then
					# Tmux window doesn't have a custom name already, so proceed with auto-rename
					GrayTxt="$(tput setaf 0)"
					ResetColors="$(tput sgr0)"
					echo "${GrayTxt}Renaming Tmux window to match SSH session${ResetColors}" 1>&2
					windowName=$(echo "$1" | cut -d '.' -f 1)
					#TODO: Extract this known-server substitution into an optional .ssh_server_names.local definition file
					case "$windowName" in
						drlvapiapp01) windowName='Test_API'; ;;
						prlvapiapp01) windowName='PROD_API'; ;;
						drlvmtlapp01) windowName='MTool-Web'; ;;
					esac
					tmux rename-window "$windowName"
					#tmux set-window-option automatic-rename "on" 1>/dev/null
				else
					: # Tmux window has a custom name already, so don't rename it
				fi
			else
				echo "WARNING: Cannot rename the Tmux session because this is not a Tmux session.  This ssh() funcion shouldn't be defined.  Check your .bash_profile" 1>&2
			fi
			command ssh "$@"
		}
	fi
fi

cd_tmux() {
	# Usage: cd_tmux <DirToChangeTo> <NewTmuxWindowName>
	if [ "$#" -lt 2 ]; then
		echo 'Usage: cd_tmux <DirToChangeTo> <NewTmuxWindowName>'
		exit 1
	fi
	NewDir="$1"
	shift
	# Remaining arg(s) is new window name
	WindowName="$*"
	if which tmux >/dev/null 2>&1 && [ "$(ps -p "$(ps -p $$ -o ppid=)" -o comm=)" = "tmux" ] && [ "$(tmux display-message -p '#W')" = "bash" ]; then
		# Tmux is installed && this is a running Tmux session && the Tmux window has the default (non-custom) name
		GrayTxt="$(tput setaf 0)"
		ResetColors="$(tput sgr0)"
		echo "${GrayTxt}Renaming Tmux window to match current directory${ResetColors}" 1>&2
		tmux rename-window "$WindowName"
	fi
	# shellcheck disable=SC2164
	cd "$NewDir"
	pwd
}

