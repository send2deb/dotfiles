#!/bin/sh
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# Author: Debashis Paul																													                                                         #
# Descriptions: This shell does the ssh configuration setup 																					                                   #
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# Change log 																															                                                               #
# <dd-mmm-yyyy: Reason>																													                                                         #
# 18-Mar-2018: Initial version.																 											                                                     #
#																																		                                                                     #
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

# Check if it's running in interactive mode, if yes then allow user to bypass this setup.
echo
info ">>>>>>>>>>>>>> '6 -> ssh configuration setup' <<<<<<<<<<<<<<"
if [ $run_mode = $run_mode_interactive ]; then
  debdroid "You are running this with interactive mode. I'm going to do the ssh configuration setup next for you."
  action "Do you want to continue with the ssh configuration setup (enter 'y' to proceed or enter 'n' to bypass) [y|N]?"
  read -r user_choice
  if [[ $user_choice =~ ^(y|yes|Y) ]];then
    echo
    continue
  else
    info "Skipped ssh configuration setup."
    return $user_bypassed_the_step
  fi
fi

debdroid "I have ssh configuration for multiple GitHub accouts and I maintain that in $HOME/.dotfiles/ssh_config/config file."
debdroid "ssh config file is user specific."
debdroid "If you have one and want me to maintain your ssh 'config' file then replace $HOME/.dotfiles/ssh_config/config with your $HOME/.ssh/config file."
debdroid "If you do not want me to maintain your $HOME/.ssh/config file then skip this step."
warning "You should replace my $HOME/.dotfiles/ssh_config/config file with your $HOME/.ssh/config before proceeding further, otherwise I will replace yours with mine."
action "Do you want to proceed to next step (enter 'y' to proceed or enter 'n' to  bypass this setup) [y|N]?"
read -r first_response
if [[ $first_response =~ ^(y|yes|Y) ]];then
  echo
  executing "Setting up ~/.ssh/config file"
  if [[ -f ~/.ssh/config ]]; then
    # Define the variables
    user_name=`whoami`
    date_time_stamp=$(date +"%Y-%m-%d_%H.%M.%S")

    # Take backup of .gitconfig and .gitignore_global
    debdroid "I'm sure you have followed my instructions correctly and didn't accidentally allow me to override your $HOME/.ssh/config."
    debdroid "But I'm there to save you in case you missed something! I'm going to keep a backup of your $HOME/.ssh/config file in $HOME/.dotfiles/archive/ with your user name."
    echo
    mv ~/.ssh/config ~/.dotfiles/archive/.ssh_config_${user_name}_${date_time_stamp}
    info "Your $HOME/.ssh/config file archived to $HOME/.dotfiles/archive/.ssh_config_${user_name}_${date_time_stamp}"

    # Now create symlink for .gitconfig and .gitignore_global
    ln -sv ~/.dotfiles/ssh_config/config ~/.ssh/config > /dev/null
    info "Created symlink $HOME/.ssh/config -> $HOME/.dotfiles/ssh_config/config"

    # Remove the variables
    unset user_name
    unset date_time_stamp

    # Show completion message
    completed "Successfully setup ssh configuration"
  else
    debdroid "I cannot locate $HOME/.ssh/config in your $HOME/.ssh/ directory. No changes made to your ssh config file."
    warning "ssh configuration setup not done due to a problem!"
    return 1
  fi
else
  debdroid "No problem! You continue to use your own $HOME/.ssh/config!"
  return 2
fi
