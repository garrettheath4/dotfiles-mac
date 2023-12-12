#!/usr/bin/env bash
# Script to configure a Mac account with preferred settings
# This script may also install minor programs but everything in this script
# should run to completion without any prompts, sudo or otherwise

# Source directory one-liner (below) from https://stackoverflow.com/a/246128
dotfiles="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

hidden_files='.ghk_profile
.ghkrc
.zshrc
.bash_profile
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
default_email=$(echo 'Z2FycmV0dGhlYXRoNEBnbWFpbC5jb20K' | base64 --decode)

for hf in $hidden_files; do
	if [ -f "$hf" ]; then
		if [ ! -e ~/"$hf" ]; then
			ln -sv "$dotfiles/$hf" ~/"$hf"
		else
			if [ ! -L ~/"$hf" ]; then
				echo 'Warning:' ~/"$hf already exists but is not a link"
			else
				echo 'Info: Link already exists:' ~/"$hf"
			fi
		fi
	else
		echo "Error: Hidden file $hf does not exist in dotfiles repo"
	fi
done

for hd in $hidden_dirs; do
	if [ -d "$hd" ]; then
		if [ ! -e ~/"$hd" ]; then
			ln -sv "$dotfiles/$hd" ~/"$hd"
		else
			if [ ! -L ~/"$hd" ]; then
				echo 'Warning:' ~/"$hd already exists but is not a link"
			else
				echo 'Info: Link already exists:' ~/"$hd/"
			fi
		fi
	else
		echo "Error: Hidden directory $hd does not exist in dotfiles repo"
	fi
done

for nd in $normal_dirs; do
	if [ -d "$nd" ]; then
		if [ ! -e ~/"$nd" ]; then
			ln -sv "$dotfiles/$nd" ~/"$nd"
		else
			if [ ! -L ~/"$hd" ]; then
				echo 'Warning:' ~/"$nd already exists but is not a link"
			else
				echo 'Info: Link already exists:' ~/"$nd/"
			fi
		fi
	else
		echo "Error: Normal directory $nd does not exist in dotfiles repo"
	fi
done

# Install Vundle Vim package manager
git submodule init && git submodule update
vim +PluginInstall +qall

# Link xbar plugin folder `~/Library/Application Support/xbar/plugins/` to `dotfiles/xbar/plugins/`
if [ ! -L ~/"Library/Application Support/xbar/plugins" ]; then
	if [ ! -d ~/"Library/Application Support/xbar/plugins" ]; then
		# plugins does not exist at all
		if [ ! -d ~/"Library/Application Support/xbar" ]; then
			mkdir ~/"Library/Application Support/xbar"
		fi
		ln -sv "$dotfiles/xbar/plugins" ~/"Library/Application Support/xbar/plugins"
	else
		# plugins exists but is not a link
		if [ -z "$(ls -A ~/"Library/Application Support/xbar/plugins")" ]; then
			# plugins exists and is not a link but is empty
			rmdir -v ~/"Library/Application Support/xbar/plugins"
			ln -sv "$dotfiles/xbar/plugins" ~/"Library/Application Support/xbar/plugins"
		else
			# plugins exists and is not a link but is NOT empty
			echo 'Warning:' ~/'Library/Application Support/xbar/plugins/ already exists and is not a link but is NOT empty'
		fi
	fi
else
	echo 'Info: Link already exists:' ~/'Library/Application Support/xbar/plugins/'
fi

# Configure Git
if [ ! -f ~/.gitconfig ]; then
	git config --global init.defaultBranch main
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
else
	echo 'Info: Git configuration file already exists:' ~/.gitconfig
fi

fontName=Droid+Sans+Mono+Awesome.ttf
fontDir=awesome-terminal-fonts/patched

# If not found, prompt to install patched Awesome-Terminal-Fonts
# to use in terminal app to display Git-enhanced prompt from oh-my-git
if [ -f "$fontDir/$fontName" ] && [ ! -f "$HOME/Library/Fonts/$fontName" ]; then
	read -p "Install new font $fontName? [Y/n]: " -n 1 -r ; echo
	if [[ ! $REPLY =~ ^[Nn]$ ]]; then
		open "$fontDir/$fontName"
	else
		echo 'Please install a patched Awesome-Terminal-Fonts font and use it with your Terminal app to display enhanced Git icons in the Bash prompt.'
		echo 'For example, run:  open ~/dotfiles/awesome-terminal-fonts/patched/Droid+Sans+Mono+Awesome.ttf'
		echo 'Then set "Droid Sans Mono Awesome" as the font for your Terminal app.'
	fi
fi
