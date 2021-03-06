# Debashis's dotfiles

This can be used to configure a new Mac system or an existing one. It will automatically install useful developers tools, apps, Mac appstore applications, configure terminal & iTerm and setup system preferences. 

It can be run in automated or interactive mode. Each step can be skip in interactive mode. Helpful messages are shown before running any step.

![](https://user-images.githubusercontent.com/33470591/37882016-343e5392-3097-11e8-9b73-a41cfa5b5dd4.png?raw=true)

Installation
-
**Warning:** This dotfiles is solely written for my own settings. If you want to give it a try then fork it. Review the code and modify based on your need before use. The installation needs SUDO and you should review everything it does. You are responsible for everything the scripts does to your machine.

Clone the git repository to ~/.dotfiles and run ./install.sh.

> git clone --recursive https://github.com/send2deb/dotfiles ~/.dotfiles  
> cd ~/.dotfiles  
> ./install.sh

Features
-
* [Bash configuration for Terminal](#bash-configuration-for-terminal)
* [Homebrew install / upgrade](#home-brew-install-or-upgrade)
* [Brew core packages install](#brew-core-packages-install)
* [Brew cask packages install](#brew-cask-packages-install)
* [ZSH configuration for iTerm](#zsh-configuration-for-iterm)
* [Git configuration](#git-configuration)
* [SSH configuration](#ssh-configuration)
* Vim configuration (Not implemented)
* [Install or update Mac appstore applications](#install-or-update-mac-appstore-applications)
* [Mac system preference configuration](#mac-system-preference-configuration)

Bash configuration for Terminal
-

I have my own configuration, aliases and other setup which you can check and use. Or use your own and maintain in ~/.dotfiles. Follow the instructions while install.

Homebrew install or upgrade
-

It will install the Homebrew if not already installed on the machine. If it's already there then it will upgrade.

Brew core packages install
-

It will install the following brew core packages(Refer the [Brewfile](https://github.com/send2deb/dotfiles/blob/master/brew/Brewfile) file):

* ack
* apr-util
* argon2
* aspell
* autoconf
* bash 
* bash-completion 
* brew-cask-completion 
* brotli
* c-ares
* composer
* coreutils 
* cowsay 
* cscope
* curl 
* curl-openssl
* dart
* diff-so-fancy 
* dockutil 
* findutils 
* fish 
* fontconfig 
* freetds
* freetype
* gdbm
* gettext
* gibo 
* git 
* git-flow 
* glib
* gmp
* gradle 
* gradle-completion 
* groovy 
* highlight
* httpd
* icu4c
* ilmbase
* imagemagick 
* isl
* jansson
* jemalloc
* jpeg
* libde265
* libev
* libevent
* libffi
* libheif
* libidn
* libidn2
* libmetalink
* libmpc
* libomp
* libpng
* libpq
* libsodium
* libssh2
* libtiff
* libtool
* libunistring
* libyaml
* libzip
* little-cms2
* lua
* jenkins
* mackup 
* macvim 
* mas 
* maven
* most 
* mpfr
* mysql
* ncurses
* nghttp2
* nmap 
* node
* openexr
* openjpeg
* openldap
* openssl 
* openssl@1.1
* pandoc 
* pcre
* pcre2
* peco 
* perl
* php
* phpmyadmin
* pidcat 
* pkg-config
* psgrep 
* python
* readline
* rtmpdump
* ruby
* s-lang
* sass
* shellcheck 
* sphinx-doc
* sqlite
* telnet
* tidy-html5
* tmux 
* trash 
* tree 
* unar 
* unixodbc
* vagrant-completion 
* vim 
* webp"
* wget 
* wifi-password 
* x265
* xz 
* youtube-dl 
* zsh 
* zsh-autosuggestions 
* zsh-completions 
* zsh-syntax-highlighting 

Brew cask packages install
-

It will install the following brew cask packages (Refer the [Brewfile](https://github.com/send2deb/dotfiles/blob/master/brew_cask/Brewfile) file):

* adobe-acrobat-reader 
* airdroid 
* alfred 
* android-file-transfer 
* androidtool 
* android-platform-tools 
* android-sdk 
* android-studio 
* caskroom/versions/android-studio-preview 
* appcleaner 
* atom 
* brackets 
* cheatsheet 
* dash 
* docker 
* dropbox 
* eclipse-java 
* filezilla 
* firefox 
* flux 
* genymotion 
* gimp 
* google-backup-and-sync 
* google-chrome 
* grammarly 
* inkscape 
* intellij-idea-ce 
* iterm2 
* jadengeller-helium 
* java 
* lastpass 
* little-snitch 
* macdown 
* malwarebytes 
* marshallofsound-google-play-music-player 
* mat 
* qlcolorcode 
* qlimagesize 
* qlmarkdown 
* qlstephen 
* qlvideo 
* quicklook-json 
* quicklookase 
* spectacle 
* skype 
* Scout
* skype-for-business 
* slack 
* sourcetree 
* spotify 
* sublime-text 
* suspicious-package 
* textmate 
* transmit 
* vagrant 
* virtualbox 
* visual-studio-code
* vysor
* webpquicklook 
* whatsapp 
* zipeg 
* font-awesome-terminal-fonts 
* font-fontawesome 
* font-hack 
* font-inconsolata-dz-for-powerline 
* font-inconsolata-for-powerline 
* font-inconsolata-g-for-powerline 
* font-roboto-mono 
* font-roboto-mono-for-powerline 
* font-source-code-pro 

ZSH configuration for iTerm
-

I have my own configuration, aliases and other setup for zsh which you can check and use. Or use your own and maintain in ~/.dotfiles. Follow the instructions while install.

Git configuration
-

I maintain my global .gitconfig and .gitignore_global in .dotfiles. You can also do the same by following the instructions while install.

SSH configuration
-

I maintain my global ssh config file in .dotfiles. You can also do the same by following the instructions while install.

Install or update Mac appstore applications
-

It will install or update the following Mac appstore applications (Refer the [Brewfile](https://github.com/send2deb/dotfiles/blob/master/macos/Brewfile)):

* Evernote 
* GarageBand 
* iBooks Author 
* iMovie 
* Keynote 
* Kindle 
* MagicanPaster 
* Numbers 
* OneDrive 
* Pages 
* Pocket 
* SketchBook" 
* SQLPro for SQLite (Lite) 
* The Unarchiver 
* Xcode 
* XMenu 
* DeskApp for YouTube 
* Microsoft OneNote 
* GIPHY CAPTURE

Mac system preference configuration
-

It will set the following Mas system preferences (Refer the Mac system preference configuration [script](https://github.com/send2deb/dotfiles/blob/master/scripts/mac_system_config.sh)):

* Enable auto update
* Enable app update install
* Enable system data files and security update installs
* Enable OS X update installs restart required
* Turn off Bluetooth, if no paired devices exist
* Show Bluetooth status in menu bar
* Disable remote apple events
* Disable remote login
* Disable Wake for network access
* Enable Gatekeeper
* Enable Firewall (for specific service)
* Enable Firewall Stealth Mode
* Enable Location Services
* Enable Secure Keyboard Entry in Terminal app
* Disable wake-on modem
* Disable wake-on LAN
* Require a password to wake the computer from sleep or screen saver
* Set a custom message for login screen (**Warning:** Change this with your own message)
* Disable guest account login
* Turn on filename extensions
* Show hidden files by default
* Show the ~/Library folder
* Allow 'locate' command
* Disable the automatic run of safe files in Safari
* Set highlight color to green
* Expand save panel by default
* Save to disk (not to iCloud) by default
* Reveal IP, hostname, OS, etc. when clicking clock in login window
* Disable automatic termination of inactive app
* Disable the crash reporter
* Restart automatically if the computer freezes
* Disable smart quotes when typing
* Disable smart dashes when typing
* Disable automatic capitalization when typing
* Disable auto-correct
* Keep folders on top when sorting by name
* Automatically hide and show the Dock
* Make Dock icons of hidden applications translucent
* Always boot in verbose mode (not MacOS GUI mode)
* Hotcorners - Top left screen corner → Mission Control
* Hotcorners - Top right screen corner → Desktop
* Hotcorners - Bottom left screen corner → Start screen saver
* Save screenshots to the desktop
* Save screenshots in PNG format

Watch me running
-

![](https://user-images.githubusercontent.com/33470591/37882031-52df87bc-3097-11e8-9170-3b8c9bda0d82.gif?raw=true)

Contributions
-
Contributions are welcome. Please fork and create a pull request with details. Also report issue in Github.


Reference
-
* [https://github.com/atomantic/dotfiles](https://github.com/atomantic/dotfiles)
* [https://github.com/mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
* [https://github.com/ashishb/dotfiles](https://github.com/ashishb/dotfiles)
* [https://github.com/holman/dotfiles](https://github.com/holman/dotfiles)
* [https://github.com/webpro/awesome-dotfiles](https://github.com/webpro/awesome-dotfiles)
* [https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789](https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789)
* [https://zachholman.com/2010/08/dotfiles-are-meant-to-be-forked](https://zachholman.com/2010/08/dotfiles-are-meant-to-be-forked/)
* [https://medium.com/@elviocavalcante/5-steps-to-improve-your-terminal-appearance-on-mac-osx-f58b20058c84](https://medium.com/@elviocavalcante/5-steps-to-improve-your-terminal-appearance-on-mac-osx-f58b20058c84)

Warning / Liability
-
The owner of this repo is not responsible if you end up setting up your machine in state you are not happy with or breaks anything in your system. Please use it at your own risk and review the code before using.
