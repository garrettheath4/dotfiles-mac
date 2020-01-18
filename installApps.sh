#!/usr/bin/env bash
# Script to install major programs and Applications on a Mac account.
# Most things in this script (unless they're very minor) should run with
# a prompted confirmation from the user to install each item.

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

GenericInstallPrompt () {
	if [ "$#" -lt 1 ]; then
		echo 'Usage: GenericInstallPrompt <PrettyAppName>'
		echo 'Returns: 0 for YES or 1 for NO'
		return 255
	fi
	read -r -p "Install $1 now? (y/n) [y]: " confirminstall
	[ "$confirminstall" != 'n' ]
}

ConfirmInstallApp () {
	if [ "$#" -lt 1 ]; then
		echo 'Usage: ConfirmInstallApp <DescriptionString> [InstalledAppName]'
		echo 'Returns: 0 for YES or 1 for NO'
		return 255
	fi
	if [[ ! -d "/Applications/$2.app" && ! -d "/Applications/$1.app" && ! -e "$2" ]]; then
		GenericInstallPrompt "$1"
	else
		# Return NO because it's already installed
		return 1
	fi
}

ConfirmInstallBrewCask () {
	if [ "$#" -lt 1 ]; then
		echo 'Usage: ConfirmInstallBrewCask <AppToCheck> [CaskToInstall]'
		return 255
	fi
	AppToCheck="$1"
	CaskToInstall="${AppToCheck// /-}"
	if [ "$#" -ge 2 ]; then
		CaskToInstall="$2"
	fi
	if ConfirmInstallApp "$AppToCheck"; then
		brew cask install "$CaskToInstall"
	fi
}

OpenAppLinkAndPrompt () {
	if [ "$#" -lt 1 ]; then
		echo "Usage: OpenAppLinkAndPrompt Evernote 'macappstore://itunes.apple.com/us/app/evernote-stay-organized/id406056744?mt=12'"
		return 255
	fi
	AppName="$1"
	LinkToOpen="$2"
	if [ -n "$LinkToOpen" ]; then
		open "$LinkToOpen"
	fi
	read -r -p "Press Enter after $AppName is installed to continue..."
}

CommandExists () {
	command -v "$1" >/dev/null 2>&1
}

CommandDoesNotExist () {
	! CommandExists "$1"
}

#
# FILES
#

# Add fractals to Pictures folder
if ConfirmInstallApp 'fractals to Pictures folder' ~/Pictures/Fractals-2560x1600; then
	ln -is "$REPO/Fractals-2560x1600" ~/Pictures/
fi

# Install special sound effects
if ConfirmInstallApp "\"Robot Blip\" sound" ~/Library/Sounds/'Robot Blip.aiff'; then
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

if CommandDoesNotExist git && GenericInstallPrompt "git (and other developer command line tools)"; then
	xcode-select --install
	# macOS should prompt you to install the Developer Tools which includes Git
	# OpenAppLinkAndPrompt is just a fancy way to wait for the GUI installation
	#   to finish before the user presses Enter to continue this script
	OpenAppLinkAndPrompt 'Git'
fi

if CommandDoesNotExist git; then
	echo 'Warning: It appears that Git was not installed. You may need to install it yourself.'
	exit 1
else
	git --version
fi


#
# Homebrew (needed to install other tools and apps in this script)
#

if CommandDoesNotExist brew && GenericInstallPrompt "Homebrew"; then
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
	brew --version
fi

if CommandDoesNotExist brew; then
	echo 'Warning: It appears that Homebrew was not installed. You may need to install it yourself.'
	exit 2
fi

brew update


#
# Google Chrome (install before opening web pages in this script)
#

ConfirmInstallBrewCask 'Google Chrome' 'google-chrome'


#
# TOOLS
#

# LastPass extensions
LastPassInstallerApp='/usr/local/Caskroom/lastpass/latest/LastPass Installer.app'
if ConfirmInstallApp 'LastPass Universal Mac Installer' "$LastPassInstallerApp"; then
	brew cask install lastpass
	OpenAppLinkAndPrompt 'LastPass' "$LastPassInstallerApp"
fi

