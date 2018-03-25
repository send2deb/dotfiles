#————————————————————————————————————————————————————————————————————————————————————
#Mac OS runs a login shell by default, so .bash_profile is called instead of .bashrc
#Since non-login shell by default calls .bashrc. So it’s a good practice to put all
#customisation on .bashrc and call that file from .bash_profile which is done here
#—————————————————————————————————————————————————————————————————————————————————————


# It checks if .bashrc exists in home (~/). If it does then execute that

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
