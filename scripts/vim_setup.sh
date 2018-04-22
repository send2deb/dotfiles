#!/bin/sh
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# Author: Debashis Paul																													                                                         #
# Descriptions: This shell does the vim setup 					               																                                   #
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# Change log 																															                                                               #
# <dd-mmm-yyyy: Reason>																													                                                         #
# 18-Mar-2018: Initial version.																 											                                                     #
#																																		                                                                     #
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

# Check if it's running in interactive mode, if yes then allow user to bypass this setup.
echo
info ">>>>>>>>>>>>>> '7 -> vim setup' <<<<<<<<<<<<<<"
if [ $run_mode = $run_mode_interactive ]; then
  debdroid "You are running this with interactive mode. I'm going to do the vim setup next for you."
  action "Do you want to continue with the vim setup (enter 'y' to proceed or enter 'n' to bypass) [y|N]?"
  read -r user_choice
  if [[ $user_choice =~ ^(y|yes|Y) ]];then
    echo
    continue
  else
    info "Skipped vim setup."
    return $user_bypassed_the_step
  fi
fi

debdroid "I'm still not a true unix lover :( !! I do not use vim much but I know it's a tool for true unix lover and one day I will be for sure!"
debdroid "Till that day, no setup for vim."