# Tmux
if CommandDoesNotExist tmux && GenericInstallPrompt "Tmux"; then
	brew install tmux
else
	tmux -V
fi

# reattach-to-user-namespace (for Tmux copy-paste to work on macOS)
if CommandExists tmux && CommandDoesNotExist reattach-to-user-namespace && GenericInstallPrompt "reattach-to-user-namespace"; then
	brew install reattach-to-user-namespace
fi

if CommandDoesNotExist ag; then
	brew install ag
fi

#
# APPS
#

ConfirmInstallBrewCask 'Insync'

if ConfirmInstallApp 'Todoist'; then
	OpenAppLinkAndPrompt 'Todoist' \
		'macappstore://itunes.apple.com/us/app/todoist-to-do-list-task-list/id585829637?mt=12'
fi

ConfirmInstallBrewCask 'KeepingYouAwake'

if ConfirmInstallApp 'iTerm2' 'iTerm'; then
	iTermPrefsFilename='com.googlecode.iterm2.plist'
	# Initialize iTerm with stored preferences if not already in local Library
	if [ ! -e ~/Library/Preferences/"$iTermPrefsFilename" ] && [ -e "$iTermPrefsFilename" ]; then
		cp "$iTermPrefsFilename" ~/Library/Preferences/"$iTermPrefsFilename"
	fi
	brew cask install iterm2
fi

ConfirmInstallBrewCask 'Moom'
ConfirmInstallBrewCask 'BetterTouchTool'

if ConfirmInstallApp 'Airmail 3'; then
	OpenAppLinkAndPrompt 'Airmail 3' \
		'macappstore://itunes.apple.com/us/app/airmail-3/id918858936?mt=12'
fi

if ConfirmInstallApp 'Evernote'; then
	OpenAppLinkAndPrompt 'Evernote' \
		'macappstore://itunes.apple.com/us/app/evernote-stay-organized/id406056744?mt=12'
fi

ConfirmInstallBrewCask 'TogglDesktop' 'toggl'
ConfirmInstallBrewCask 'MacVim'
ConfirmInstallBrewCask 'MacDown'
ConfirmInstallBrewCask 'Alfred 3' 'alfred'
ConfirmInstallBrewCask 'TG Pro' 'tg-pro'
ConfirmInstallBrewCask 'BitBar'
ConfirmInstallBrewCask 'Goofy'

if ConfirmInstallApp '1Keyboard'; then
	OpenAppLinkAndPrompt '1Keyboard' 'macappstore://itunes.apple.com/us/app/1keyboard/id766939888?mt=12'
fi

if ConfirmInstallApp 'Quick Calendar'; then
	OpenAppLinkAndPrompt 'Quick Calendar (app download) ' 'macappstore://itunes.apple.com/us/app/quick-calendar/id1004514425?mt=12'
	OpenAppLinkAndPrompt 'Quick Calendar (post-download)' '/Applications/Quick Calendar.app'
fi

ConfirmInstallBrewCask 'Tunnelblick'
ConfirmInstallBrewCask 'BackupLoupe'

if ConfirmInstallApp 'Deliveries'; then
	OpenAppLinkAndPrompt 'Deliveries' \
		'macappstore://itunes.apple.com/us/app/deliveries-a-package-tracker/id924726344?mt=12'
fi

ConfirmInstallBrewCask 'AirServer'


#
# MEDIA TOOLS
#

ConfirmInstallBrewCask 'Spotify'

if ConfirmInstallApp 'Sonos'; then
	brew tap caskroom/drivers
	brew cask install sonos
fi

ConfirmInstallBrewCask 'GIMP'
ConfirmInstallBrewCask 'VLC'
ConfirmInstallBrewCask '4K Video Downloader' '4k-video-downloader'


#
# DEVELOPER TOOLS
#

ConfirmInstallBrewCask 'JetBrains Toolbox' 'jetbrains-toolbox'

if ConfirmInstallApp 'LaTeX' '/Applications/TeX'; then
	brew cask install 'mactex'
fi

ConfirmInstallBrewCask 'Etcher' 'balenaetcher'


#
# GAMES
#

ConfirmInstallBrewCask 'Steam'
ConfirmInstallBrewCask 'Minecraft'

