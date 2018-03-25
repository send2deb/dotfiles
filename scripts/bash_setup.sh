#!/bin/sh
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# Author: Debashis Paul																													                                                         #
# Descriptions: This shell installs .bash_profile and .bashrc for MacOs 																		                             #
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# Change log 																															                                                               #
# <dd-mmm-yyyy: Reason>																													                                                         #
# 19-Mar-2018: Initial version.																 											                                                     #
#																																		                                                                     #
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

# Check if it's running in interactive mode, if yes then allow user to bypass this setup.
info ">>>>>>>>>>>>>> '1 -> Bash setup' <<<<<<<<<<<<<<"
if [ $run_mode = $run_mode_interactive ]; then
    debdroid "You are running this with interactive mode. I'm going to do the bash setup next for you."
    action "Do you want to continue with the bash setup (enter 'y' to proceed or enter 'n' to bypass) [y|N]?"
    read -r user_choice
    if [[ $user_choice =~ ^(y|yes|Y) ]];then
      echo
      continue
    else
      info "Skipped bash setup."
      return $user_bypassed_the_step
    fi
fi

debdroid "Bash setup! This is CRITICAL and IMPORTANT setup. Please pay attention and select option appropriately."
debdroid "You have three options:"
debdroid "Option 1 - Install my $HOME/.dotfiles/bash_files/.bash_profile and $HOME/.dotfiles/bash_files/.bashrc and use those. I'm sure you will like it :)."
debdroid "Option 2 - You use your own $HOME/.bash_profile and $HOME/.bashrc and completely ignore mine. But please note that your $HOME/.bash_profile and $HOME/.bashrc will not be maintained by me in $HOME/.dotfiles."
debdroid "Option 3 - You use your own $HOME/.bash_profile and $HOME/.bashrc but allow me to maintain those for future in $HOME/.dotfiles."
echo

