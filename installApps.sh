#!/usr/bin/env bash
# Script to install major programs and Applications on a Mac account
# Most things in this script (unless they're very minor) should run with
# a prompted confirmation from the user to install each item

REPO="$(pwd)"

# Variable: Has the spreadsheet with the list of licenses been opened yet?
#   Values: 'YES' or 'NO'
LicensePage="https://docs.google.com/spreadsheets/d/14pl7ljKn8bf8rZZgHrU56zbQFePMpGCLUH0U3UQRTVI/edit#gid=0"
OpenedLicenses="NO"

ShowLicenses () {
	if [ "$OpenedLicenses" == "NO" ]; then
		open "$LicensePage"
		OpenedLicenses="YES"
	fi
}

ConfirmInstall () {
	# Usage: ConfirmInstall DescriptionString InstalledAppName
	# Returns: 0 for YES
	# (as $?): 1 for NO
	if [[ ! -d "/Applications/$2.app" && ! -d "/Applications/$1.app" && ! -e "$2" ]]; then
		read -r -p "Install $1 now? (y/n) [y]: " confirminstall
		[ "$confirminstall" != "n" ]
	else
		# Return NO
		return 1
	fi
}

LuckySearch () {
	# Usage: LuckySearch SearchString
	# Action: Performs an I'm Feeling Lucky Google search of SearchString
	GIFL="http://www.google.com/search?q=%s&btnI=Im+Feeling+Lucky"
	URL=$(echo "$GIFL" | sed -e "s/%s/$1/" | sed -e 's/ /+/g')
	echo "Opening $URL"
	open "$URL"
}

#
# FILES
#

# Add fractals to Pictures folder
if ConfirmInstall "fractals to Pictures folder" ~/Pictures/Fractals-2560x1600; then
	ln -is "$REPO/Fractals-2560x1600" ~/Pictures/
fi

# Install special sound effects
if ConfirmInstall "\"Robot Blip\" sound" \
		'/System/Library/Sounds/Robot Blip.aiff'; then
	echo "Adding \"Robot Blip\" to system sounds..."
	if [ -e "$REPO/Sounds/Robot Blip.aiff" ]; then
		sudo cp "$REPO/Sounds/Robot Blip.aiff" \
			/System/Library/Sounds/
		if [ "$?" != 0 ]; then
			echo "Warning: Error in installing Robot Blip."
			echo "         Perhaps you don't have sudo permissions?"
		fi
	else
		echo "Warning: Unable to find \"Robot Blip.aiff\"."
	fi
fi


#
# Google Chrome (install before opening later web pages)
#

if ConfirmInstall "Google Chrome"; then
	LuckySearch "install google chrome for mac site:google.com"
fi


#
# TOOLS
#

# Prompt to install LastPass extension for Google Chrome
if ConfirmInstall 'LastPass for Google Chrome'; then
	LuckySearch "lastpass mac chrome download"
fi

# Prompt to install XScreenSaver
if ConfirmInstall 'XScreenSaver'; then
	LuckySearch "XScreenSaver for macos x download"
fi

# Prompt to install Mail ActOn
if ConfirmInstall "Mail ActOn" \
		"/Users/Garrett/Library/Mail/Bundles/MailActOn.mailbundle"
		then
	ShowLicenses
	LuckySearch "Indev Mail ActOn for Mac"
fi

# Prompt to install TotalTerminal
if ConfirmInstall "TotalTerminal"; then
	LuckySearch "totalterminal for mac"
fi

# Prompt to install Growl
if ConfirmInstall "Growl"; then
	open "macappstore://itunes.apple.com/us/app/growl/id467939042"
fi

# Prompt to install GrowlVoice
if ConfirmInstall "GrowlVoice"; then
	open "macappstore://itunes.apple.com/us/app/growlvoice-google-voice-client/id413146256"
fi

# Prompt to install HardwareGrowler
if ConfirmInstall "HardwareGrowler"; then
	open "macappstore://itunes.apple.com/us/app/hardwaregrowler/id475260933"
fi

# Prompt to install Xcode
if ConfirmInstall "Xcode"; then
	open "macappstore://itunes.apple.com/us/app/xcode/id497799835"
fi

# Prompt to install Google Drive
if ConfirmInstall "Google Drive"; then
	open "http://tools.google.com/dlpage/drive"
fi


#
# APPS
#

# Prompt to install MacVim
if ConfirmInstall "MacVim" "Vim"; then
	LuckySearch "macvim for mac"
fi

# Prompt to install Things for Mac
if ConfirmInstall "Things for Mac" "Things"; then
	LuckySearch "Things for Mac cultured code"
fi

# Prompt to install Spotify
if ConfirmInstall "Spotify"; then
	LuckySearch "spotify for mac"
fi

# Prompt to install Skype
if ConfirmInstall "Skype"; then
	LuckySearch "skype for mac site:skype.com"
fi

# Prompt to install GitHub for Mac
if ConfirmInstall "GitHub for Mac" "GitHub"; then
	LuckySearch "github for mac site:github.com"
fi

# Prompt to install HandBrake
if ConfirmInstall "HandBrake"; then
	LuckySearch "handbrake for mac"
fi


#
# GAMES
#

# Prompt to install Steam
if ConfirmInstall "Steam"; then
	LuckySearch "steam for mac download site:steampowered.com"
fi

# Prompt to install StarCraft II
if ConfirmInstall "StarCraft II" "StarCraft II/StarCraft II"; then
	open "https://us.battle.net/account/management/download/"
fi

# Prompt to install Minecraft
if ConfirmInstall "Minecraft"; then
	LuckySearch "minecraft for mac download"
fi

# Prompt to install Battle for Wesnoth
if ConfirmInstall "Battle for Wesnoth" "Wesnoth"; then
	LuckySearch "battle for wesnoth for mac"
fi
