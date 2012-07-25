#!/bin/sh
# Script to install major programs and Applications on a Mac account
# Most things in this script (unless they're very minor) should run with
# a prompted confirmation from the user to install each item

EXPORTS="`pwd`"

# Variable: Has the spreadsheet with the list of licenses been opened yet?
#   Values: 'YES' or 'NO'
LicensePage="https://docs.google.com/spreadsheet/ccc?key=0AkNyR8-zKS20dEpiRHJXWXNrYVV6VnRmRjk2VnN6X2c"
OpenedLicenses="NO"

ShowLicenses () {
	if [ "$OpenedLicenses" == "NO" ]; then
		open "$LicensePage"
		OpenedLicenses="YES"
	fi
}

ConfirmInstall () {
	# Usage: ConfirmInstall DescriptionString
	# Returns: 0 for YES
	# (as $?): 1 for NO
	read -p "Install $1 now? (y/n) [y]: " confirminstall
	if [ "$confirminstall" != "n" ]; then
		# Return YES
		return 0
	else
		# Return NO
		return 1
	fi
}

LuckySearch () {
	# Usage: LuckySearch SearchString
	# Action: Performs an I'm Feeling Lucky Google search of SearchString
	GIFL="http://www.google.com/search?q=%s&btnI=Im+Feeling+Lucky"
	URL=`echo "$GIFL" | sed -e "s/%s/$1/" | sed -e 's/ /+/g'`
	echo "Opening $URL"
	open "$URL"
}

#
# FILES
#

# Add fractals to Pictures folder
if [ ConfirmInstall "fractals to Pictures folder" ]; then
	ln -is "$EXPORTS/Fractals-2560x1600" ~/Pictures/
fi

# Install special sound effects
if [ ConfirmInstall "\"Robot Blip\" sound" ]; then
	echo "Adding \"Robot Blip\" to system sounds..."
	if [ -e "$EXPORTS/Sounds/Robot Blip.aiff" ]; then
		sudo cp "$EXPORTS/Sounds/Robot Blip.aiff" /System/Library/Sounds/
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

if [ ConfirmInstall "Google Chrome" ]; then
	LuckySearch "install google chrome for mac site:google.com"
fi


#
# TOOLS
#

# Prompt to install Mail ActOn
if [ ConfirmInstall "Mail ActOn" ]; then
	ShowLicenses
	LuckySearch "Indev Mail ActOn for Mac"
fi

# Prompt to install TotalTerminal
if [ ConfirmInstall "TotalTerminal" ]; then
	LuckySearch "totalterminal for mac"
fi

# Prompt to install Growl
if [ ConfirmInstall "Growl" ]; then
	open "macappstore://itunes.apple.com/us/app/growl/id467939042"
fi

# Prompt to install GrowlVoice
if [ ConfirmInstall "GrowlVoice" ]; then
	open "macappstore://itunes.apple.com/us/app/growlvoice-google-voice-client/id413146256"
fi

# Prompt to install HardwareGrowler
if [ ConfirmInstall "HardwareGrowler" ]; then
	open "macappstore://itunes.apple.com/us/app/hardwaregrowler/id475260933"
fi


#
# APPS
#

# Prompt to install MacVim
if [ ConfirmInstall "MacVim" ]; then
	LuckySearch "macvim for mac"
fi
