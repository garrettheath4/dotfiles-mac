#!/usr/bin/env bash
# Script to configure a Mac account with preferred settings
# This script may also install minor programs but everything in this script
# should run to completion without any prompts, sudo or otherwise

# Source directory one-liner (below) from https://stackoverflow.com/a/246128
dotfiles="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

hidden_files='.bash_profile
.git-completion.bash
.editorconfig
.vimrc
.ideavimrc
.mdlrc
.tmux.conf
.tmux-osx.conf'

hidden_dirs='.idlerc
.vim'

normal_dirs='bin
sbin'

default_full_name='Garrett Heath Koller'
default_email='garrettheath4@gmail.com'

for hf in $hidden_files; do
	if [ -f "_$hf" ]; then
		if [ ! -e ~/"$hf" ]; then
			ln -sv "$dotfiles/_$hf" ~/"$hf"
		else
			echo "Warning:" ~/"$hf already exists"
		fi
	else
		echo "Warning: _$hf does not exist"
	fi
done

for hd in $hidden_dirs; do
	if [ -d "_$hd" ]; then
		if [ ! -e ~/"$hd" ]; then
			ln -sv "$dotfiles/_$hd" ~/"$hd"
		else
			echo "Warning:" ~/"$hd/ already exists"
		fi
	else
		echo "Warning: _$hd does not exist"
	fi
done

for nd in $normal_dirs; do
	if [ -d "$nd" ]; then
		if [ ! -e ~/"$nd" ]; then
			ln -sv "$dotfiles/$nd" ~/"$nd"
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
git config --global pull.ff only
git config --global push.default simple
git config --global diff.tool vimdiff
git config --global color.ui auto
git config --global alias.prune 'remote prune origin'

if ! git config --global user.name || ! git config --global user.email ; then
	read -rp "Enter your full name to set the user.name global configuration value in Git [$default_full_name]: "
	git config --global user.name "${REPLY:-$default_full_name}"
	read -rp "Enter your email address to set the user.email global configuration value in Git [$default_email]: "
	git config --global user.email "${REPLY:-$default_email}"
fi

# Suggest installing patched Awesome-Terminal-Fonts to use in termminal app to display Git-enhanced prompt from oh-my-git
if test -f awesome-terminal-fonts/patched/Droid+Sans+Mono+Awesome.ttf ; then
	echo 'Please install a patched Awesome-Terminal-Fonts font and use it with your Terminal app to display enhanced Git icons in the Bash prompt.'
	echo 'For example, run:  open ~/dotfiles/awesome-terminal-fonts/patched/Droid+Sans+Mono+Awesome.ttf'
	echo 'Then set "Droid Sans Mono Awesome" as the font for your Terminal app.'
fi
