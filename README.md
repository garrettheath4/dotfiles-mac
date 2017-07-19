OS X Personal Profile Dotfiles
================================

This project contains all of the configuration files I use for all of my Mac OS
X computers. When these files are linked to their appropriate places (using the
`configure.sh` install script), my standard settings will be set up on that
computer. These settings include important environment variables, terminal
aliases, and scripts.

Installation
------------
To install this project, run the following commands:

```
git clone https://github.com/garrettheath4/dotfiles-mac.git ~/dotfiles
cd ~/dotfiles
git submodule init && git submodule update
./configure.sh
./installApps.sh  # optional
```

mVim
----
`mvim` is a Bash script I created that launches a "mini Vim" window for quickly
taking notes or temporarily pasting and manipulating text from the clipboard.

### BetterTouchTool Shortcut
To make it wasy to run this script, use BetterTouchTool to create a global
keyboard shortcut (such as `Control`+`Option`+`Command`+`V`) that launches this
script when the shortcut is pressed.

Moom
----
Use the [`ArrangeDualScreenWindows.scpt`](Moom/ArrangeDualScreenWindows.scpt)
AppleScript script to resize the apps I like to put on the MacBook screen
desktops when I have an external monitor attached (Spotify, Airmail 2,
Calendar, and Todoist).

To use this script, make sure "When switching to an application, switch to a
Space with open windows for the application" is checked in the Mission Control
preference pane.

### BetterTouchTool Shortcut
To make it easy to activate this script, use BetterTouchTool to create a global
keyboard shortcut (such as `Control`+`Shift`+`2`) that runs this script when
the shortcut is pressed.

Repository Contents
-------------------

| Repository Item                  | Description                                                                                                                              | Linking by `configure.sh`                                         |
| ---------------                  | -----------                                                                                                                              | -------------------------                                         |
| `configure.sh`                   | A Bash script that creates links from the user's profile to the corresponding item in this repository (run once after cloning this repo) | self (run `configure.sh` once to create the links below)          |
| `installApps.sh`                 | A Bash script that detects installed Mac applications and suggests the user to install any suggested apps that are not already installed | none (run `installApps.sh` once to install suggested apps)        |
| `ComputerSetupTasks-Todoist.csv` | CSV file of tasks to set up a new computer that can be imported into [Todoist](https://todoist.com/)                                     | none (use with Todoist to create tasks for setting up a computer) |
| `_.bash_profile`                 | Contains user Bash settings (runs every time the user opens up a Terminal window)                                                        | `~/.bash_profile` --> `dotfiles-mac/_.bash_profile`               |
| `_.tmux.conf`                    | Contains Tmux configuration settings (Tmux is launched by `.bash_profile` every time the iTerm2 Hotkey window is opened)                 | `~/.tmux.conf` --> `dotfiles-mac/_.tmux.conf`                     |
| `_.tmux-osx.conf`                | Contains Tmux configuration settings that are specific to an OS X environment (mostly just UI configuration)                             | `~/.tmux-osx.conf` --> `dotfiles-mac/_.tmux-osx.conf`             |
| `_.git-completion.bash`          | Allows tab-completion of Git commands in Bash                                                                                            | `~/.git-completion.bash` --> `dotfiles-mac/_.git-completion.bash` |
| `bin/`                           | Contains Bash user scripts (mostly convenience scripts)                                                                                  | `~/bin` --> `dotfiles-mac/bin/`                                   |
| `sbin/`                          | Contains Bash administrative scripts (mostly scripts containing `sudo`)                                                                  | `~/sbin` --> `dotfiles-mac/sbin/`                                 |
| `_.vimrc`                        | Contains Vim startup settings                                                                                                            | `~/.vimrc` --> `dotfiles-mac/_.vimrc`                             |
| `_.vim/`                         | Contains Vim plugins (mostly just the Vundle plugin manager for Vim stored as a Git submodule at `_.vim/bundle/Vundle.vim`)              | `~/.vim` --> `dotfiles-mac/_.vim/`                                |
| `_.idlerc/`                      | Contains Python IDLE settings                                                                                                            | `~/.idlerc` --> `dotfiles-mac/_.idlerc/`                          |
| `_.ideavimrc`                    | Vim emulator configuration settings for IntelliJ IDEA when Vim-like edit mode is enabled                                                 | `~/.ideavimrc` --> `dotfiles-mac/_.ideavimrc`                     |
| `git-pre-commit-show-todos.sh`   | Git pre-commit script that searches for and shows any TODO items in a repo's files before commits (must be manually installed per repo)  | none                                                              |
| `Fractals-2560x1600/`            | HD wallpaper images from [Beautiful Wallpapers](http://www.beautifulfractals.com/ "Beautiful Fractals - Fractal Wallpapers")             | none                                                              |
| `BitBarScripts/`                 | Scripts used by the BitBar app to display script results in the OS X menubar                                                             | none                                                              |
| `BetterTouchTool/`               | Backup of the default profile settings from the BetterTouchTool app                                                                      | none                                                              |
| `Moom/`                          | Scripts that use the Moom app to rearrange windows to their desired locations on one or more screens                                     | none                                                              |
| `Sounds/`                        | Contains user sound files                                                                                                                | none                                                              |
| `README.md`                      | This README file                                                                                                                         | none                                                              |
| `.gitignore`                     | Tells Git which files to ignore in this repository if they're changed                                                                    | none                                                              |
| `.gitmodules`                    | Tells Git that there is a Git submodule in this repo (at `_.vim/bundle/Vundle.vim`) that needs to be checked out with this repository    | `git submodule init && git submodule update`                      |

Future Tasks
------------
 * Merge [dotfiles-linux](https://github.com/garrettheath4/dotfiles-linux.git "GitHub garrettheath4/dotfiles-linux") repository into this repository.
