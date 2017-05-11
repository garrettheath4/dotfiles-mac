#!/usr/bin/env bash
# vim: set nobackup:
# <bitbar.title>Top Proc</bitbar.title>
# <bitbar.version>0.1</bitbar.version>
# <bitbar.author>Garrett Heath Koller</bitbar.author>
# <bitbar.author.github>garrettheath4</bitbar.author.github>
# <bitbar.desc>Reports the name and CPU percentage of the process using the most CPU power at any given time.</bitbar.desc>

# Base cmd: ps axrc - displays all %cpu and process names, biggest cpu first
baseText="$(ps -a -x -r -c -o %cpu,command | head -n4 | tail -n3)"

# Short text (for menubar)
echo "$( (head -n1 <<< "$baseText") | sed -E -e 's/\.[0-9]+ /% /' -e 's/Google Chrome/Chrome/')|length=10 font='Courier New' size=11"

echo "---"

# Long text (for dropdown)
sed -E -e 's/(\.[0-9]+) /\1% /' <<< "$baseText"
