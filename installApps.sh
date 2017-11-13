#!/usr/bin/env bash
# Script to install major programs and Applications on a Mac account
# Most things in this script (unless they're very minor) should run with
# a prompted confirmation from the user to install each item

REPO="$(pwd)"

# Variable: Has the spreadsheet with the list of licenses been opened yet?
#   Values: 'YES' or 'NO'
LicensePage='https://docs.google.com/spreadsheets/d/14pl7ljKn8bf8rZZgHrU56zbQFePMpGCLUH0U3UQRTVI/edit#gid=0'
OpenedLicenses='NO'

ShowLicenses () {
	if [ "$OpenedLicenses" == 'NO' ]; then
		open "$LicensePage"
		OpenedLicenses='YES'
	fi
}

ConfirmInstall () {
	# Usage: ConfirmInstall DescriptionString InstalledAppName
	# Returns: 0 for YES
	# (as $?): 1 for NO
	if [[ ! -d "/Applications/$2.app" && ! -d "/Applications/$1.app" && ! -e "$2" ]]; then
		read -r -p "Install $1 now? (y/n) [y]: " confirminstall
		[ "$confirminstall" != 'n' ]
	else
		# Return NO
		return 1
	fi
}

OpenAppLinkAndPrompt () {
	# Usage OpenAppLinkAndPrompt Evernote 'macappstore://itunes.apple.com/us/app/evernote-stay-organized/id406056744?mt=12'
	AppName="$1"
	LinkToOpen="$2"
	if [ -n "$LinkToOpen" ]; then
		open "$LinkToOpen"
	fi
	read -r -p "Press Enter after $AppName is installed to continue..."
}

#
# FILES
#

# Add fractals to Pictures folder
if ConfirmInstall 'fractals to Pictures folder' ~/Pictures/Fractals-2560x1600; then
	ln -is "$REPO/Fractals-2560x1600" ~/Pictures/
fi

# Install special sound effects
if ConfirmInstall "\"Robot Blip\" sound" ~/Library/Sounds/'Robot Blip.aiff'; then
	echo "Adding \"Robot Blip\" to user sounds..."
	if [ -e "$REPO/Sounds/Robot Blip.aiff" ]; then
		if ! ( cp "$REPO/Sounds/Robot Blip.aiff" ~/Library/Sounds/ ); then
			echo 'Warning: Error in installing Robot Blip to user profile.'
		fi
	else
		echo "Warning: Unable to find \"Robot Blip.aiff\" in dotfiles repo."
	fi
fi


#
# Git (needed first to install Homebrew and its apps in this script)
#

if ! which git; then
	git
	# macOS should prompt you to install the Developer Tools which includes Git
	OpenAppLinkAndPrompt 'Git'
fi

if ! git --version; then
	echo 'Warning: It appears that Git was not installed. You may need to install it yourself from Xcode.'
	exit 1
fi


#
# Homebrew (needed to install other tools and apps in this script)
#

if ! brew --version; then
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update

#
# Google Chrome (install before opening web pages in this script)
#

if ConfirmInstall 'Google Chrome'; then
	brew cask install google-chrome
fi


#
# TOOLS
#

# LastPass extensions
LastPassInstallerApp='/usr/local/Caskroom/lastpass/latest/LastPass Installer.app'
if ConfirmInstall 'LastPass Universal Mac Installer' "$LastPassInstallerApp"; then
	brew cask install lastpass
	OpenAppLinkAndPrompt 'LastPass' "$LastPassInstallerApp"
fi

# Tmux
if ! tmux -V; then
	brew install tmux
fi


#
# APPS
#

if ConfirmInstall 'Insync'; then
	brew cask install insync
fi

if ConfirmInstall 'Todoist'; then
	OpenAppLinkAndPrompt 'Todoist' \
		'macappstore://itunes.apple.com/us/app/todoist-to-do-list-task-list/id585829637?mt=12'
fi

if ConfirmInstall 'KeepingYouAwake'; then
	brew cask install keepingyouawake
fi

if ConfirmInstall 'iTerm2' 'iTerm'; then
	iTermPrefsFilename='com.googlecode.iterm2.plist'
	# Initialize iTerm with stored preferences if not already in local Library
	if [ ! -e ~/Library/Preferences/"$iTermPrefsFilename" ] && [ -e "$iTermPrefsFilename" ]; then
		cp "$iTermPrefsFilename" ~/Library/Preferences/"$iTermPrefsFilename"
	fi
	brew cask install iterm2
fi

if ConfirmInstall 'Moom'; then
	brew cask install moom
fi

if ConfirmInstall 'BetterTouchTool'; then
	brew cask install bettertouchtool
fi

if ConfirmInstall 'Airmail 3'; then
	OpenAppLinkAndPrompt 'Airmail 3' \
		'macappstore://itunes.apple.com/us/app/airmail-3/id918858936?mt=12'
fi

if ConfirmInstall 'Evernote'; then
	OpenAppLinkAndPrompt 'Evernote' \
		'macappstore://itunes.apple.com/us/app/evernote-stay-organized/id406056744?mt=12'
fi

if ConfirmInstall 'TogglDesktop'; then
	brew cask install toggl
fi

if ConfirmInstall 'MacVim'; then
	brew cask install macvim
fi

if ConfirmInstall 'MacDown'; then
	brew cask install macdown
fi

if ConfirmInstall 'Alfred 3'; then
	brew cask install alfred
fi

if ConfirmInstall 'TG Pro'; then
	brew cask install tg-pro
fi

if ConfirmInstall 'BitBar'; then
	brew cask install bitbar
fi

if ConfirmInstall 'Spotify'; then
	brew cask install spotify
fi

if ConfirmInstall 'Goofy'; then
	brew cask install goofy
fi

if ConfirmInstall '1Keyboard'; then
	OpenAppLinkAndPrompt '1Keyboard' 'macappstore://itunes.apple.com/us/app/1keyboard/id766939888?mt=12'
fi

if ConfirmInstall 'Tunnelblick'; then
	brew cask install tunnelblick
fi

if ConfirmInstall 'IntelliJ IDEA CE'; then
	brew cask install intellij-idea-ce
fi

#
# GAMES
#

if ConfirmInstall 'Steam'; then
	brew cask install steam
fi

if ConfirmInstall 'Minecraft'; then
	brew cask install minecraft
fi

