#!/usr/bin/env python
import apt
import os
import shlex
import shutil
import subprocess
import sys


DOTFILES_DIR_NAME = '.dotfiles'
DOTFILES_BACKUP_DIR_NAME = 'dotfiles.old'
base_home_dir = os.path.expanduser('~')
dotfiles_dir = '{0}/{1}'.format(base_home_dir, DOTFILES_DIR_NAME)
dotfiles_backup_dir = '{0}/{1}'.format(base_home_dir, DOTFILES_BACKUP_DIR_NAME)
username = os.getlogin()

def backup_dotfile(filename):
    """ Move file with the same name into the dotfiles backup directory """
    for file_ in os.listdir(base_home_dir):
        if file_ == filename:
            if not os.path.exists(dotfiles_backup_dir):
                os.makedirs(dotfiles_backup_dir)
            found_file = '{0}/{1}'.format(base_home_dir, file_)
            destination = '{0}/{1}'.format(dotfiles_backup_dir, file_)
            os.rename(found_file, destination)

def cmd(command_string):
    """ Executes the requested Linux command """
    subprocess.call(shlex.split(command_string))

def configure_git():
    print('Configuring git...')
    backup_dotfile('.gitconfig')
    backup_dotfile('.gitignore')
    new_gitconfig = '{0}/git/gitconfig.template'.format(dotfiles_dir)
    shutil.copy2(new_gitconfig, base_home_dir)
    os.rename('{0}/gitconfig.template'.format(base_home_dir),
              '{0}/.gitconfig'.format(base_home_dir))
    new_gitignore = '{0}/git/gitignore'.format(dotfiles_dir)
    shutil.copy2(new_gitignore, base_home_dir)
    os.rename('{0}/gitignore'.format(base_home_dir),
              '{0}/.gitignore'.format(base_home_dir))
    cmd('chown {0}:{0} {1}/.gitconfig'.format(username, base_home_dir))
    cmd('chown {0}:{0} {1}/.gitignore'.format(username, base_home_dir))

def configure_gnome_terminal():
    print('Updating terminal theme...')
    is_installed = subprocess.check_output(shlex.split('which gnome-terminal'))
    if not is_installed:
        print('Gnome-terminal was not found... skipping')
        return
    cmd('{0}/terminals/terminal-sexy.sh'.format(dotfiles_dir))

def configure_vim():
    print('Configuring vim...')
    backup_dotfile('.vimrc')
    new_vimrc = '{0}/vim/vimrc.template'.format(dotfiles_dir)
    shutil.copy2(new_vimrc, base_home_dir)
    os.rename('{0}/vimrc.template'.format(base_home_dir),
              '{0}/.vimrc'.format(base_home_dir))
    cmd('chown {0}:{0} {1}/.vimrc'.format(username, base_home_dir))
    cmd('ln -s {0}/vim {1}/.vim'.format(dotfiles_dir, base_home_dir))

def configure_zsh():
    print('Configuring zsh...')
    backup_dotfile('.zshrc')
    new_zshrc = '{0}/zsh/zshrc.template'.format(dotfiles_dir)
    shutil.copy2(new_zshrc, base_home_dir)
    os.rename('{0}/zshrc.template'.format(base_home_dir),
              '{0}/.zshrc'.format(base_home_dir))
    cmd('chown {0}:{0} {1}/.zshrc'.format(username, base_home_dir))
    zsh = subprocess.check_output(shlex.split('which zsh'))
    cmd('usermod -s {0} {1}'.format(zsh, username))

def install(package):
    """ Installs the requested linux package """
    cache = apt.Cache()
    if not cache[package].is_installed:
        cmd('apt-get -y install {0}'.format(package))

def install_vim_plugins():
    print('Installing vim plugins...')
    vim_version =  subprocess.Popen(shlex.split('vim --version'), stdout=subprocess.PIPE)
    python_support = subprocess.check_output(shlex.split('grep +python'),stdin=vim_version.stdout)
    if not python_support:
        cmd('apt-get install -y vim-gnome')
    cmd('git clone https://github.com/gmarik/Vundle.vim.git \
            {0}/vim/bundle/Vundle.vim'.format(dotfiles_dir))
    cmd('vim -i NONE -c VundleUpdate -c quitall')
    print('Installing Powerline fonts...')
    fonts = '{0}/.fonts'.format(base_home_dir)
    font_config = '{0}/.fonts.conf.d'.format(base_home_dir)
    if not os.path.exists(fonts):
        os.makedirs(fonts)
    cmd('wget -qO {0}/PowerlineSymbols.otf \
            https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf'.format(fonts))
    cmd('fc-cache -vf {0}'.format(fonts))
    if not os.path.exists(font_config):
        os.makedirs(font_config)
    cmd('wget -qO {0}/10-powerline-symbols.conf \
            https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf'.format(font_config))
    cmd('chown -R {0}:{0} {1}/'.format(username, fonts))
    cmd('chown -R {0}:{0} {1}/'.format(username, font_config))



# Prepare environment
if os.path.isdir(dotfiles_dir):
    raise SystemExit('Aborting... a dotfiles directory exists')

cmd('apt-get update')
cmd('apt-get upgrade -y')

# Install Packages
install('git')
install('zsh')

# Download config files
dotfiles_repo = 'https://github.com/chirinosky/dotfiles.git'
cmd('git clone {0} {1}'.format(dotfiles_repo, dotfiles_dir))
cmd('chown -R {0}:{0} {1}'.format(username, dotfiles_dir))

# Set configs
configure_git()
configure_zsh()
configure_vim()
install_vim_plugins()
configure_gnome_terminal()
