#!/usr/bin/env bash
# vim: set nobackup nosmarttab softtabstop=0 noexpandtab:
# <xbar.title>Sound Device</xbar.title>
# <xbar.version>v1.0</xbar.version>
# <xbar.author>Garrett Heath Koller</xbar.author>
# <xbar.author.github>garrettheath4</xbar.author.github>
# <xbar.desc>Display icon representing the current sound output device.</xbar.desc>
#
# xbar script that displays icon representing the current sound output device.
# See: https://github.com/matryer/xbar

# Add Homebrew to PATH
PATH="$PATH:/opt/homebrew/bin"

if ! command -v SwitchAudioSource >/dev/null; then
	echo ":beer:"
	echo "---"
	echo "ERROR: SwitchAudioSource is not installed. Please install it with: brew install switchaudio-osx"
	echo "PATH = $PATH"
	exit 1
fi

name="$(SwitchAudioSource -c)"

case "$name" in
	"LG Ultra HD" | "USB Audio")
		echo ":computer:"
		;;
	# Arctis Nova 7
	"Arctis"*)
		echo ":telephone_receiver:"
		;;
	# Mac mini Speakers
	"Mac mini"* | "MacBook"*)
		echo ":speaker:"
		;;
	# Garrett’s AirPods Pro G2
	*AirPods*)
		echo ":headphones:"
		;;
	*)
		echo ":wrench:"
		;;
esac

echo "---"
echo "$name"
