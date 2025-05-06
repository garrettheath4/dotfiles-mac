#!/usr/bin/env sh

dotfilesServices=$(pwd)

for f in *.workflow ; do
	# ln: link command
	# -s: symbolic link
	# -h: do not follow symbolic links (when creating links)
	# -i: prompt before overwriting existing files
	# -v: verbose output
	ln -shiv "$dotfilesServices/$f" "$HOME/Library/Services/$f"
done
