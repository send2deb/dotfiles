#!/bin/sh
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# Author: Debashis Paul																													                                                         #
# Descriptions: This shell installs/updates Mac appstore applications.The applications are mentioned in ~/.dotfiles/macos/Brew           #
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# Change log 																															                                                               #
# <dd-mmm-yyyy: Reason>																													                                                         #
# 25-Mar-2018: Initial version.																 											                                                     #
#																																		                                                                     #
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# Install the Mac appstore applications listed in ~/.dotfiles/macos/Brewfile file
# 'brew bundle' is used to install the applications from Brewfile (refer https://github.com/Homebrew/homebrew-bundle)
# Check if it's running in interactive mode, if yes then allow user to bypass this setup.
echo
info ">>>>>>>>>>>>>> '8 -> Install / update MacOs Appstore applications' <<<<<<<<<<<<<<"
if [ $run_mode = $run_mode_interactive ]; then
  	debdroid "You are running this with interactive mode. I'm going to install/update Mac Appstore Applications next for you."
    warning "It will install/update all the Mac Appstore Applications present in $HOME/.dotfiles/brew/Brewfile. Please edit this file to add / remove items before proceeding."
  	action "Do you want to continue with the Mac Appstore Applications install/update (enter 'y' to proceed or enter 'n' to bypass) [y|N]?"
  	read -r user_choice
  	if [[ $user_choice =~ ^(y|yes|Y) ]];then
    	echo
      warning "You may be asked to login to your Apple account!"
    	continue
  	else
    	info "Skipped Mac Appstore Applications install/update."
    	return $user_bypassed_the_step
  	fi
fi

executing "Installing Mac Appstore Applications"
brew bundle --file="~/.dotfiles/macos/Brewfile"
completed "Successfully installed Mac Appstore Applications"
# Cleanup
executing "Cleaning up space"
brew cask cleanup
completed "Completed space cleaning up"