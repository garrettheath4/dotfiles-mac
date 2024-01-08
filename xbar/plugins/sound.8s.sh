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
else
	name="$(SwitchAudioSource -c)"

	# LG Ultra HD
	# Arctis Nova 7
	# Mac mini Speakers
	# Garrett’s AirPods Pro G2
	if [[ $name == "LG Ultra HD" ]]; then
		echo ":computer:"
	elif [[ $name == "Arctis Nova 7" ]]; then
		echo ":telephone_receiver:"
	elif [[ $name == "Mac mini"* ]] || [[ $name == "MacBook"* ]]; then
		echo ":speaker:"
	elif [[ $name == *AirPods* ]]; then
		echo ":headphones:"
	fi

	echo "---"
	echo "$name"
fi
