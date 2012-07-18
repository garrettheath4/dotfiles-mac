#!/bin/sh
# Script to install major programs and Applications on a Mac account
# Most things in this script (unless they're very minor) should run with
# a prompted confirmation from the user to install each item

EXPORTS="`pwd`"

# Add fractals to Pictures folder
if [ -d "$EXPORTS/Fractals-2560x1600" ]; then
	ln -is "$EXPORTS/Fractals-2560x1600" ~/Pictures/
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
	pbcopy < "$EXPORTS/MailActOn/license-key.txt"
	echo "Mail ActOn Name: Garrett Koller"
	echo "Mail ActOn Key:  MAO-001-AHN2-J1GJ-FBTS-J4F7-BAP9"
	echo "   (The license key has been copied to the clipboard.)"
	open "$EXPORTS/MailActOn/Website.webloc"
fi
