# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
# export ZSH=/Users/debashispaul/.oh-my-zsh
 export ZSH=$HOME/.oh-my-zsh

# To support 256 color - Added this by Debashis
export TERM="xterm-256color"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="agnoster" # I also like this theme but thought of trying Powerlevel9k
ZSH_THEME="powerlevel9k/powerlevel9k"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
 ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
 COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder
# ** START - Modified to add custom folder for ZSH_CUSTOM
#To use a different directory for ZSH_CUSTOM
if [ -d ~/.custom_zsh ]; then
	if [ -L ~/.custom_zsh ]; then
		ZSH_CUSTOM=$HOME/.custom_zsh
	else
		echo "A directory '~/.custom_zsh' is used for 'ZSH_CUSTOM' but it should have been a symlink: .custom_zsh -> $HOME/dotfiles/zsh/.custom_zsh"
	fi
else
	echo "The 'ZSH_CUSTOM' symliink directory ~/.custom_zsh -> $HOME/dotfiles/zsh/.custom_zsh not found"
fi
# ** END - Modified to add custom folder for ZSH_CUSTOM

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# FOLLOWING SECTION IS ADDED MANUALLY 		 																							 #
# Modified after installation - Debashis Paul 																							 #
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
# Change log 																															 #
# <dd-mmm-yyyy: Reason>																													 #
# 15-Mar-2018: Initail modified version														 											 #
#																																		 #
# 18-Mar-2018: Activate zsh-completion													 											 #
#																																		 #
#- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
#For auto-suggestion
if [ -f /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
	source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
else
	echo "Zsh auto-suggestion file '/usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh' not found"
fi

#For syntax highlighting
if [ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
	source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
	echo "Zsh syntax highlighting file '/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' not found"
fi

#This will help to not show the “user@hostname” in the prompt.
DEFAULT_USER=`whoami`

#Activate zsh-completion
if [ -d /usr/local/share/zsh-completions ]; then
	fpath=(/usr/local/share/zsh-completions $fpath)
else
	echo "Zsh completion directory '/usr/local/share/zsh-completions' not found"
fi
#- - - - - - -  - - - - - - - - - - - - - - - - - -   End of File   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -- - - - #
