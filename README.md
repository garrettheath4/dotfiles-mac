OS X Personal Profile Dotfiles
================================

This project contains all of the configuration files I use for all of my Mac-based logins.  When these files are moved to their appropriate places (where applicable), my standard scripts and settings will be set on that computer, such as important environment variables, terminal aliases, and scripts.

Installation
------------
To install this project:

```
git clone https://github.com/garrettheath4/dotfiles-mac.git ~/dotfiles
cd ~/dotfiles
./configure.sh
./installApps.sh
```

mVim
----
`mvim` is a Bash script I created that launches a "mini Vim" window for quickly taking notes or temporarily pasting and manipulating text from the clipboard.

### BetterTouchTool Shortcut
To make it wasy to run this script, use BetterTouchTool to create a global keyboard shortcut (such as `Control`+`Option`+`Command`+`V`) that launches this script when the shortcut is pressed.

Moom
----
Use the [`ArrangeDualScreenWindows.scpt`](Moom/ArrangeDualScreenWindows.scpt) AppleScript script to resize the apps I like to put on the MacBook screen desktops when I have an external monitor attached (Spotify, Airmail 2, Calendar, and Todoist).

To use this script, make sure "When switching to an application, switch to a Space with open windows for the application" is checked in the Mission Control preference pane.

### BetterTouchTool Shortcut
To make it easy to activate this script, use BetterTouchTool to create a global keyboard shortcut (such as `Control`+`Shift`+`2`) that runs this script when the shortcut is pressed.

Repository Contents
-------------------

| Repository Item       | Description                                                                                                                              | Linking by `configure.sh`                                                                  |
| ---------------       | -----------                                                                                                                              | -------------------------                                                                  |
| `bin/`                | Contains Bash user scripts (mostly convenience scripts)                                                                                  | `~/bin` --> `dotfiles-mac/bin/`                                                            |
| `sbin/`               | Contains Bash administrative scripts (mostly scripts containing `sudo`)                                                                  | `~/sbin` --> `dotfiles-mac/sbin/`                                                          |
| `_.bash_profile`      | Contains user Bash settings                                                                                                              | `~/.bash_profile` --> `dotfiles-mac/_.bash_profile`                                        |
| `_.vim/`              | Contains Vim plugins                                                                                                                     | `~/.vim` --> `dotfiles-mac/_.vim/`                                                         |
| `_.vimrc`             | Contains Vim settings                                                                                                                    | `~/.vimrc` --> `dotfiles-mac/_.vimrc`                                                      |
| `_.gitconfig`         | Contains Git configuration settings                                                                                                      | `~/.gitconfig` --> `dotfiles-mac/_.gitconfig`                                              |
| `_.idlerc/`           | Contains Python IDLE settings                                                                                                            | `~/.idlerc` --> `dotfiles-mac/_.idlerc/`                                                   |
| `GrowlStyles/`        | Contains theme styles for the [Growl notification application](http://growl.info/ "Growl")                                               | `~/Library/Application Support/Growl/Plugins/` \<== `dotfiles-mac/GrowlStyles/*` (copied)  |
| `Fractals-2560x1600/` | HD wallpaper images from [Beautiful Wallpapers](http://www.beautifulfractals.com/ "Beautiful Fractals - Fractal Wallpapers")             | n/a                                                                                        |
| `Sounds/`             | Contains user sound files                                                                                                                | n/a                                                                                        |
| `README.md`           | This readme file                                                                                                                         | n/a                                                                                        |
| `configure.sh`        | A Bash script that creates links from the user's profile to the corresponding item in this repository                                    | n/a                                                                                        |
| `installApps.sh`      | A Bash script that detects installed Mac applications and suggests the user to install any suggested apps that are not already installed | n/a                                                                                        |
| `.gitignore`          | Tells Git which files to ignore in this repository if they're changed                                                                    | n/a                                                                                        |

Future Tasks
------------
 * Merge [dotfiles-linux](https://github.com/garrettheath4/dotfiles-linux.git "GitHub garrettheath4/dotfiles-linux") repository into this repository.
