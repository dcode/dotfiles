#!/bin/bash

params="-sf"

while getopts "vib" args; do
    case $args in
        v)
            params="$params -v"
            ;;
        i)
            params="$params -i"
            ;;
        b)
            params="$params -b"
            ;;
    esac
done

# Store where the script was called from so we can reference it later
script_home="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Update bash-it if it's already installed or download it if it's not
if [ -d $HOME/.bash_it ]; then
  cd $HOME/.bash_it
  git pull
else
  git clone --depth=1 https://github.com/Bash-it/bash-it.git $HOME/.bash_it
fi

# Add our custom aliases to bash-it
ln $params $script_home/custom.aliases.bash $HOME/.bash_it/aliases/custom.aliases.bash

# Add custom plugins to bash-it
for item in bash_plugins/*.bash; do
    ln -s $params $item ~/.bash_it/custom/
done

# Add Dustin's syntax highlights for Bro
for i in ftdetect syntax; do
    if [ ! -f $HOME/.vim/$i/bro.vim ]; then
        curl -fLo $HOME/.vim/$i/bro.vim --create-dirs \
        https://raw.githubusercontent.com/mephux/bro.vim/master/$i/bro.vim
    fi
done

# Add solarized colors for vim if not present
if [ ! -f $HOME/.vim/colors/solarized.vim ]; then
    curl -fLo $HOME/.vim/colors/solarized.vim --create-dirs \
    https://raw.githubusercontent.com/altercation/vim-colors-solarized/master/colors/solarized.vim
fi

# Symlink all of our dotfiles to the home directory
for i in .vimrc .dircolors;
do
  ln $params $script_home/$i $HOME/$i
done

# Adjust the .bashrc path if we're running on OSX
if [[ $OSTYPE == darwin* ]]; then
  ln $params $script_home/.bashrc $HOME/.bash_profile
else
  ln $params $script_home/.bashrc $HOME/.bashrc
fi

# Install pythonpy
#pip install https://github.com/Russell91/pythonpy/archive/master.tar.gz
