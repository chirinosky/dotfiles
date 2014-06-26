""" This is the dotfiles installer """

import os
import subprocess


def install_curl():
    FNULL = open(os.devnull, 'w')
    curl = subprocess.call(
        ['which', 'curl'], stdout=FNULL, stderr=subprocess.STDOUT
    )
    if curl:
        print('Installing curl')
        subprocess.call(['sudo', 'apt-get', 'update'])
        subprocess.call(
            ['sudo', 'apt-get', '-y', 'install', 'curl'],
            stdout=FNULL, stderr=subprocess.STDOUT
        )
        print('Done')


def symlink_vim():
    pass


def main():
    symlink_vim()


if __name__ == '__main__':
    main()
