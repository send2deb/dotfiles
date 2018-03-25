#!/bin/sh
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# Author: Debashis Paul																													 #
# Descriptions: This shell script installs the dotfiles and runs other scripts for system configuration.								 #
#               The purpose of this is to setup a new Mac system with all required software and configuration.							 #
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# Change log 																															 #
# <dd-mmm-yyyy: Reason>																													 #
# 25-Mar-2018: Initial version.																 											 #
#																																		 #
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

# First thing first - Load customize echo
if [ -f ~/.dotfiles/scripts/custom_echo.sh ]; then
	source ~/.dotfiles/scripts/custom_echo.sh
else
	echo "Script '$HOME/.dotfiles/scripts/custom_echo.sh' not found. It will not impact the install."
fi

# Declare variables
run_mode_interactive="interactive"
run_mode_non_interactive="non_interactive"
run_mode=null
# Name of the bot
bot="debdroid"
# Note: Return code 99 is reserved to use in other scripts to indicate user bypassed the step.
user_bypassed_the_step=99


# Show a welcome message
debdroid "Hello `whoami`! I'm [(._debdroid_.)], the bot! Thanks for allowing me to setup your new Mac system."
debdroid "Sit, relax and watch me setting up everything for you. Whenever I need something from you, I will stop and request."
debdroid "I'm going to setup the following for you:"
info "1 -> Bash setup"
info "2 -> Homebrew setup and core brew packages install"
info "3 -> Homebrew cask packages (i.e. Mac App)  install"
info "4 -> zsh and oh-my-zsh setup"
info "5 -> git configuration setup"
info "6 -> ssh configuration setup"
info "7 -> vim setup"
info "8 -> Install / update MacOs Appstore applications"
info "9 -> Update Mac system configuration"
echo

# Ask user for automated or interactieve run
debdroid "You can allow me to do everything automatically or you can choose to do it interactively where you will get a chance to bypass the step(s)."
action "Do you want to allow the bot [(._debdroid_.)] to run all the steps automatically (enter 'y' to run all or enter 'n' to run interactively [y|N]?"
read -r user_run_mode_response
if [[ $user_run_mode_response =~ ^(y|yes|Y) ]];then
	run_mode=$run_mode_non_interactive
	info "Running in automated mode"
	debdroid "Best option! But it's not fully automated, I will still need confirmations on certain things."	
else
	run_mode=$run_mode_interactive
	info "Running in interactive mode"
fi
echo

# Load utility functions
if [ -f ~/.dotfiles/scripts/utility_functions.sh ]; then
	source ~/.dotfiles/scripts/utility_functions.sh
else
	error "Script '$HOME/.dotfiles/scripts/utility_functions.sh' not found. Installation cannot continue without this file. Aborting..."
	exit 1
fi

# Call the utility function 'check_operating_system_type' to check operating system
check_operating_system_type

# Check the return code and take appropriate action
if [ $? -eq 0 ]; then
	# Bash setup
	source ~/.dotfiles/scripts/bash_setup.sh

	# Install Homebrew
	source ~/.dotfiles/scripts/brew_install_macos.sh
	brew_install_return_code=$?

	# Install brew packages
	if [[ $brew_install_return_code -eq 0 ]]; then
		# Install core brew packages
		source ~/.dotfiles/scripts/brew_core_package_install.sh
		# Install brew cask packages
		source ~/.dotfiles/scripts/brew_cask_package_install.sh
	else
		warning "Couldn't install brew, so will not be able to install any brew packages or Mac Appstore applications."
		echo
		warning "Skipped '3 -> Homebrew cask packages (i.e. Mac App)  install' becuase homebrew is not available / installed."
	fi
	
	# ZSH setup
	source ~/.dotfiles/scripts/zsh_setup.sh

	# git setup
	source ~/.dotfiles/scripts/git_config.sh

	# SSH setup
	source ~/.dotfiles/scripts/ssh_config.sh

	# vim setup
	source ~/.dotfiles/scripts/vim_setup.sh

	# Install macos packages
	if [[ $brew_install_return_code -eq 0 ]]; then
		# Install core brew packages
		source ~/.dotfiles/scripts/brew_mac_appstore_apps_install.sh
	else
		echo
		warning "Skipped '8 -> Install / update MacOs Appstore applications' becuase homebrew is not available / installed."
	fi

	# Configure mac defaults
	source ~/.dotfiles/scripts/mac_system_config.sh

	# Show a exit message
	echo
	debdroid "All done! `whoami`, did you like it? Enjoy your new Mac and have a nice day / evening..... [(._debdroid_.)], the bot!"
	echo
else
	error "This works for MacOs only and non-MacOs detected. Aborting..."
	debdroid "I can only handle MacOs at this moment! Sorry for not able to help you :("
	exit 1
fi

# Remove variables
unset run_mode_interactive
unset run_mode_non_interactieve
unset run_mode
unset bot
#- - - - - - -  - - - - - - - - - - - - - - - - - -   End of File   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -- - - - #

