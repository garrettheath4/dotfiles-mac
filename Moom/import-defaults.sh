#!/usr/bin/env bash

osascript -e 'quit app "Moom"'

defaults import com.manytricks.Moom Moom.plist

osascript -e 'launch app "Moom"'
