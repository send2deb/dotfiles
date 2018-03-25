#!/bin/sh
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# Author: Debashis Paul																													                                                         #
# Descriptions: This shell installs homebrew for MacOs 																					                                         #
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# Change log 																															                                                               #
# <dd-mmm-yyyy: Reason>																													                                                         #
# 18-Mar-2018: Initial version.																 											                                                     #
#																																		                                                                     #
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

# Check if it's running in interactive mode, if yes then allow user to bypass this setup.
echo
info ">>>>>>>>>>>>>> '2 -> Homebrew setup and brew core packages install' <<<<<<<<<<<<<<"
if [ $run_mode = $run_mode_interactive ]; then
  debdroid "You are running this with interactive mode. I'm going to do the brew setup and brew core packages install next for you."
  action "Do you want to continue with the brew setup (enter 'y' to proceed or enter 'n' to bypass) [y|N]?"
  read -r user_choice
  if [[ $user_choice =~ ^(y|yes|Y) ]];then
    echo
    continue
  else
    info "Skipped brew setup and core brew packages install."
    return $user_bypassed_the_step
  fi
fi

# Check if brew is already installed. If not then install it otherwise update it. Also upgrade if user wants to upgrade installed packages.
executing "Checking homebrew install"
#brew_bin=$(which brew) 2>&1 > /dev/null
if test ! $(which brew); then
  info "Homebrew is not installed"
  # Check if we get a 200, if yes then we can safely assume that curl is going to be successful
  executing "Installing homebrew"
  warning "You will be asked for password!"
  resp="$(curl --silent --output /dev/null --write-out "%{http_code}" https://raw.githubusercontent.com/Homebrew/install/master/install)"
  echo "Response code: $resp"
  if [ $resp -eq 200 ]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    if [ $? -ne 0 ]; then
      error "Error installing homebrew"
      return 1
    fi
    # Ensure / Install all taps - will be needed for subsequent brew installs
    brew tap homebrew/core
    brew tap homebrew/bundle
    brew tap homebrew/services
    brew tap caskroom/fonts
    brew tap caskroom/versions
    brew tap caskroom/cask
    completed "Successfully installed homebrew"
  else
    error "Error installing homebrew, probable reason Internet connection problem."
    return 2
  fi
else
  info "Homebrew is installed. Found in $(which brew)"
  # Make sure we’re using the latest Homebrew
  executing "Updating homebrew"
  brew update
  # Ensure all taps are there - will be needed for subsequent brew installs
  brew tap homebrew/core
  brew tap homebrew/bundle
  brew tap homebrew/services
  brew tap caskroom/fonts
  brew tap caskroom/versions
  brew tap caskroom/cask
  completed "Successfully updated homebrew"
  debdroid "Before installing any new brew packages, I can upgrade any outdated packages."
  action "Run brew upgrade? [y|N]"
  read -r response
  if [[ $response =~ ^(y|yes|Y) ]];then
    executing "Upgrade brew packages"
    brew upgrade
    completed "Successfully upgraded brew packages"
  else
    info "Skipped brew package upgrades."
  fi
fi