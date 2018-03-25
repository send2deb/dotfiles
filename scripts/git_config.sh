#!/bin/sh
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# Author: Debashis Paul																													                                                         #
# Descriptions: This shell does the git configuration setup 																					                                   #
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# Change log 																															                                                               #
# <dd-mmm-yyyy: Reason>																													                                                         #
# 18-Mar-2018: Initial version.																 											                                                     #
#																																		                                                                     #
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

# Check if it's running in interactive mode, if yes then allow user to bypass this setup.
echo
info ">>>>>>>>>>>>>> '5 -> git configuration setup' <<<<<<<<<<<<<<"
if [ $run_mode = $run_mode_interactive ]; then
  debdroid "You are running this with interactive mode. I'm going to do the git configuration setup next for you."
  action "Do you want to continue with the git configuration setup (enter 'y' to proceed or enter 'n' to bypass) [y|N]?"
  read -r user_choice
  if [[ $user_choice =~ ^(y|yes|Y) ]];then
    echo
    continue
  else
    info "Skipped git configuration setup."
    return $user_bypassed_the_step
  fi
fi

debdroid "I maintain .gitconfig and .gitignore_global in $HOME/.dotfiles/git/ and use their symlink in home directory (i.e. ~)."
debdroid "Both .gitconfig and .gitignore_global files are user specific. I have got mine in my $HOME/.dotfiles/git/."
debdroid "If you want me to maintain your .gitconfig and .gitignore_global then replace those two files in $HOME/.dotfiles/git/ with yours before proceeding further."
debdroid "If you do not want me to maintain your .gitconfig and .gitignore_global files then skip this step."
warning "You should replace my .gitconfig and .gitignore_global in $HOME/.dotfiles/git/ with yours, otherwise I will replace yours with mine."
action "Do you want to proceed to next step (enter 'y' to proceed or enter 'n' to  bypass this setup) [y|N]?"
read -r first_response
if [[ $first_response =~ ^(y|yes|Y) ]];then
  echo
  executing "Setting up $HOME/.gitconfig and $HOME/.gitignore_global"
  if [[ -f ~/.gitconfig && -f ~/.gitignore_global ]]; then
    # Define the variables
    user_name=`whoami`
    date_time_stamp=$(date +"%Y-%m-%d_%H.%M.%S")

    # Take backup of .gitconfig and .gitignore_global
    debdroid "I'm sure you have followed my instructions correctly and didn't accidentally allow me to override your $HOME/.gitconfig and $HOME/.gitignore_global."
    debdroid "But I'm there to save you in case you missed something! I'm going to keep a backup of your files in $HOME/.dotfiles/archive/ with your user name."
    echo
    mv ~/.gitconfig ~/.dotfiles/archive/.gitconfig_${user_name}_${date_time_stamp}
    info "Your $HOME/.gitconfig file archived to $HOME/.dotfiles/archive/.gitconfig_${user_name}_${date_time_stamp}"
    mv ~/.gitignore_global ~/.dotfiles/archive/.gitignore_global_${user_name}_${date_time_stamp}
    info "Your $HOME/.gitignore_global file archived to $HOME/.dotfiles/archive/.gitignore_global_${user_name}_${date_time_stamp}"

    # Now create symlink for .gitconfig and .gitignore_global
    ln -sv ~/.dotfiles/git/.gitconfig ~ > /dev/null
    info "Created symlink $HOME/.gitconfig -> $HOME/.dotfiles/git/.gitconfig"
    ln -sv ~/.dotfiles/git/.gitignore_global ~  > /dev/null
    info "Created symlink $HOME/.gitignore_global -> $HOME/.dotfiles/git/.gitignore_global"

    # Remove the variables
    unset user_name
    unset date_time_stamp

    # Show completion message
    completed "Successfully setup git configuration"
  else
    debdroid "I cannot locate $HOME/.gitconfig and $HOME/.gitignore_global in your $HOME directory. No changes made to your .gitconfig and .gitignore_global."
    warning "git configuration setup not done due to a problem!"
    return 1
  fi
else
  debdroid "No problem! You continue to use your own $HOME/.gitconfig and $HOME/.gitignore_global!"
  return 2
fi
