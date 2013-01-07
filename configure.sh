#!/bin/sh
# Script to configure a Mac account with preferred settings
# This script may also install minor programs but everything in this script
# should run to completion without any prompts, sudo or otherwise

EXPORTS="`pwd`"

HIDDENFILES='.bash_profile
.gitconfig
.vimrc'

HIDDENDIRS='.idlerc
.vim'

NORMALDIRS='bin
sbin'

for hf in $HIDDENFILES; do
	if [ -f "_$hf" ]; then
		if [ ! -e ~/"$hf" ]; then
			ln -sv "$EXPORTS/_$hf" ~/"$hf"
		else
			echo "Warning:" ~/"$hf already exists"
		fi
	else
		echo "Warning: _$hf does not exist"
	fi
done

for hd in $HIDDENDIRS; do
	if [ -d "_$hd" ]; then
		if [ ! -e ~/"$hd" ]; then
			ln -sv "$EXPORTS/_$hd" ~/"$hd"
		else
			echo "Warning:" ~/"$hd/ already exists"
		fi
	else
		echo "Warning: _$hd does not exist"
	fi
done

for nd in $NORMALDIRS; do
	if [ -d "$nd" ]; then
		if [ ! -e ~/"$nd" ]; then
			ln -sv "$EXPORTS/$nd" ~/"$nd"
		else
			echo "Warning:" ~/"$nd/ already exists"
		fi
	else
		echo "Warning: $nd does not exist"
	fi
done

# Install GrowlStyles
GROWL_FOLDER=~/Library/Application\ Support/Growl/Plugins
GROWLS="`ls -1 GrowlStyles/`"
mkdir -pv -m 755 "$GROWL_FOLDER"
for grr in $GROWLS; do
	if [ ! -e "$GROWL_FOLDER/$grr" ]; then
		# Growl style not installed, so install it
		cp -r "GrowlStyles/$grr" "$GROWL_FOLDER/"
	else
		echo "Note: Growl Style \"$grr\" already installed"
	fi
done

# Install Mail ActOn Rules
MAILON_FOLDER=~/Library/Mail/Bundles/MailActOn.mailbundle/Contents/MacOS
if [ -d "$MAILON_FOLDER" -a ! -d "$MAILON_FOLDER".backup ]; then
	mv -fv "$MAILON_FOLDER" "$MAILON_FOLDER".backup
fi
ln -Ffhsv "$EXPORTS/MailActOn" "$MAILON_FOLDER"
