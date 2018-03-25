#!/bin/sh
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# Author: Debashis Paul																													                                                         #
# Descriptions: This shell installs brew cask packages (i.e. Mac applications). The brew formulas are mentioned 						             #
#               inside the ~/.dotfiles/brew_cask/Brewfile.    																			                                     #
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# Change log 																															                                                               #
# <dd-mmm-yyyy: Reason>																													                                                         #
# 18-Mar-2018: Initial version.																 											                                                     #
#																																		                                                                     #
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# Install the brew cask packages listed in ~/.dotfiles/brew_cask/Brewfile file
# 'brew bundle' is used to install the packages from Brewfile (refer https://github.com/Homebrew/homebrew-bundle)
# Check if it's running in interactive mode, if yes then allow user to bypass this setup.
echo
info ">>>>>>>>>>>>>> '3 -> Homebrew cask packages (i.e. Mac App)  install' <<<<<<<<<<<<<<"
if [ $run_mode = $run_mode_interactive ]; then
  	debdroid "You are running this with interactive mode. I'm going to install the brew cask packages (i.e. Mac applications) next for you."
    warning "It will install all the cask packages present in $HOME/.dotfiles/brew_cask/Brewfile. Please edit this file to add / remove items before proceeding."
  	action "Do you want to continue with the brew cask installation (enter 'y' to proceed or enter 'n' to bypass) [y|N]?"
  	read -r user_choice
  	if [[ $user_choice =~ ^(y|yes|Y) ]];then
    	echo
    	continue
  	else
    	info "Skipped brew cask package installs."
    	return $user_bypassed_the_step
  	fi
fi

executing "Installing brew cask packages (i.e. Mac applications)"
brew bundle --file="~/.dotfiles/brew_cask/Brewfile"
completed "Successfully installed brew cask packages"
# Cleanup
executing "Cleaning up space"
brew cask cleanup
completed "Completed space cleaning up"