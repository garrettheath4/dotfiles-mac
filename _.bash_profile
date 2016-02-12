# Source local definitions
# I recommend putting a custom command prompt in .bash_profile.local
# like: export PS1="\u@\h:\W$(tput sgr0) \$ "
test -f ~/.bash_profile.local -a -x ~/.bash_profile.local && . $_

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
alias top="top -u -R -s 2 -stats user,pid,command,cpu,time,state,th,csw,ports,vsize"
alias reverse="tail -r"
alias incognito="unset HISTFILE"

#  SSH shortcuts
alias ousc='ssh sc11222@sooner.oscer.ou.edu'
alias ouossm='ssh ossm1@sooner.oscer.ou.edu'

#  Git shortcuts
alias ggp='git pull; if [[ $? -eq 0 ]]; then git push; fi'
alias ggs='git status'
alias gga='git add'
alias ggc='git commit -m'
alias ggl='git log --pretty=oneline --abbrev-commit'

test -f ~/.git-completion.bash -a -x ~/.git-completion.bash && . $_

#  GUI app shortcuts
alias preview="open -a Preview"
alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
alias gvim='/Applications/MacVim.app/Contents/MacOS/Vim -g'

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
