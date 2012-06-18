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

##
# Your previous /Users/Garrett/.bash_profile file was backed up as /Users/Garrett/.bash_profile.macports-saved_2012-06-18_at_08:57:16
##

# MacPorts Installer addition on 2012-06-18_at_08:57:16: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

# Add user bin and sbin folders to PATH
export PATH="$PATH":~/bin:~/sbin

# Roku SDK (add 'biftool' to PATH)
export PATH="$PATH":/Users/Garrett/src/RokuSDK_v41/utilities/mac/bin
