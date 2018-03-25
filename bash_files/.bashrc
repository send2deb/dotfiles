#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# Author: Debashis Paul																													 #
# Descriptions: This file contains all BASH Configurations 																				 #
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# Change log 																															 #
# <dd-mmm-yyyy: Reason>																													 #
# 15-Mar-2018: Modfied this file to keep only configuration for 'bash' (Defualt Mac Shell). 											 #
#              Rest movied to '.bash_zsh_common' and a backup is saved as '~/dotfiles/bash/archive/.bashrc_15Mar2018'.					 #
#              This is done so that the common configuration can be used in both 'bash' and 'zsh' (iTerm)								 #
#																																		 #
# 18-Mar-2018: Added bash_completion under section # 1										 											 #
#																																		 #
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# Sections:																																 #
# 1. Configurations used for bash shell ONLY in default Mac Terminal																	 #
# 2. Common Configurations 																												 #
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# 1. Configurations used for bash shell ONLY in default Mac Terminal 																	 #
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# Read global .bashrc file if it exists
if [ -f /etc/bashrc ]; then
   source /etc/bashrc
fi

# colors!
green="\[\033[0;32m\]"
blue="\[\033[0;34m\]"
purple="\[\033[0;35m\]"
red="\[\033[0;31m\]"
reset="\[\033[0m\]"

# Enable tab completion for git command
if [ -f ~/git-completion.bash ]; then
	source ~/git-completion.bash
else
	echo "Git completion file '~/git-completion.bash' not found"
fi

# Enable bash completion
if [ -f /usr/local/etc/bash_completion ]; then
	source /usr/local/etc/bash_completion
else
	echo "Bash completion file '/usr/local/etc/bash_completion' not found"
fi

# Enable tab completion for gradle commandl
#Is not working, so commenting out
#source ~/gradle-tab-completion.bash

# Change command prompt to firendly color and git information
if [ -f ~/git-prompt.sh ]; then
	source ~/git-prompt.sh
	export GIT_PS1_SHOWDIRTYSTATE=1
	# '\u' adds the name of the current user to the prompt
	# '\$(__git_ps1)' adds git-related stuff
	# '\W' adds the name of the current directory
	# '\w' path to the current directory
	# 't' Current time, expressed as HH:MM:SS
	# 'A' Current time, expressed as 'HH:MM'
	# '\$' Use # if logged in as root, otherwise use $
	export PS1="$purple\u$green\$(__git_ps1)$blue \w $red \A \$ $reset"
else
	export PS1="$purple\u$blue \w $red \A \$ $reset"
	echo "Git prompt file '~/git-prompt.sh' not found"
fi

#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# 2. Common Configurations 																												 #
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# Read common configuration file .bash_debashis_custom file if it exists, otherwise show a message
if [ -f ~/.bash_zsh_common ]; then
	if [ -L ~/.bash_zsh_common ]; then
		source ~/.bash_zsh_common
	else
		echo "The common configuration '~/.bash_zsh_common' is a file but it sould have been a symlink: .bash_zsh_common -> $HOME/dotfiles/bash/.bash_zsh_common"
	fi
else
	echo "The common configuration symlink file ~/.bash_zsh_common -> $HOME/dotfiles/bash/.bash_zsh_common not found"
fi
#- - - - - - -  - - - - - - - - - - - - - - - - - -   End of File   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -- - - - #