action "Do you want to proceed to next step (enter 'y' to proceed or enter 'n' to  bypass this setup) [y|N]?"
read -r first_response
if [[ $first_response =~ ^(y|yes|Y) ]];then
    debdroid "Great! You are like me! Always ready to explore for new thing! Now, select your next step."
    echo
    action "Do you want to use my .bash_profile and .bashrc (enter 'y' to proceed or enter 'n' to use yours but allow me to maintain? [y|N]?"      
    read -r second_response
    if [[ $second_response =~ ^(y|yes|Y) ]];then
        debdroid "Fantastic! I will take a backup of your $HOME/.bash_profile and $HOME/.bashrc and put into $HOME/.dotfiles/archive/ with your user name."
        debdroid "Then I will remove those two files from your $HOME/ directory and create symlink to use my files from $HOME/.dotfiles/bash_files/."
        debdroid "I will also copy git-completion.bash, git-prompt.sh from $HOME/.dotfiles/git/ and create symlink for .bash_zsh_common from $HOME/.dotfiles/bash_files/ to your $HOME/ directory. If you have any of these files then it will be archived and replaced by my file(s)."
        echo
        action "Do you want to continue and do this setup [y|N]?"
        read -r third_response
        if [[ $third_response =~ ^(y|yes|Y) ]];then
          debdroid "You are awesome! I'm sure you will enjoy my bash."
          echo
          executing "Setting up new $HOME.bash_profile and $HOME.bashrc"
          if [[ -f ~/.bash_profile && -f ~/.bashrc ]]; then
            # Define the variables
            user_name=`whoami`
            date_time_stamp=$(date +"%Y-%m-%d_%H.%M.%S")
            
            # First take the backup of existing files
            cp ~/.bash_profile ~/.dotfiles/archive/.bash_profile_${user_name}_${date_time_stamp}
            info "Your $HOME/.bash_profile file archived to $HOME/.dotfiles/archive/.bash_profile_${user_name}_${date_time_stamp}"
            cp ~/.bashrc ~/.dotfiles/archive/.bashrc_${user_name}_${date_time_stamp}
            info "Your $HOME/.bashrc file archived to $HOME/.dotfiles/archive/.bashrc_${user_name}_${date_time_stamp}"
            # Check if git-completion.bash exist, if yes then archive it
            if [ -f ~/git-completion.bash ]; then
              cp ~/git-completion.bash ~/.dotfiles/archive/git-completion.bash_${user_name}_${date_time_stamp}
              info "Found git-completion.bash. Your $HOME/git-completion.bash file archived to $HOME/.dotfiles/archive/git-completion.bash_${user_name}_${date_time_stamp}"
            fi
            # Check if git-prompt.sh exist, if yes then archive it
            if [ -f ~/git-prompt.sh ]; then
              cp ~/git-prompt.sh ~/.dotfiles/archive/git-prompt.sh_${user_name}_${date_time_stamp}
              info "Found git-prompt.sh. Your $HOME/git-prompt.sh file archived to $HOME/.dotfiles/archive/git-prompt.sh_${user_name}_${date_time_stamp}"
            fi
            # Check if .bash_zsh_common exist, if yes then archive it
            if [ -f ~/.bash_zsh_common ]; then
              cp ~/.bash_zsh_common ~/.dotfiles/archive/.bash_zsh_common_${user_name}_${date_time_stamp}
              info "Found .bash_zsh_common. Your $HOME/.bash_zsh_common file archived to $HOME/.dotfiles/archive/.bash_zsh_common_${user_name}_${date_time_stamp}"
            fi

            # Now remove all the files
            rm ~/.bash_profile
            info "Removed file $HOME/.bash_profile"
            rm ~/.bashrc
            info "Removed file $HOME/.bashrc"
            if [ -f ~/git-completion.bash ]; then
              rm ~/git-completion.bash
              info "Removed file $HOME/git-completion.bash"
            fi
            if [ -f ~/git-prompt.sh ]; then
              rm ~/git-prompt.sh
              info "Removed file $HOME/git-prompt.sh"
            fi
            if [ -f ~/.bash_zsh_common ]; then
              rm ~/.bash_zsh_common
              info "Removed file $HOME/.bash_zsh_common"
            fi

            # Now copy git-completion.bash and git-prompt.sh
            cp ~/.dotfiles/git/git-completion.bash ~/git-completion.bash
            info "Copied $HOME/.dotfiles/git/git-completion.bash to $HOME/git-completion.bash"
            cp ~/.dotfiles/git/git-prompt.sh ~/git-prompt.sh
            info "Copied $HOME/.dotfiles/git/git-prompt.sh to $HOME/git-prompt.sh"
            
            # Now create symlink for .bash_profile, .bashrc and .bash_zsh_common
            ln -sv ~/.dotfiles/bash_files/.bash_profile ~ > /dev/null
            info "Created symlink $HOME/.bash_profile -> $HOME/.dotfiles/bash_files/.bash_profile"
            ln -sv ~/.dotfiles/bash_files/.bashrc ~  > /dev/null
            info "Created symlink $HOME/.bashrc -> $HOME/.dotfiles/bash_files/.bashrc"
            ln -sv ~/.dotfiles/bash_files/.bash_zsh_common ~  > /dev/null
            info "Created symlink $HOME/.bash_zsh_common -> $HOME/.dotfiles/bash_files/.bash_zsh_common"
            
            # Remove the variables
            unset user_name
            unset date_time_stamp

            # Show completion message
            completed "Successfully completed the new bash setup"
          else
            debdroid "I cannot locate $HOME/.bash_profile and $HOME/.bashrc in your home directory. So I cannot setup bash, no changes made to your setup."
            warning "Bash setup not done due to a problem!"
            return 1
          fi
        else
          debdroid "No problem! You continue to use your own $HOME/.bash_profile and $HOME/.bashrc!"
          return 2
        fi
    else
        debdroid "Still a better decision! I will take a backup of your $HOME/.bash_profile and $HOME/.bashrc and put into $HOME/.dotfiles/archive/ with your user name."
        debdroid "Then I will copy those two files from your $HOME directory to $HOME/.dotfiles/bash_files/ and create symlink to $HOME (i.e. ~) directory."
        echo
        action "Do you want to continue and do this setup [y|N]?"
        read -r fourth_response
        if [[ $fourth_response =~ ^(y|yes|Y) ]];then
          debdroid "Fantastic! You will now be able to maintain your $HOME/.bash_profile and $HOME/.bashrc in $HOME/.dotfiles."
          echo
          executing "Changing your $HOME.bash_profile and $HOME.bashrc for better maintenance"
          if [[ -f ~/.bash_profile && -f ~/.bashrc ]]; then
            # Define the variables
            user_name=`whoami`
            date_time_stamp=$(date +"%Y-%m-%d_%H.%M.%S")
            
            # First take the backup of existing files of users
            cp ~/.bash_profile ~/.dotfiles/archive/.bash_profile_${user_name}_${date_time_stamp}
            info "Your $HOME/.bash_profile file archived to $HOME/.dotfiles/archive/.bash_profile_${user_name}_${date_time_stamp}"
            cp ~/.bashrc ~/.dotfiles/archive/.bashrc_${user_name}_${date_time_stamp}
            info "Your $HOME/.bashrc file archived to $HOME/.dotfiles/archive/.bashrc_${user_name}_${date_time_stamp}"

            # Usr's file could be symlink pointing to ~/.dotfiles/bash_files_files!!!
            # So, to avoid going into loop where moving dot files will make those symlink useless
            # It's better to create a copy and use that later while copying to ~/.dotfiles/bash_files/.bash_profile
            cp ~/.bash_profile ~/.dotfiles/tmp/.bash_profile_user
            cp ~/.bashrc ~/.dotfiles/tmp/.bashrc_user

            # Move bot's bash files to archive - it will be moved for the first time and subsequent move will bypass
            # It also ensures that bot's .bash_profile and .bashrc will never get overwritten
            if [ -f ~/.dotfiles/archive/.bash_profile ]; then
              debdroid "You are setting it up more than once and I just avoided overwriting my favorite .bash_profile archive copy."
            else              
              mv -n ~/.dotfiles/bash_files/.bash_profile ~/.dotfiles/archive/_debdroid_/
              info "$bot's $HOME/.dotfiles/bash_files/.bash_profile file moved to $HOME/.dotfiles/archive/_debdroid_/.bash_profile"
            fi
            if [ -f ~/.dotfiles/archive/.bashrc ]; then
              debdroid "You are setting it up more than once and I just avoided overwriting my favorite .bashrc archive copy."
            else
              mv -n ~/.dotfiles/bash_files/.bashrc ~/.dotfiles/archive/_debdroid_/
              info "$bot's $HOME/.dotfiles/bash_files/.bashrc file moved to $HOME/.dotfiles/archive/_debdroid_/.bashrc"
            fi

            # Copy users file to ~/.dotfiles/bash_files directory - Use the copy from /tmp as it could be symlink
            cp ~/.dotfiles/tmp/.bash_profile_user ~/.dotfiles/bash_files/.bash_profile > /dev/null 2>&1
            info "Your $HOME/.bash_profile file copied to $HOME/.dotfiles/bash_files/.bash_profile"
            cp ~/.dotfiles/tmp/.bashrc_user ~/.dotfiles/bash_files/.bashrc > /dev/null 2>&1
            info "Your $HOME/.bashrc file copied to $HOME/.dotfiles/bash_files/.bashrc"

            # Now remove the files from user home directory and /tmp
            rm ~/.bash_profile
            info "Removed file $HOME/.bash_profile"
            rm ~/.bashrc
            info "Removed file $HOME/.bashrc"
            rm ~/.dotfiles/tmp/.bash_profile_user
            rm ~/.dotfiles/tmp/.bashrc_user

            # Now create symlink for .bash_profile, .bashrc and .bash_zsh_common
            ln -sv ~/.dotfiles/bash_files/.bash_profile ~ > /dev/null
            info "Created symlink $HOME/.bash_profile -> $HOME/.dotfiles/bash_files/.bash_profile"
            ln -sv ~/.dotfiles/bash_files/.bashrc ~  > /dev/null
            info "Created symlink $HOME/.bashrc -> $HOME/.dotfiles/bash_files/.bashrc"

            # Remove the variables
            unset user_name
            unset date_time_stamp

            # Show completion message
            completed "Successfully changed your bash setup"
          else
            debdroid "I cannot locate $HOME/.bash_profile and $HOME/.bashrc in your home directory. So cannot setup bash, no changes made to your setup."
            warning "Bash setup not done due to a problem!"
            return 3
          fi
        else
          debdroid "No problem! You continue to use your own $HOME/.bash_profile and $HOME/.bashrc!"
          return 4
        fi
    fi
else
  debdroid "No problem! You continue to use your own $HOME/.bash_profile and $HOME/.bashrc!"
  return 5
fi

