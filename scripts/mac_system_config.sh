#!/bin/sh
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# Author: Debashis Paul																													                                                         #
# Descriptions: This shell script updates Mac system configuration  																					                           #
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# Change log 																															                                                               #
# <dd-mmm-yyyy: Reason>																													                                                         #
# 25-Mar-2018: Initial version.																 											                                                     #
#																																		                                                                     #
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

# Check if it's running in interactive mode, if yes then allow user to bypass this setup.
echo
info ">>>>>>>>>>>>>> '9 -> Update Mac system configuration' <<<<<<<<<<<<<<"
if [ $run_mode = $run_mode_interactive ]; then
  debdroid "You are running this with interactive mode. I'm going to update some Mac system configuration next for you."
  action "Do you want to continue with the Mac system configuration update (enter 'y' to proceed or enter 'n' to bypass) [y|N]?"
  read -r user_choice
  if [[ $user_choice =~ ^(y|yes|Y) ]];then
    echo
    continue
  else
    info "Skipped Mac system configuration update."
    return $user_bypassed_the_step
  fi
fi

debdroid "Every user has own choice for Mac system configuration. Please check what configuration I'm going to set, verify everything in $HOME/.dotfiles/scripts/mac_system_config.sh."
warning "Some of these configuration changes need sudo access. You will be asked for the password!"
action "Do you want to continue (enter 'y' to proceed or enter 'n' to bypass) [y|N]?"
read -r response
if [[ $response =~ ^(y|yes|Y) ]];then
  echo
  continue
else
    info "No problem! You continue to use your own Mac system configuration."
    return 1
fi

# Following system configuration changes are done. Please add / update as per your need
# References -  https://github.com/atomantic/dotfiles/blob/master/install.sh
#               https://www.cisecurity.org/cis-benchmarks/
#               https://github.com/drduh/macOS-Security-and-Privacy-Guide
#               https://github.com/mathiasbynens/dotfiles/blob/master/.macos

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
executing "Closing any system preferences to prevent issues with automated changes"
osascript -e 'tell application "System Preferences" to quit'

#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
#     Install Updates, Patches and Additional Security Software                                                                          #
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
executing "Enable auto update"
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticCheckEnabled -int 1

executing "Enable app update install"
sudo defaults write /Library/Preferences/com.apple.commerce AutoUpdate -bool TRUE

executing "Enable system data files and security update installs"
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate ConfigDataInstall -bool true && sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate CriticalUpdateInstall -bool true

executing "Enable OS X update installs"
sudo defaults write /Library/Preferences/com.apple.commerce AutoUpdateRestartRequired -bool TRUE

#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
#     System Preferences                                                                                                                 #
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
executing "Turn off Bluetooth, if no paired devices exist"
sudo defaults write /Library/Preferences/com.apple.Bluetooth \ ControllerPowerState -int 0

executing "Show Bluetooth status in menu bar"
defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/Bluetooth.menu"

executing "Disable remote apple events"
sudo systemsetup -setremoteappleevents off

executing "Disable remote login"
sudo systemsetup -setremotelogin off

executing "Disable Wake for network access"
sudo pmset -a womp 0

executing "Enable Gatekeeper"
sudo spctl --master-enable

executing "Enable Firewall"
# Possible values:
#   0 = off
#   1 = on for specific sevices
#   2 = on for essential services
# use '/usr/libexec/ApplicationFirewall/socketfilterfw --listapps' to list apps allowed by firewall
sudo defaults write /Library/Preferences/com.apple.alf globalstate -int 1

executing "Enable Firewall Stealth Mode"
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on

executing "Enable Location Services"
sudo launchctl load /System/Library/LaunchDaemons/com.apple.locationd.plist

executing "Enable Secure Keyboard Entry in Terminal app"
defaults write com.apple.terminal SecureKeyboardEntry -bool true

executing "Disable wake-on modem"
sudo systemsetup -setwakeonmodem off

executing "Disable wake-on LAN"
sudo systemsetup -setwakeonnetworkaccess off

#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
#     System Access, Authentication and Authorization                                                                                    #
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
executing "Require a password to wake the computer from sleep or screen saver"
defaults write com.apple.screensaver askForPassword -int 1

executing "Set a custom message for login screen"
# Use 'sudo defaults delete /Library/Preferences/com.apple.loginwindow LoginwindowText' to delete it.
sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "Hello Debashis! Logon to your MacbookPro."

#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
#     User Accounts and Environment                                                                                                      #
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
executing "Disable guest account login"
sudo defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool NO

executing "Turn on filename extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

executing "Show hidden files by default"
defaults write com.apple.finder AppleShowAllFiles -bool true

executing "Show the ~/Library folder"
chflags nohidden ~/Library

executing "allow 'locate' command"
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist > /dev/null 2>&1

executing "Disable the automatic run of safe files in Safari"
defaults write com.apple.Safari AutoOpenSafeDownloads -boolean no

#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
#     Generic Stuffs                                                                                                                     #
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
executing "Set highlight color to green"
defaults write NSGlobalDomain AppleHighlightColor -string "0.764700 0.976500 0.568600"

executing "Expand save panel by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

executing "Save to disk (not to iCloud) by default"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

executing "Reveal IP, hostname, OS, etc. when clicking clock in login window"
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

executing "Disable automatic termination of inactive apps"
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

executing "Disable the crash reporter"
defaults write com.apple.CrashReporter DialogType -string "none"

executing "Restart automatically if the computer freezes"
sudo systemsetup -setrestartfreeze on

executing "Disable smart quotes as they’re annoying when typing code"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

executing "Disable smart dashes as they’re annoying when typing code"
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

executing "Disable automatic capitalization as it’s annoying when typing code"
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

executing "Disable auto-correct"
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

executing "Keep folders on top when sorting by name"
defaults write com.apple.finder _FXSortFoldersFirst -bool true

executing "Automatically hide and show the Dock"
defaults write com.apple.dock autohide -bool true

executing "Make Dock icons of hidden applications translucent"
defaults write com.apple.dock showhidden -bool true

executing "always boot in verbose mode (not MacOS GUI mode)"
sudo nvram boot-args="-v"

# Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
executing "Top left screen corner → Mission Control"
defaults write com.apple.dock wvous-tl-corner -int 2
defaults write com.apple.dock wvous-tl-modifier -int 0
executing "Top right screen corner → Desktop"
defaults write com.apple.dock wvous-tr-corner -int 4
defaults write com.apple.dock wvous-tr-modifier -int 0
executing "Bottom left screen corner → Start screen saver"
defaults write com.apple.dock wvous-bl-corner -int 5
defaults write com.apple.dock wvous-bl-modifier -int 0

executing "Save screenshots to the desktop"
defaults write com.apple.screencapture location -string "${HOME}/Desktop"

executing "Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)"
defaults write com.apple.screencapture type -string "png"

#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
#     App specific                                                                                                                   #
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# Zipeg app found with the following permission (run the commend 'sudo find /Applications -iname "*\.app" -type d -perm -2 -ls'), so fix it
# drwxrwxrwx
sudo chmod -R o-w /Applications/Zipeg.app

# Show completion message
completed "Completed 'Update Mac system configuration'."                                                  
debdroid "OK. Note that some of these changes require a logout/restart to take effect. A reboot is recommended...."

