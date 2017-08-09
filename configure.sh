#!/usr/bin/env bash
# Script to configure a Mac account with preferred settings
# This script may also install minor programs but everything in this script
# should run to completion without any prompts, sudo or otherwise

# Source directory one-liner (below) from https://stackoverflow.com/a/246128
DOTFILES="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

HIDDENFILES='.bash_profile
.git-completion.bash
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
git submodule init && git submodule update
vim +PluginInstall +qall

# Configure Git
git config --global push.default simple
git config --global diff.tool vimdiff
echo 'Be sure to run the following commands to finish configuring Git:'
echo '  git config --global user.name  "Garrett Heath Koller"'
echo '  git config --global user.email "garrettheath4@gmail.com"'
