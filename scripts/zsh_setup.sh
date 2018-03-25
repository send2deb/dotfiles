#!/bin/sh
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# Author: Debashis Paul																													                                                         #
# Descriptions: This shell installs .oh-my-zsh and setup .zshrc          																		                             #
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# Change log 																															                                                               #
# <dd-mmm-yyyy: Reason>																													                                                         #
# 24-Mar-2018: Initial version.																 											                                                     #
#																																		                                                                     #
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

# Check if it's running in interactive mode, if yes then allow user to bypass this setup.
echo
info ">>>>>>>>>>>>>> '4 -> zsh and oh-my-zsh setup' <<<<<<<<<<<<<<"
if [ $run_mode = $run_mode_interactive ]; then
    debdroid "You are running this with interactive mode. I'm going to do the zsh and and oh-my-zsh setup next for you."
    action "Do you want to continue with the zsh setup (enter 'y' to proceed or enter 'n' to bypass) [y|N]?"
    read -r user_choice
    if [[ $user_choice =~ ^(y|yes|Y) ]];then
      echo
      continue
    else
      info "Skipped zsh and oh-my-zsh setup."
      return $user_bypassed_the_step
    fi
fi

# Check if zsh is already installed. If not then exit.
executing "Checking zsh install"
if test ! $(which zsh); then
  warning "zsh Shell is not installed, zsh is required for oh-my-zsh. Skipped zsh and oh-my-zsh setup."
  return 1
