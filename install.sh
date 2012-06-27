#!/bin/sh

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
			ln -s "_$hf" ~/"$hf"
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
			ln -s "_$hd" ~/"$hd"
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
			ln -s "$nd" ~/"$nd"
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
