# Source local definitions
if [ -f ~/.bash_profile.local -a -x ~/.bash_profile.local ]; then
	. ~/.bash_profile.local
fi

# User aliases
alias gcc='gcc -Wall --pedantic'

alias rm="~/bin/rmm"
alias rmm="/bin/rm"
alias ls="ls -G"
alias lss="ls -haGl"
alias top="top -u -R -s 2 -stats user,pid,command,cpu,time,state,th,csw,ports,vsize"
alias reverse="tail -r"
alias incognito="unset HISTFILE"

#  cd shortcuts
alias cds='cd /Users/Garrett/Google\ Drive/School/'

#  SSH shortcuts
alias sshcondor='ssh kollerg@condor.cs.wlu.edu'
alias sshstujohn='ssh kollerg@john.cs.wlu.edu'
alias sshstu='ssh kollerg@perl.cs.wlu.edu'
alias hbar='ssh kollerg@hbar.wlu.edu'
alias ousc='ssh sc11222@sooner.oscer.ou.edu'
alias ouossm='ssh ossm1@sooner.oscer.ou.edu'
alias sshvceg='~/aws/VCEG-Wiki_SSH.sh'

#  Git shortcuts
alias gp='git pull; git push'
alias ggp='git pull; git push'
alias ggs='git status'
alias gga='git add'
alias ggc='git commit -m'

#  GUI app shortcuts
alias preview="open -a Preview"

# Add user bin and sbin folders to PATH
if [ -d ~/bin ]; then
	export PATH="$PATH":~/bin
fi

if [ -d ~/sbin ]; then
	export PATH="$PATH":~/sbin
fi

# Setting PATH for Python 3.5
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"
export PATH
