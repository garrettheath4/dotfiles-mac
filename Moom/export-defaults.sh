#!/usr/bin/env bash

osascript -e 'quit app "Moom"'

defaults export com.manytricks.Moom Moom.plist

osascript -e 'launch app "Moom"'
