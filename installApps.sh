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

# Add fractals to Pictures folder
read -p "Add fractals to Pictures folder? (y/n) [y]: " confirmfrac
if [ "$confirmfrac" != "n" ]; then
	if [ -d "$EXPORTS/Fractals-2560x1600" ]; then
		ln -is "$EXPORTS/Fractals-2560x1600" ~/Pictures/
	fi
fi

# Install special sound effects
read -p "Install \"Robot Blip\" sound now? (y/n) [y]: " confirmsound
if [ "$confirmsound" != "n" ]; then
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

# Prompt to install Mail ActOn
read -p "Install Mail ActOn now? (y/n) [y]: " confirmacton
if [ "$confirmacton" != "n" ]; then
	ShowLicenses
	open "http://www.indev.ca/MailActOn.html"
fi

# Prompt to install TotalTerminal
read -p "Install TotalTerminal now? (y/n) [y]: " confirmtterm
if [ "$confirmtterm" != "n" ]; then
	open "http://totalterminal.binaryage.com/"
fi

# Prompt to install Growl
read -p "Install Growl now? (y/n) [y]: " confirmgrowl
if [ "$confirmvoice" ]; then
	open "http://itunes.apple.com/us/app/growl/id467939042"
fi

# Prompt to install GrowlVoice
read -p "Install GrowlVoice now? (y/n) [y]: " confirmvoice
if [ "$confirmvoice" ]; then
	open "http://itunes.apple.com/us/app/growlvoice-google-voice-client/id413146256"
fi
