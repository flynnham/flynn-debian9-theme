#!/bin/bash

# Environment updater script for Debian 9+ environments
# Flynn Buckingham - April 2017

clear
sp="###"

read -p "$sp Overwrite i3 config? (Yy/*) " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	mkdir -p ~/.i3
	cp config/i3 ~/.i3/config
	# cp config/i3blocks ~/.i3blocks.conf
fi

read -p "$sp Reconfigure Xresources? (Yy/*)" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	# backup incase stuff goes terribly wrong
	touch ~/.Xresources # in case bash wants to get fussy about non-existing file
	cp ~/.Xresources ~/.Xresources.old

	# remove current configuration if present
	sed '/! @START-FLYNNCONFIG@/,/! @END-FLYNNCONFIG@/d' ~/.Xresources > tmp; mv tmp ~/.Xresources
	# append config to end of Xres
	cat config/xres >> ~/.Xresources
fi

read -p " $sp Reconfigure bashrc? (Yy/*)" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	# backup incase stuff goes terribly wrong
	cp ~/.bashrc ~/.bashrc.old

	# remove current configuration if present
	sed '/#@START-FLYNNCONFIG@/,/#@END-FLYNNCONFIG@/d' ~/.bashrc > tmp; mv tmp ~/.bashrc
	# append config to end of bashrc
	cat config/bash >> ~/.bashrc
fi
	

