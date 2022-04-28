# macOS Personal Profile Dotfiles

This project contains all of the configuration files I use for all of my macOS
computers. When these files are linked to their appropriate places (using the
`configure.sh` install script), my standard settings will be set up on that
computer. These settings include important environment variables, terminal
aliases, and scripts.


## Installation

To install this project, run the following commands:

```
git clone https://github.com/garrettheath4/dotfiles-mac.git ~/dotfiles
cd ~/dotfiles
git submodule init && git submodule update
./configure.sh
./installApps.sh  # optional
```


## mVim

`mvim` is a Bash script I created that launches a "mini Vim" window for quickly
taking notes or temporarily pasting and manipulating text from the clipboard.


### BetterTouchTool Shortcut

To make it easy to run this script, use BetterTouchTool to create a global
keyboard shortcut (such as `Control`+`Option`+`Command`+`V`) that launches this
script when the shortcut is pressed.


## Moom

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


## Repository Contents

| Repository Item                | Description                                                                                                                              | Linking by `configure.sh`                                         |
| ---------------                | -----------                                                                                                                              | -------------------------                                         |
| `configure.sh`                 | A Bash script that creates links from the user's profile to the corresponding item in this repository (run once after cloning this repo) | self (run `configure.sh` once to create the links below)          |
| `installApps.sh`               | A Bash script that detects installed Mac applications and suggests the user to install any suggested apps that are not already installed | none (run `installApps.sh` once to install suggested apps)        |
| `Todoist-Tasks-macOS.csv`      | CSV file of tasks to set up a new macOS computer that can be imported into [Todoist](https://todoist.com/) _(Must be new project.)_      | none (import into Todoist to create tasks for setting up macOS)   |
| `Todoist-Tasks-Apps.csv`       | CSV file of tasks to configure apps on a new computer that can be imported into [Todoist](https://todoist.com/) _(Must be new project.)_ | none (import into Todoist to create tasks for configuring apps)   |
| `.bash_profile`                | Contains user Bash settings (runs every time the user opens up a Terminal window)                                                        | `~/.bash_profile` --> `dotfiles-mac/.bash_profile`                |
| `.tmux.conf`                   | Contains Tmux configuration settings (Tmux is launched by `.bash_profile` every time the iTerm2 Hotkey window is opened)                 | `~/.tmux.conf` --> `dotfiles-mac/.tmux.conf`                      |
| `.tmux-osx.conf`               | Contains Tmux configuration settings that are specific to an OS X environment (mostly just UI configuration)                             | `~/.tmux-osx.conf` --> `dotfiles-mac/.tmux-osx.conf`              |
| `.git-completion.bash`         | Allows tab-completion of Git commands in Bash                                                                                            | `~/.git-completion.bash` --> `dotfiles-mac/.git-completion.bash`  |
| `bin/`                         | Contains Bash user scripts (mostly convenience scripts)                                                                                  | `~/bin` --> `dotfiles-mac/bin/`                                   |
| `sbin/`                        | Contains Bash administrative scripts (mostly scripts containing `sudo`)                                                                  | `~/sbin` --> `dotfiles-mac/sbin/`                                 |
| `.vimrc`                       | Contains Vim startup settings                                                                                                            | `~/.vimrc` --> `dotfiles-mac/.vimrc`                              |
| `.vim/`                        | Contains Vim plugins (mostly just the Vundle plugin manager for Vim stored as a Git submodule at `.vim/bundle/Vundle.vim`)               | `~/.vim` --> `dotfiles-mac/.vim/`                                 |
| `.idlerc/`                     | Contains Python IDLE settings                                                                                                            | `~/.idlerc` --> `dotfiles-mac/.idlerc/`                           |
| `.ideavimrc`                   | Vim emulator configuration settings for IntelliJ IDEA when Vim-like edit mode is enabled                                                 | `~/.ideavimrc` --> `dotfiles-mac/.ideavimrc`                      |
| `git-pre-commit-show-todos.sh` | Git pre-commit script that searches for and shows any TODO items in a repo's files before commits (must be manually installed per repo)  | none                                                              |
| `Fractals-2560x1600/`          | HD wallpaper images from [Beautiful Fractals](http://www.beautifulfractals.com/ "Beautiful Fractals - Fractal Wallpapers")               | none                                                              |
| `BetterTouchTool/`             | Backup of the default profile settings from the BetterTouchTool app                                                                      | none                                                              |
| `Moom/`                        | Scripts that use the Moom app to rearrange windows to their desired locations on one or more screens                                     | none                                                              |
| `BitBarScripts/`               | Scripts used by the BitBar app to display script results in the OS X menubar                                                             | none                                                              |
| `iTerm/`                       | Backup location for iTerm2 preferences folder _(Note: Set iTerm2 to load preferences from `~/dotfiles/iTerm`)_                           | none                                                              |
| `Sounds/`                      | Contains user sound files                                                                                                                | none                                                              |
| `README.md`                    | This README file                                                                                                                         | none                                                              |
| `.gitignore`                   | Tells Git which files to ignore in this repository if they're changed                                                                    | none                                                              |
| `.gitmodules`                  | Tells Git that there is a Git submodule in this repo (at `.vim/bundle/Vundle.vim`) that needs to be checked out with this repository     | `git submodule init && git submodule update`                      |


### Terminal Initialization

1. Entrypoint (Bash=`~/.bash_profile` and Zsh=`~/.zprofile`)
   1. Exit if non-interactive (if `i` not in `$-`)
   1. Source `~/.ghk_profile` if exists (see below)
1. Source `~/.ghk_profile` (main shell-agnostic script)
   1. `brew shellenv`
   1. Ensure `<brew>/bin` in PATH
   1. Is `gdate` installed?
   1. Start printing SSH key fingerprint
   1. Ensure `~/bin` and `~/sbin` in PATH
   1. Ensure Homebrew Ruby in PATH (silent)
   1. Set BROWSER=open
   1. Start Tmux if in iTerm Hotkey window
   1. Source `~/.ghk_profile.local` if exists
   1. Set VISUAL=vim EDITOR=vim
   1. Set user aliases
   1. Ensure user Python packages in PATH
   1. Enable Tmux wrappers for `ssh` and `cd`
1. Continue `~/.zprofile` (Zsh only)
   1. Source `~/.zprofile.local` if exists
   1. **TODO:** Colorize `PS1` Z Shell prompt environment variable
   1. **TODO:** Initialize _oh-my-zsh_
1. Continue `~/.bash_profile` (Bash only)
   1. Source `~/.bash_profile.local` if exists
   1. Initialize _oh-my-git_
   1. Enable read-alias (for `which` to identify aliases too)
   1. Source `~/.git-completion.bash` if exists
   1. Source Homebrew Bash Completion if installed
   1. Source Vagrant Bash Completion if installed
   1. Colorize `PS1` Bash prompt environment variable


## Future Tasks

 * Merge [dotfiles-linux](https://github.com/garrettheath4/dotfiles-linux.git "GitHub garrettheath4/dotfiles-linux") repository into this repository.


<!-- vim: set textwidth=120 tabstop=4 shiftwidth=4 smarttab softtabstop=4 shiftround expandtab autoindent smartindent: -->
