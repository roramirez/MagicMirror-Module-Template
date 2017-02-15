#!/bin/sh
#
# This script create a module in base e MagicMirror-Module template
# You can get a copy from https://github.com/roramirez/MagicMirror-Module-Template
#
#
# Manager Module Template
#
# By Rodrigo Ramìrez Norambuena https://rodrigoramirez.com
# MIT Licensed.
#

REPOSITORY_URL=https://github.com/roramirez/MagicMirror-Module-Template

if ! [ -x "$(command -v git)" ]; then
	echo "Please install git"
	exit 1
fi

read -p "Insert your module name? " MODULE_NAME

DIRECTORY_DST="/home/pi/MagicMirror/modules/$MODULE_NAME"
read -p "Do you want create in $DIRECTORY_DST (y/n) " choice
if [[ ! $choice =~ ^[Yy]$ ]]
then
	read -p "Insert destination module path " DIRECTORY_DST
fi

# Create temporal directory
TMPDIR=$(mktemp -d)
# Clone repository here
git clone $REPOSITORY_URL $TMPDIR


# Here add templates stuff
mkdir -p $DIRECTORY_DST
cp -a $TMPDIR/* $DIRECTORY_DST

cd $DIRECTORY_DST
git init

# Delete temporal directory
rm -frv $TMPDIR 2 > /dev/null
