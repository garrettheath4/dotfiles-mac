#!/usr/bin/env bash
# Script to configure a Mac account with preferred settings
# This script may also install minor programs but everything in this script
# should run to completion without any prompts, sudo or otherwise

# Source directory one-liner (below) from https://stackoverflow.com/a/246128
DOTFILES="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

HIDDENFILES='.bash_profile
.git-completion.bash
.gitconfig
.vimrc
.ideavimrc
.tmux.conf
.tmux-osx.conf'

HIDDENDIRS='.idlerc
.vim'

NORMALDIRS='bin
sbin'

for hf in $HIDDENFILES; do
	if [ -f "_$hf" ]; then
		if [ ! -e ~/"$hf" ]; then
			ln -sv "$DOTFILES/_$hf" ~/"$hf"
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
			ln -sv "$DOTFILES/_$hd" ~/"$hd"
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
			ln -sv "$DOTFILES/$nd" ~/"$nd"
		else
			echo "Warning:" ~/"$nd/ already exists"
		fi
	else
		echo "Warning: $nd does not exist"
	fi
done

# Install Vundle Vim package manager
mkdir -p "$DOTFILES/_.vim/bundle"
git clone https://github.com/VundleVim/Vundle.vim.git "$DOTFILES/_.vim/bundle/Vundle.vim"
vim +PluginInstall +qall

# Install GrowlStyles
GROWL_FOLDER="$HOME/Library/Application Support/Growl"
# shellcheck disable=SC2174
mkdir -pv -m 755 "$GROWL_FOLDER"
GROWL_PLUGINS="$GROWL_FOLDER/Plugins"
# shellcheck disable=SC2174
mkdir -pv -m 755 "$GROWL_PLUGINS"
GROWLS="$(ls -1 GrowlStyles/)"
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
if [ -d "$MAILON_FOLDER" ] && [ ! -d "$MAILON_FOLDER".backup ]; then
	mv -fv "$MAILON_FOLDER" "$MAILON_FOLDER".backup
fi
ln -Ffhsv "$DOTFILES/MailActOn" "$MAILON_FOLDER"

if [ "$(uname)" = "Darwin" ]; then
	echo "NOTE: Install Homebrew and use it to install reattach-to-user-namespace to get tmux copy/paste and app launching functionality to work properly"
fi

