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
BlueBgPS="\\[$(tput setab 4)\\]"
ResetColorsPS="\\[$(tput sgr0)\\]"
export PS1="${BlueBgPS}${PS1}${ResetColorsPS}"
export PS2="${BlueBgPS}${PS2}${ResetColorsPS}"

# shellcheck disable=SC1091
# shellcheck source=../.git-completion.bash
test -f ~/.git-completion.bash -a -x ~/.git-completion.bash && . "$_"

# Enable Bash completion scripts from Homebrew installs if Homebrew and Homebrew:bash-completion are installed
# bash-completion can be installed with: brew install bash-completion
(command -v brew >/dev/null 2>&1) && test -f "$(brew --prefix)/etc/bash_completion" && . "$_"

# User aliases
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
alias incognito='unset HISTFILE'
alias reload='source ~/.bash_profile'
# If youtube-dl is installed be sure to also install ffmpeg with 'brew install ffmpeg'
# Alias source: https://github.com/rg3/youtube-dl/issues/8017#issuecomment-167382308
alias youtube-dl='echo "youtube-dl -f bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best"; youtube-dl -f bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best'

## Git shortcuts
alias ggp='(git pull && test "$(git for-each-ref --format="%(if)%(HEAD)%(then)%(push:track)%(end)" refs/heads)" != "" && git push || echo "Nothing to push on this branch.") && test "$(git for-each-ref --format="%(push:track)" refs/heads)" != "" && (echo "Other branches:"; ggu)'
alias ggu='git for-each-ref --format="%(align:15,right)%(push:track)%(end) %(refname:lstrip=2)" refs/heads'
alias ggb='git branch'
alias ggs='git status'
alias ggd='git diff'
alias ggdi='git diff --word-diff'
alias gga='git add'
alias ggc='git commit -m'
alias ggl='git log --pretty=oneline --abbrev-commit'

## GUI app shortcuts
alias preview='open -a Preview'

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
# [[ is not POSIX compatible so using alternative from https://stackoverflow.com/a/20460402/1360295
if [ -d "$HOME/bin" ] && [ -n "${PATH##*$HOME/bin*}" ]; then
	export PATH="$PATH:$HOME/bin"
fi

if [ -d "$HOME/sbin" ] && [ -n "${PATH##*$HOME/sbin*}" ]; then
	export PATH="$PATH:$HOME/sbin"
fi

# Setting PATH for Python 3.5
# The orginal version is saved in .bash_profile.pysave
if [ -d "/Library/Frameworks/Python.framework/Versions/3.5/bin" ]; then
	PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"
	export PATH
fi

# Tmux-specific commands (only run if Tmux is installed)
if command -v tmux >/dev/null 2>&1; then
	# Tmux is installed
	if [ -z "${TMUX+defined}" ]; then
		# This is NOT a Tmux session
		if [ "$ITERM_PROFILE" = "Hotkey" ] || [ "$ITERM_PROFILE" = "Hotkey Window" ]; then
			# This is an iTerm2 window with the Hotkey profile
			tmux-name
		fi
	else
		# This IS a Tmux session
		alias ssh='ssh-name'
	fi
fi


# vim: set ft=sh:
