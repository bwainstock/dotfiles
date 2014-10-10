#!/bin/sh

#Make sure files don't exist

rm /home/$USER/.bashrc 
rm /home/$USER/.vimrc 

ln -s /home/$USER/.dotfiles/dotfiles/bashrc /home/$USER/.bashrc
ln -s /home/$USER/.dotfiles/dotfiles/vimrc /home/$USER/.vimrc

#source /home/$USER/.bashrc
