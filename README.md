# OS X Personal Profile Exports
This project contains all of the configuration files I use for all of my Unix-based logins.  When these files are moved to their appropriate places (where applicable), my standard scripts and settings will be set on that computer, such as important environment variables, terminal aliases, and scripts.

## Installation
To install this project:

    git clone https://github.com/garrettheath4/exports-mac.git ~/exports
    cd ~/exports
    ./configure.sh
    ./installApps.sh

## Contents Details

| Repository Item | Description | Linking by `configure.sh` |
| --- | --- | --- |
| `bin/` | Contains Bash user scripts (mostly convenience scripts) | `~/bin` --> `exports-mac/bin/` |
| `sbin/` | Contains Bash administrative scripts (mostly scripts containing `sudo`) | `~/sbin` --> `exports-mac/sbin/` |
| `_.bash_profile` | Contains user Bash settings | `~/.bash_profile` --> `exports-mac/_.bash_profile` |
| `_.vim/` | Contains Vim plugins | `~/.vim` --> `exports-mac/_.vim/` |
| `_.vimrc` | Contains Vim settings | `~/.vimrc` --> `exports-mac/_.vimrc` |
| `_.gitconfig` | Contains Git configuration settings | `~/.gitconfig` --> `exports-mac/_.gitconfig` |
| `_.idlerc/` | Contains Python IDLE settings | `~/.idlerc` --> `exports-mac/_.idlerc/` |
| `GrowlStyles/` | Contains theme styles for the [Growl notification application](http://growl.info/ "Growl") | `~/Library/Application Support/Growl/Plugins/` \<== `exports-mac/GrowlStyles/*` (copied) |
| `MailActOn/` | Contains settings and rules for [Indev ActOn](https://www.indev.ca/MailActOn.html "MailActOn") addon for Apple Mail | `~/Library/Mail/Bundles/MailActOn.mailbundle/Contents/MacOS` --> `exports-mac/MailActOn/` |
| `Fractals-2560x1600/` | HD wallpaper images from [Beautiful Wallpapers](http://www.beautifulfractals.com/ "Beautiful Fractals - Fractal Wallpapers") | n/a |
| `Sounds/` | Contains user sound files | n/a |
| `README.md` | This readme file | n/a |
| `configure.sh` | A Bash script that creates links from the user's profile to the corresponding item in this repository | n/a |
| `installApps.sh` | A Bash script that detects installed Mac applications and suggests the user to install any suggested apps that are not already installed | n/a |
| `.gitignore` | Tells Git which files to ignore in this repository if they're changed | n/a |
