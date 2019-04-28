#!/usr/bin/env bash

# TODO
#   - CherryTree preferences

# Exit immediately if a command exits with a non-zero status
set -e

export OS=`uname -s | sed -e 's/  */-/g;y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/'`

if [ "$OS" = "linux" ]; then
	DOTFILES="$HOME/.dotfiles"

	# User prerequisites
	prereq = "Quit(q)/Continue(spacebar)\n"
	read -n1 -r -p $prereq key
	if [ "$key" = '' ]; then
		continue
	fi

	# Install basic packages
	for pkg in apt-transport-https build-essential python-dev vim git
	do
		apt install -y $pkg
	done

	# Download dotfiles project if it doesn't exist
    if [ ! -d $DOTFILES ]; then
        git clone https://github.com/chirinosky/dotfiles.git $DOTFILES
    fi

    # Update gnome-terminal color pallette
    source $DOTFILES/terminals/terminal-sexy.sh

    ## vim
    $VIM_DIR="$DOTFILES/vim"
    cp $VIM_DIR/vimrc.template $HOME/vimrc
    
    # Install Vundle
    test -d $VIM_DIR/bundle/Vundle.vim || git clone https://github.com/gmarik/Vundle.vim.git $VIM_DIR/bundle/Vundle.vim
    vim +BundleInstall +qall

#def install_vim_plugins():
#    print('Installing vim plugins...')
#    vim_version =  subprocess.Popen(shlex.split('vim --version'), stdout=subprocess.PIPE)
#    python_support = subprocess.check_output(shlex.split('grep +python'),stdin=vim_version.stdout)
#    if not python_support:
#        cmd('apt-get install -y vim-gnome')
#    cmd('git clone https://github.com/gmarik/Vundle.vim.git \
#            {0}/vim/bundle/Vundle.vim'.format(dotfiles_dir))
#    cmd('vim -i NONE -c VundleUpdate -c quitall')
#    print('Installing Powerline fonts...')
#    fonts = '{0}/.fonts'.format(base_home_dir)
#    font_config = '{0}/.fonts.conf.d'.format(base_home_dir)
#    if not os.path.exists(fonts):
#        os.makedirs(fonts)
#    cmd('wget -qO {0}/PowerlineSymbols.otf \
#            https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf'.format(fonts))
#    cmd('fc-cache -vf {0}'.format(fonts))
#    if not os.path.exists(font_config):
#        os.makedirs(font_config)
#    cmd('wget -qO {0}/10-powerline-symbols.conf \
#            https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf'.format(font_config))
#    cmd('chown -R {0}:{0} {1}/'.format(username, fonts))
#    cmd('chown -R {0}:{0} {1}/'.format(username, font_config))

	# Install Sublime Text
#	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add -
#	echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list
#	apt update
#	apt install -y sublime-text

	# Update gnome-terminal color pallette
	echo "Customization complete. Remember to:"
	echo "Update gnome-terminal default profile"
fi