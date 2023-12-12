#!/usr/bin/env bash
# vim: set nobackup:
# <xbar.title>Top Proc</xbar.title>
# <xbar.version>v1.0</xbar.version>
# <xbar.author>Garrett Heath Koller</xbar.author>
# <xbar.author.github>garrettheath4</xbar.author.github>
# <xbar.desc>Displays the name and CPU percentage of the process using the most CPU power at any given time.</xbar.desc>
# <xbar.var>number(VAR_CPU_PERCENT_THRESHOLD=80): Processes with CPU percentages below this integer will be considered asleep.</xbar.var>
# <xbar.var>number(VAR_NUM_PROCESSES=3): Number of top processes to show in dropdown menu.</xbar.var>
#
# xbar script that displays the name and CPU percentage of the process using the most CPU power at any given time.
# See: https://github.com/matryer/xbar

# Base cmd: ps axrc - displays all %cpu and process names, biggest cpu first
baseText="$(ps -a -x -r -c -o %cpu,command | sed 1d | head -n "${VAR_NUM_PROCESSES:-3}")"

topCpuPercentInt=$( (head -n1 <<< "$baseText") | grep -E -o '[0-9]+' | head -n1)

# Short text (for menubar)
if [ "$topCpuPercentInt" -ge "${VAR_CPU_PERCENT_THRESHOLD:-80}" ]; then
	echo "$( (head -n1 <<< "$baseText") | sed -E -e 's/\.[0-9]+ /% /' -e 's/Google Chrome/Chrome/' -e 's/Brave Browser/Brave/')|length=10 font='Courier New' size=11"
else
	echo ":zzz:|size=11"
fi

# Anything past these three dashes will be in the dropdown menu only and not in the menu bar
echo "---"

# Long text (for dropdown)
sed -E -e 's/(\.[0-9]+) /\1% /' <<< "$baseText"