else
  info "zsh Shell is installed. You are using $(which zsh)"
  # Check if oh-my-zsh is already installed.
  executing "Checking oh-my-zsh install"
  if [ -d "$ZSH" ]; then
    info "oh-my-zsh is installed. Install location $ZSH"
    echo
    debdroid "Before proceeding with further setup, I can upgrade your oh-my-zsh install. It will only upgrade and will not change any of your setup."
    action "Run oh-my-zsh upgrade? [y|N]"
    read -r response_one
    if [[ $response_one =~ ^(y|yes|Y) ]];then
        executing "Upgrade oh-my-zsh"
        source $ZSH/tools/upgrade.sh # Function provided by oh-my-zsh
        completed "Successfully upgraded oh-my-zsh"
    else
        info "Skipped oh-my-zsh upgrades."
    fi
  else
    info "oh-my-zsh is not installed."
    debdroid "I will install oh-my-zsh in $HOME/.oh-my-zsh. If you never used it before then visit https://github.com/robbyrussell/oh-my-zsh."
    warning "Please note that installation of oh-my-zsh will set your default shell to zsh if that's not your login shell. You will be asked for password!"
    action "Install oh-my-zsh? [y|N]"
    read -r response_two
    if [[ $response_two =~ ^(y|yes|Y) ]];then
        executing "Install oh-my-zsh"
        # Set the ZSH variable, if not already set
        if [ ! -n "$ZSH" ]; then
          ZSH=~/.oh-my-zsh
        fi
        
        # Check if we get a 200, if yes then we can safely assume that git clone is going to be successful
        resp="$(curl --silent --output /dev/null --write-out "%{http_code}" https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
        if [ $resp -eq 200 ]; then
            env git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git $ZSH || {
            error "Error installing oh-my-zsh"
            return 2
          }
          
          # Backup .zshrc if exists - same logic used by original oh-my-zsh install script
          executing "Looking for an existing zsh config"
          if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]; then
            info "Found $HOME/.zshrc. Backing up to $HOME/.zshrc.pre-oh-my-zsh";
            mv ~/.zshrc ~/.zshrc.pre-oh-my-zsh;
            completed "$HOME.zshrc backed up to $HOME/.zshrc.pre-oh-my-zsh"
          fi
          
          # Create a template for .zshrc
          executing "Creating ~/.zshrc from a template"
          cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
          completed "$HOME/.zshrc created"

          # Change login shell
          executing "Checking current shell"
          current_shell=$(expr "$SHELL" : '.*/\(.*\)')
          if [[ "$current_shell" != "zsh" ]]; then
              info "Current shell is not zsh. Changing it to zsh."
              # Mac default zsh is set here as a safe solution
              # If brew installed /usr/local/bin/zsh is present then that anyhow is picked by the terminal because that's in the PATH
              # In case /usr/local/bin/zsh is not present then following MacOs .dscl will break the system
              # sudo dscl . -change /Users/$USER UserShell $SHELL /usr/local/bin/zsh > /dev/null 2>&1
              chsh -s $(grep /zsh$ /etc/shells | tail -1) 
          else
            info "Current shell is zsh and you are using $SHELL. No change needed."
          fi

          # Show completion message
          completed "Successfully installed oh-my-zsh packages"
        else
          error "Error installing oh-my-zsh, probable reason Internet connection."
          return 3
        fi
    else
        info "Skipped oh-my-zsh install. Skipping zsh and oh-my-zsh setup."
        return 4
    fi
  fi
  # If it reaches here then either it's a fresh install or already installed and might have been upgraded
  echo
  debdroid "If you already have oh-my-zsh installed and you want to continue to use it with your own setup then you can skip this step."
  debdroid "But if you have installed it for the first time then I would recommend to run this step."
  action "Do you want to continue with oh-my-zsh setup? [y|N]"
  read -r response_three
  if [[ $response_three =~ ^(y|yes|Y) ]];then
        echo
        debdroid "Fantastic! You will now use my oy-my-zsh setup and I'm sure you will love it."
        debdroid "If you had already used oh-my-zsh then I will take a backup of your $HOME/.zshrc and put into $HOME/.dotfiles/archive/ with your user name."
        debdroid "Then I will remove $HOME.zshrc file from your home directory and create symlink in your $HOME/ directory to use my .zshrc from $HOME/.dotfiles/zsh_files/.zshrc."
        debdroid "I will also create symlink for $HOME/.dotfiles/bash_files/.bash_zsh_common and $HOME/.dotfiles/zsh_files/.custom_zsh to your $HOME (i.e. ~) directory."
        debdroid "If you just installed it then allow me to set it up for you."
        action "Do you want to continue with oh-my-zsh? [y|N]"
        read -r response_three
        if [[ $response_three =~ ^(y|yes|Y) ]];then
            debdroid "Right decision! I'm sure you will enjoy my oh-my-zsh setup."
            echo
            executing "Setting up oh-my-zsh"
            if [[ -f ~/.zshrc ]]; then
              # Define the variables
              user_name=`whoami`
              date_time_stamp=$(date +"%Y-%m-%d_%H.%M.%S")
            
              # First take the backup of user's file
              cp ~/.zshrc ~/.dotfiles/archive/.zshrc_${user_name}_${date_time_stamp}
              info "Your $HOME/.zshrc file archived to $HOME/.dotfiles/archive/.zshrc_${user_name}_${date_time_stamp}"

              # Now remove the file .zshrc
              rm ~/.zshrc
              info "Removed file $HOME/.zshrc"

              # Now create symlink for .zshrc, .custom_zsh and .bash_zsh_common
              ln -sv ~/.dotfiles/zsh_files/.zshrc ~ > /dev/null
              info "Created symlink $HOME/.zshrc -> $HOME/.dotfiles/zsh_files/.zshrc"
              if [ -L ~/.custom_zsh ]; then
                info "symlink $HOME/.custom_zsh -> $HOME/.dotfiles/zsh_files/.custom_zsh already present, no need to create one."
              else
                ln -sv ~/.dotfiles/zsh_files/.custom_zsh ~  > /dev/null
                info "Created symlink $HOME/.custom_zsh -> $HOME/.dotfiles/zsh_files/.custom_zsh"
              fi
              if [ -L ~/.bash_zsh_common ]; then
                info "symlink $HOME/.bash_zsh_common -> $HOME/.dotfiles/bash_files/.bash_zsh_common already present, no need to create one."
              else
                ln -sv ~/.dotfiles/bash_files/.bash_zsh_common ~  > /dev/null
                info "Created symlink $HOME/.bash_zsh_common -> $HOME/.dotfiles/bash_files/.bash_zsh_common"
              fi

              # Remove the variables
              unset user_name
              unset date_time_stamp

              # Show completion message
              completed "Successfully completed the oh-my-zsh setup"
              echo
              debdroid "My zsh is customized with powerlevel9k theme which is inside $HOME/.dotfiles/zsh_files/.custom_zsh/themes/powerlevel9k/".
              debdroid "My zsh uses 'Solarized Dark - Patched' color profile which is inside $HOME/.dotfiles/solarized_colors/."
              debdroid "My zsh uses 'Sourcecode Powerline font'. If you have executed my brew package install then it must be available in $HOME/Library/Fonts, otherwise download it from https://github.com/powerline/fonts/tree/master/SourceCodePro."
              debdroid "You need to open the color profile file to automatically load it to iTerm; just open it."
            else
              debdroid "I cannot locate $HOME/.zshrc in your $HOME directory. So I cannot setup oh-my-zsh, no changes made to your oh-my-zsh setup."
              warning "oh-my-zsh setup not done due to a problem!"
              return 5
            fi
        else
          debdroid "No problem, you continue to use your own oh-my-zsh setup or default setup in case you just installed it."
        fi
  else
    debdroid "No problem, you continue to use your own oh-my-zsh setup or default setup in case you just installed it."
  fi
fi

