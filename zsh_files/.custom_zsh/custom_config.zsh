#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# Author: Debashis Paul																													 #
# Descriptions: This file contains all ZSH Shell Configurations 																				 #
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# Change log 																															 #
# <dd-mmm-yyyy: Reason>																													 #
# 15-Mar-2018: Created this file to keep only configuration for 'zsh' (Used by iTerm).		 											 #
#																																		 #
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# Sections:																																 #
# 1. Configurations used for zsh shell ONLY in iTerm Terminal																			 #
# 2. Common Cofigurations 																												 #
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# 1. Configurations used for zsh shell ONLY in iTerm																					 #
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# Emtpy at this moment


#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# 2. Common Configurations 																												 #
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# Read common configuration file .bash_zsh_common file if it exists, otherwise show a message
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
