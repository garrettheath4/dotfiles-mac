# Source local definitions
# I recommend putting a custom command prompt in .bash_profile.local
# like: export PS1="\u@\h:\W$(tput sgr0) \$ "
test -f ~/.bash_profile.local -a -x ~/.bash_profile.local && source $_

# Add background color to command prompt
# (the \[ and \] in BLUE and RESET indicate that those characters are
# unprintable and to not include them in the string width counting)
# Bash Prompt Customization: https://wiki.archlinux.org/index.php/Bash/Prompt_customization
# Terminal Codes intro: http://wiki.bash-hackers.org/scripting/terminalcodes
BLUE="\[$(tput setab 4)\]"
RESET="\[$(tput sgr0)\]"
export PS1="${BLUE}${PS1}${RESET}"
export PS2="${BLUE}${PS2}${RESET}"

# User aliases
alias gcc='gcc -Wall --pedantic'

alias rm="~/bin/rmm"
alias rmm="/bin/rm"
alias ls="ls -G"
alias lss="ls -haGl"
alias lsr="ls -haGlt"
alias lsrr="ls -haGlt | head"
alias woman="man"
alias top="top -u -R -s 2 -stats user,pid,command,cpu,time,state,th,csw,ports,vsize"
alias reverse="tail -r"
alias incognito="unset HISTFILE"
alias reload="source ~/.bash_profile"

#  Git shortcuts
alias ggp='git pull && git push'
alias ggb='git branch'
alias ggs='git status'
alias ggd='git diff'
alias gga='git add'
alias ggc='git commit -m'
alias ggl='git log --pretty=oneline --abbrev-commit'

test -f ~/.git-completion.bash -a -x ~/.git-completion.bash && source $_

#  GUI app shortcuts
alias preview="open -a Preview"

vim_exec=/Applications/MacVim.app/Contents/MacOS/Vim
if [ -x "$vim_exec" ]; then
	alias vim="$vim_exec"
	alias gvim="$vim_exec -g"
	alias vimro="$vim_exec -M"
else
	alias vimro="vim -M"
fi

# Add user bin and sbin folders to PATH
if [ -d "~/bin" ]; then
	export PATH="$PATH":"~/bin"
fi

if [ -d "~/sbin" ]; then
	export PATH="$PATH":"~/sbin"
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
	if [ "$ITERM_PROFILE" = "Hotkey" -a -z "${TMUX+defined}" ]; then
		tmux has-session 2>/dev/null && tmux attach || tmux
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
			if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm=)" = "tmux" ]; then
				echo 'This is a Tmux session, so renaming window to match SSH session'
				windowName="$(echo $* | cut -d . -f 1)"
				#TODO: Break this known-server substitution into an optional .server_list.local definition file
				case "$windowName" in
					drlvapiapp01) windowName='Test_API'; ;;
					prlvapiapp01) windowName='PROD_API'; ;;
				esac
				tmux rename-window "$windowName"
				command ssh "$@"
				#tmux set-window-option automatic-rename "on" 1>/dev/null
			else
				echo "WARNING: Cannot rename the Tmux session because this is not a Tmux session.  This ssh() funcion shouldn't be defined.  Check your .bash_profile" 1>&2
				command ssh "$@"
			fi
		}
	fi
fi

