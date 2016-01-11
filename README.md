# OS X Personal Profile Dotfiles
This project contains all of the configuration files I use for all of my Mac-based logins.  When these files are moved to their appropriate places (where applicable), my standard scripts and settings will be set on that computer, such as important environment variables, terminal aliases, and scripts.

## Installation
To install this project:

    git clone https://github.com/garrettheath4/dotfiles-mac.git ~/dotfiles
    cd ~/dotfiles
    ./configure.sh
    ./installApps.sh

## Repository Contents

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
| `MailActOn/`          | Contains settings and rules for [Indev ActOn](https://www.indev.ca/MailActOn.html "MailActOn") addon for Apple Mail                      | `~/Library/Mail/Bundles/MailActOn.mailbundle/Contents/MacOS` --> `dotfiles-mac/MailActOn/` |
| `Fractals-2560x1600/` | HD wallpaper images from [Beautiful Wallpapers](http://www.beautifulfractals.com/ "Beautiful Fractals - Fractal Wallpapers")             | n/a                                                                                        |
| `Sounds/`             | Contains user sound files                                                                                                                | n/a                                                                                        |
| `README.md`           | This readme file                                                                                                                         | n/a                                                                                        |
| `configure.sh`        | A Bash script that creates links from the user's profile to the corresponding item in this repository                                    | n/a                                                                                        |
| `installApps.sh`      | A Bash script that detects installed Mac applications and suggests the user to install any suggested apps that are not already installed | n/a                                                                                        |
| `.gitignore`          | Tells Git which files to ignore in this repository if they're changed                                                                    | n/a                                                                                        |

## Future Tasks
 * Merge [dotfiles-linux](https://github.com/garrettheath4/dotfiles-linux.git "GitHub garrettheath4/dotfiles-linux") repository into this repository.
