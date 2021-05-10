#!/usr/bin/env bash
# Script to install major programs and Applications on a Mac account.
# Most things in this script (unless they're very minor) should run with
# a prompted confirmation from the user to install each item.

REPO="$(pwd)"

# Variable: Has the spreadsheet with the list of licenses been opened yet?
#   Values: 'YES' or 'NO'
licensePage='https://docs.google.com/spreadsheets/d/14pl7ljKn8bf8rZZgHrU56zbQFePMpGCLUH0U3UQRTVI/edit#gid=0'
openedLicenses='NO'


#
# HELPER FUNCTIONS  {{{1
#

CommandExists () {
    command -v "$1" >/dev/null 2>&1
}

CommandDoesNotExist () {
    ! CommandExists "$1"
}


ShowLicenses () {
    if [ "$openedLicenses" == 'NO' ]; then
        open "$licensePage"
        openedLicenses='YES'
    fi
}

ShouldInstall () {
    if [ "$#" -lt 1 ] || [ -z "$1" ]; then
        echo 'Usage: ShouldInstall <PrettyAppName>'
        echo 'Returns: 0 for YES or 1 for NO'
        exit 38
    fi
    read -r -p "Install $1 now? (y/n) [y]: " confirminstall
    [ "$confirminstall" != 'n' ]
}

ShouldInstallCmdIfNew () {
    if [ "$#" -lt 1 ] || [ -z "$1" ]; then
        echo 'Usage: ShouldInstallCmdIfNew [DescriptionString] <TerminalCommandName>'
        echo 'Returns: 0 for YES or 1 for NO'
        exit 48
    fi
    cmdDescription="$1"
    cmdName="${cmdDescription// /-}"
    if [ "$#" -ge 2 ]; then
        cmdName="$2"
    fi
    if CommandDoesNotExist "$cmdName"; then
        ShouldInstall "$cmdDescription"
    else
        # Return NO because it's already installed
        return 1
    fi
}

ShouldInstallAppIfNew () {
    if [ "$#" -lt 1 ] || [ -z "$1" ]; then
        echo 'Usage: ShouldInstallAppIfNew [DescriptionString] <InstalledAppName>'
        echo 'Returns: 0 for YES or 1 for NO'
        exit 62
    fi
    appDescription="$1"
    appName="$appDescription"
    if [ "$#" -ge 2 ]; then
        appName="$2"
    fi
    if [[ ! -d "/Applications/$appName.app" && ! -e /"$appName" ]]; then
        ShouldInstall "$1"
    else
        # Return NO because it's already installed
        return 1
    fi
}

ConfirmInstallBrewPackage () {
    if [ "$#" -lt 1 ] || [ -z "$1" ]; then
        echo 'Usage: ConfirmInstallBrewCask [CmdToCheck] <PackageToInstall>'
        exit 75
    fi
    cmdToCheck="$1"
    packageToInstall="${cmdToCheck// /-}"
    if [ "$#" -ge 2 ]; then
        packageToInstall="$2"
    fi
    if ShouldInstallCmdIfNew "$cmdToCheck"; then
        brew install "$packageToInstall"
    fi
}

ConfirmInstallBrewCask () {
    if [ "$#" -lt 1 ] || [ -z "$1" ]; then
        echo 'Usage: ConfirmInstallBrewCask [AppToCheck] <CaskToInstall>'
        exit 75
    fi
    appToCheck="$1"
    caskToInstall="${appToCheck// /-}"
    if [ "$#" -ge 2 ]; then
        caskToInstall="$2"
    fi
    if ShouldInstallAppIfNew "$appToCheck"; then
        brew install --cask "$caskToInstall"
    fi
}

OpenLinkAndWait () {
    if [ "$#" -lt 1 ] || [ -z "$1" ]; then
        echo "Usage: OpenLinkAndWait <AppNameToDisplay> [LinkToOpen]"
        echo "Example: OpenLinkAndWait Evernote 'macappstore://apps.apple.com/us/app/evernote-stay-organized/id406056744?mt=12'"
        exit 91
    fi
    appName="$1"
    linkToOpen="$2"
    if [ -n "$linkToOpen" ]; then
        open "$linkToOpen"
    fi
    read -r -p "Press Enter after $appName is installed to continue..."
}

ConfirmInstallLinkAndWait () {
    if [ "$#" -lt 1 ] || [ -z "$1" ]; then
        echo "Usage: ConfirmInstallLinkAndWait <AppNameToCheck> [LinkToOpen]"
        echo "Example: ConfirmInstallLinkAndWait Evernote 'macappstore://apps.apple.com/us/app/evernote-stay-organized/id406056744?mt=12'"
        exit 125
    fi
    appName="$1"
    linkToOpen="$appName"
    if [ "$#" -ge 2 ]; then
        linkToOpen="$2"
    fi
    if ShouldInstallAppIfNew "$appName"; then
        OpenLinkAndWait "$appName" "$linkToOpen"
    fi
}

# End helper functions  }}}1


#
# BASIC FILE INSTALLS (fractals)  {{{1
#

# Add fractals to Pictures folder  {{{2
if ShouldInstallAppIfNew 'fractals to Pictures folder' ~/Pictures/Fractals-2560x1600; then
    ln -is "$REPO/Fractals-2560x1600" ~/Pictures/
fi
# End fractals  }}}2

# End basic file installs  }}}1


#
# INITIAL INSTALLS (Git and Homebrew)  {{{1
#

