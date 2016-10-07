#!/usr/bin/env bash
# Git pre-commit show-todos script

exclude_from=""
if [ -f '.gitignore' ]; then
	exclude_from="--exclude-from=.gitignore"
fi

todos=$(grep -ri --exclude='*~' --exclude-dir='.git' $exclude_from '#TODO' .)

if [ -n "$todos" ]; then
	echo "TODOs in project:"
	echo "$todos" | sed -e 's/^\.\///' -e 's/^/ * /' -e 's/#TODO//' -e 's/::/:/'
fi
