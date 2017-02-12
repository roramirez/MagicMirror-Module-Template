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
