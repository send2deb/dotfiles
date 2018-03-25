#!/bin/sh
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# Author: Debashis Paul																													                                                         #
# Descriptions: This shell installs core brew packages. The brew packages are inside the ~/.dotfiles/brew/Brewfile 					             #
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# Change log 																															                                                               #
# <dd-mmm-yyyy: Reason>																													                                                         #
# 18-Mar-2018: Initial version.																 											                                                     #
#																																		                                                                     #
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# Install the brew packages listed in ~/.dotfiles/brew/Brewfile file
# 'brew bundle' is used to install the packages from Brewfile (refer https://github.com/Homebrew/homebrew-bundle)
echo
if [ $run_mode = $run_mode_interactive ]; then
	debdroid "I'm going to install brew core packages next for you."
  warning "It will install all the core packages present in $HOME/.dotfiles/brew/Brewfile. Please edit this file to add / remove items before proceeding."
	action "Do you want to continue with the brew core package install (enter 'y' to proceed or enter 'n' to bypass) [y|N]?"
  	read -r user_choice
  	if [[ $user_choice =~ ^(y|yes|Y) ]];then
    	echo
    	continue
  	else
    	info "Skipped brew core package installs."
    	return $user_bypassed_the_step
  	fi
fi

executing "Installing brew core packages"
brew bundle --file="~/.dotfiles/brew/Brewfile"
completed "Successfully installed brew core packages"
# Cleanup
executing "Cleaning up space"
brew cleanup
completed "Completed space cleaning up"