# Fink Environment
test -r /sw/bin/init.sh && . /sw/bin/init.sh

# Subversion Environment Variables
export SVN_EDITOR=vim
export SVN_REPOS="file:///Users/Garrett/svn/"

# User aliases
alias gcc='gcc -Wall --pedantic'

alias rm="~/bin/rmm"
alias rmm="/bin/rm"
alias ls="ls -G"
alias lss="ls -haGl"
alias top="top -u -R -s 2 -stats user,pid,command,cpu,time,state,th,csw,ports,vsize"

alias preview="/Applications/Preview.app/Contents/MacOS/Preview"

alias sshcondor='ssh koller@condor.cs.wlu.edu'
alias sshstu='ssh kollerg@condor.cs.wlu.edu'
alias hbar='ssh kollerg@hbar.wlu.edu'
alias ousc='ssh sc11222@sooner.oscer.ou.edu'
alias ouossm='ssh ossm1@sooner.oscer.ou.edu'
alias sshvceg='~/aws/VCEG-Wiki_SSH.sh'
