#!/bin/sh
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# Author: Debashis Paul																													 #
# Descriptions: This shell script provides customize echo with different color.															 #
#               Inspired by https://github.com/atomantic/dotfiles/blob/master/lib_sh/echos.sh 											 #
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# Change log 																															 #
# <dd-mmm-yyyy: Reason>																													 #
# 18-Mar-2018: Initial version.																 											 #
#																																		 #
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

# Define the colors!
COL_GREEN="\033[0;32m"
COL_BLUE="\033[0;34m"
COL_PURPLE="\033[0;35m"
COL_RED="\033[0;31m"
COL_YELLOW="\033[0;33m"
COL_CYAN="\033[0;36m"
COL_RESET="\033[0m"

# Deinfe functions for different echos
function debdroid() {
	echo "$COL_GREEN[(._debdroid_.)]$COL_RESET - "$1
}

function completed() {
	echo "$COL_GREEN[Completed]$COL_RESET "$1
}

function executing() {
    echo "$COL_BLUE[Executing]$COL_RESET $1..."
}

function action() {
    echo "$COL_YELLOW[Action Required]$COL_RESET ⇒ $1 :\c"
}

function info() {
    echo "$COL_CYAN[Info]$COL_RESET "$1
}

function warning() {
    echo "$COL_PURPLE[Warning]$COL_RESET "$1
}

function error() {
    echo "$COL_RED[Error]$COL_RESET "$1
}