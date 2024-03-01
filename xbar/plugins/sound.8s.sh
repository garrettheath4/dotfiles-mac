#!/usr/bin/env bash
# vim: set nobackup nosmarttab softtabstop=0 noexpandtab:
# <xbar.title>Sound Device</xbar.title>
# <xbar.version>v1.2</xbar.version>
# <xbar.author>Garrett Heath Koller</xbar.author>
# <xbar.author.github>garrettheath4</xbar.author.github>
# <xbar.desc>Display icon representing the current sound output device.</xbar.desc>
#
# xbar script that displays icon representing the current sound output device.
# See: https://github.com/matryer/xbar
#
# Emoji codes can be found here:
# https://github.com/matryer/xbar/blob/main/pkg/plugins/emoji.go
# Friendlier (but less acurate) emoji codes can be found here:
# https://github.com/ikatyang/emoji-cheat-sheet/blob/master/README.md

# Add Homebrew to PATH
PATH="$PATH:/opt/homebrew/bin"

if ! command -v SwitchAudioSource >/dev/null; then
	echo ':beer:'
	echo '---'
	echo 'ERROR: SwitchAudioSource is not installed. Please install it with: brew install switchaudio-osx'
	echo "PATH = $PATH"
	exit 1
fi

output_name="$(SwitchAudioSource -c -f human -t output)"
input_name="$(SwitchAudioSource  -c -f human -t input)"

if [[ ($input_name == "$output_name" || ($input_name == 'MacBook '* && $output_name == 'MacBook '*)) && $input_name != 'USB Audio' ]]; then
	device_types='all'
else
	device_types='output input'
fi

for device_type in $device_types; do
	case "$device_type" in
		all)
			device_name="$output_name"
			echo -n ':speaker:'
			;;
		output)
			device_name="$output_name"
			echo -n ':speaker:'
			;;
		input)
			device_name="$input_name"
			echo -n ':microphone:'
			;;
	esac
	case "$device_name" in
		# USB Audio (KVM)
		'LG Ultra HD' | 'USB Audio')
			if [ "$device_type" == output ]; then
				echo -n ':tv:'
			else
				# Input should not be "USB Audio" because a microphone is not connected to the KVM
				echo -n ':warning:'
			fi
			;;
		# Arctis Nova 7
		'Arctis'*)
			echo -n ':headphones:'
			;;
		# Mac mini Speakers
		'Mac mini'* | 'MacBook'*)
			echo -n ':computer:'
			;;
		# Garrett’s AirPods Pro G2
		*AirPods*)
			echo -n ':ear:'
			;;
		# HD Pro Webcam C920
		*Webcam*)
			echo -n ':cinema:'
			;;
		*)
			echo -n ':wrench:'
			;;
	esac
	echo -n ' '
done

echo
echo '---'
echo "Output: $output_name"
echo "Input: $input_name"
