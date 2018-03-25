#!/bin/sh
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# Author: Debashis Paul																													 #
# Descriptions: This shell script provides utility functions used by the main install.sh script											 #
#               Inspired by https://github.com/atomantic/dotfiles/blob/master/lib_sh/echos.sh 											 #
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# Change log 																															 #
# <dd-mmm-yyyy: Reason>																													 #
# 18-Mar-2018: Initial version.																 											 #
#																																		 #
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

# Check the operating system type - if MacOs then retrun 0 otherwise return -1
function check_operating_system_type() {
	executing "Operating system check"
	if [ `uname` == "Darwin" ]; then
		info "Operating system is MacOS"
		echo
		return 0
	else 
		info "Operating system is not MacOS"
		echo
		return 1
	fi
}
