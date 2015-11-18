#!/bin/bash

if [[ "$#" -ne 1 ]]; then
	cat << EOF
Usage: ${0##*/} <RenameFile.txt>

<RenameFile.txt> is the filename of a text file in the following format:

<OldName1><TAB><NewName1>
<OldName2><TAB><NewName2>
<OldName3><TAB><NewName3>
...

where <TAB> is a tab character that separates the old name from the new name.
EOF
fi

IFS="
"

for line in $(cat $1);
do
	oldName=`echo "$line" | cut -f1`
	newName=`echo "$line" | cut -f2`
	echo git mv "$oldName" "$newName"
	git mv "$oldName" "$newName"
done
