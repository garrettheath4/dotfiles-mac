# ~/.zshrc
# vim: set foldmethod=marker:

# Z Shell startup order of operations:
# 1. /etc/zshenv
# 2.   ~/.zshenv
# 3. /etc/zprofile (IF login shell)
# 4.   ~/.zprofile (IF login shell)
# 5. /etc/zshrc    (IF interactive)
# 6.   ~/.zshrc    (IF interactive)
# 7. /etc/zlogin   (IF login shell)
# 8.   ~/.zlogin   (IF login shell)

if [ "$ENABLE_DEBUG" = 1 ]; then
	echo "Running ~/.zshrc" 1>&2
fi

# iTerm2 app
if [ -n "$ITERM_PROFILE" ] || [ "$TERM_PROGRAM" = 'iTerm.app' ] || [ "$LC_TERMINAL" = 'iTerm2' ]; then
	# To fix word jumping with Option+Left/Right in iTerm2
	bindkey "\e[1;3D" backward-word     # ⌥←
	bindkey "\e[1;3C" forward-word      # ⌥→
fi

# Run `.ghk_profile` to set environment variables like PATH, EDITOR, VISUAL, BROWSER, and JAVA_HOME
if [ -f ~/.ghk_profile ]; then
	source ~/.ghk_profile
else
	echo 'WARNING: ~/.ghk_profile not found' 2>&1
fi

# Source user's local-only initialization script.
# I recommend putting a custom command prompt in `.zshrc.local`
# like: PS1='%n@%m %F{blue}%1~%f %% '
# shellcheck source=../.zshrc.local disable=SC1091 disable=SC2088
tickDebug '~/.zshrc.local'
if [ -f ~/.zshrc.local ]; then
	# shellcheck disable=SC1090 disable=SC2039
	source ~/.zshrc.local
	tockDebug "Yes ~/.zshrc.local"
else
	tockDebug 'No ~/.zshrc.local'
fi

#       ______                                      ______
# _________  /_    _______ ________  __ _______________  /_
# _  __ \_  __ \   __  __ `__ \_  / / / ___  /_  ___/_  __ \
# / /_/ /  / / /   _  / / / / /  /_/ /  __  /_(__  )_  / / /
# \____//_/ /_/    /_/ /_/ /_/_\__, /   _____/____/ /_/ /_/
#                             /____/
# Homepage: https://ohmyz.sh/
# GitHub:   https://github.com/ohmyzsh/ohmyzsh/

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
if [ ! -r "$ZSH/oh-my-zsh.sh" ] || [ ! -f "$ZSH/oh-my-zsh.sh" ]; then
	echo 'Warning: oh-my-zsh does not appear to be installed.' 1>&2
	echo 'Install it with:  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --keep-zshrc' 1>&2
	unset ZSH
	return
fi

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"
ZSH_THEME="agnoster"

# agnoster theme configuration {{{
# See: https://github.com/agnoster/agnoster-zsh-theme
# Override `DEFAULT_USER` in `.zshrc.local` per computer if necessary.
if [ -z "$DEFAULT_USER" ]; then
	DEFAULT_USER=garrett
fi
# agnoster theme configuration }}}

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(aliases colored-man-pages git gitignore jira tmux zsh-autosuggestions)

# aliases             `als` command
# colored-man-pages   Auto-colorizes `man`. Can also colorize other commands with `colored` prefix command.
# git                 Adds aliases and a few functions. See: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git
# gitignore           `gi <template>` command for querying gitignore.io. List supported templates with `gi list`.
# jira                `jira` command
# zsh-autosuggestions Tab-completion of previously-run commands. Install with: git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# jira plugin configuration {{{
# See: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/jira
JIRA_URL=https://catalist-us.atlassian.net/
JIRA_NAME=gkoller
# jira plugin configuration }}}

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