# Git (needed first to install Homebrew and its apps in this script)  {{{2
if CommandDoesNotExist git && ShouldInstall "git (and other developer command line tools)"; then
    xcode-select --install
    # macOS should prompt you to install the Developer Tools which includes Git
    # OpenLinkAndWait is just a fancy way to wait for the GUI installation
    #   to finish before the user presses Enter to continue this script
    OpenLinkAndWait 'Git'
fi

if CommandDoesNotExist git; then
    echo 'Warning: It appears that Git was not installed. You may need to install it yourself.'
    exit 1
else
    git --version
fi
# End Git  }}}2


# Homebrew (needed to install other tools and apps in this script)  {{{2
if CommandDoesNotExist brew && ShouldInstall "Homebrew"; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    brew --version
fi

if CommandDoesNotExist brew; then
    echo 'Warning: It appears that Homebrew was not installed. You may need to install it yourself.'
    exit 2
fi

brew update
# End Homebrew  }}}2

# End Initial Installs  }}}1


#
# GOOGLE CHROME (install before opening web pages in this script)  {{{1
#

ConfirmInstallBrewCask 'Google Chrome'

# End Google Chrome  }}}1


#
# TOOLS  {{{1
#

# LastPass extensions  {{{2
lastPassInstallerApp='/usr/local/Caskroom/lastpass/latest/LastPass Installer.app'
if ShouldInstallAppIfNew 'LastPass Universal Mac Installer' "$lastPassInstallerApp"; then
    brew install --cask lastpass
    OpenLinkAndWait 'LastPass' "$lastPassInstallerApp"
fi
# End LastPass extensions  }}}2

ConfirmInstallBrewPackage tmux
ConfirmInstallBrewPackage ag

CommandExists tmux && ConfirmInstallBrewPackage reattach-to-user-namespace

if ShouldInstallAppIfNew 'iTerm'; then  # {{{2
    iTermPrefsFilename='com.googlecode.iterm2.plist'
    # Initialize iTerm with stored preferences if not already in local Library
    if [ ! -e ~/Library/Preferences/"$iTermPrefsFilename" ] && [ -e "$iTermPrefsFilename" ]; then
        cp "$iTermPrefsFilename" ~/Library/Preferences/"$iTermPrefsFilename"
    fi
    brew install --cask iterm2
fi  # }}}2

# End tools  }}}1


#
# BACKGROUND UTILITIES  {{{1
#

ConfirmInstallBrewCask 'Moom'
ConfirmInstallBrewCask 'BetterTouchTool'
ConfirmInstallBrewCask 'Insync'
ConfirmInstallBrewCask 'Alfred 4' 'alfred'
ConfirmInstallBrewCask 'Bartender'
ConfirmInstallBrewCask 'Toggl Track'
ConfirmInstallBrewCask 'Tunnelblick'
ConfirmInstallBrewCask 'KeepingYouAwake'
ConfirmInstallBrewCask 'TG Pro'
ConfirmInstallBrewCask 'BitBar'
ConfirmInstallBrewCask 'AirServer'

ConfirmInstallLinkAndWait '1Keyboard' 'macappstore://apps.apple.com/us/app/1keyboard/id766939888?mt=12'

if ShouldInstallAppIfNew 'Quick Calendar'; then  # {{{2
    OpenLinkAndWait 'Quick Calendar (app download) ' 'macappstore://apps.apple.com/us/app/quick-calendar/id1004514425?mt=12'
    OpenLinkAndWait 'Quick Calendar (post-download)' '/Applications/Quick Calendar.app'
fi  # }}}2

# End background utilities  }}}1


#
# APPS  {{{1
#

ConfirmInstallBrewCask 'MacVim'
ConfirmInstallBrewCask 'MacDown'
ConfirmInstallBrewCask 'BackupLoupe'

ConfirmInstallLinkAndWait 'Todoist' 'macappstore://apps.apple.com/us/app/todoist-to-do-list-task-list/id585829637?mt=12'
ConfirmInstallLinkAndWait 'Messenger' 'macappstore://apps.apple.com/us/app/messenger/id1480068668?mt=12'
ConfirmInstallLinkAndWait 'Evernote' 'macappstore://apps.apple.com/us/app/evernote-stay-organized/id406056744?mt=12'
ConfirmInstallLinkAndWait 'Deliveries' 'macappstore://apps.apple.com/us/app/deliveries-a-package-tracker/id290986013?mt=12'
ConfirmInstallLinkAndWait 'Drafts' 'macappstore://apps.apple.com/us/app/drafts/id1435957248?mt=12'

# End apps  }}}1


#
# MEDIA APPS  {{{1
#

ConfirmInstallBrewCask 'Spotify'
ConfirmInstallBrewCask 'GIMP-2.10' 'gimp'
ConfirmInstallBrewCask 'VLC'
ConfirmInstallBrewCask '4K Video Downloader'

if ShouldInstallAppIfNew 'Sonos'; then  # {{{2
    brew tap caskroom/drivers
    brew install --cask sonos
fi  # }}}2

# End media apps  }}}1


#
# DEVELOPER TOOLS  {{{1
#

ConfirmInstallBrewCask 'JetBrains Toolbox'
ConfirmInstallBrewCask 'balenaEtcher'
ConfirmInstallBrewCask 'TeXShop'

# End developer tools  }}}1


#
# GAMES  {{{1
#

ConfirmInstallBrewCask 'Steam'
ConfirmInstallBrewCask 'Minecraft'

# End games  }}}1



# vim: set tabstop=4 shiftwidth=4 smarttab shiftround expandtab autoindent smartindent copyindent preserveindent foldmethod=marker:
