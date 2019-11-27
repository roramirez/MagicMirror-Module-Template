#!/bin/bash
#
# This script creates a module in base MagicMirror-Module template
# You can get a copy from https://github.com/roramirez/MagicMirror-Module-Template
#
#
# Manager Module Template
#
# By Rodrigo Ramìrez Norambuena https://rodrigoramirez.com
# MIT Licensed.
#

REPOSITORY_URL=https://github.com/roramirez/MagicMirror-Module-Template
YEAR=$(date +"%Y")

if ! [ -x "$(command -v git)" ]; then
	echo "Please install git"
	exit 1
fi

# check if a directory is the MM directory (checks for correct content of package.json)
is_mm_directory() {
	TEST_STRING="\"url\": \"git+https://github.com/MichMich/MagicMirror.git\""
	if grep -sq "$TEST_STRING" "$1/package.json"; then
		# it is correct
		return 0
	fi
	# wrong one
	return 1
}

MM_HOME=""
# check default directory
if is_mm_directory "$HOME/MagicMirror"; then
	MM_HOME="$HOME/MagicMirror"
fi

# check working directory
if is_mm_directory "."; then
	MM_HOME=$(cd "." && pwd)
fi

# check directory above working directory (i.e. in modules directory)
if is_mm_directory ".."; then
	MM_HOME=$(cd ".." && pwd)
fi

if [ -d "$MM_HOME" ] ; then
	echo "MagicMirror installation found in: $MM_HOME"
else
	echo "MagicMirror installation not found."
	read -p "Please input its path now (or restart script in its directory): " MM_HOME
fi

read -p "Insert your module name: " MODULE_NAME
if [ "$MODULE_NAME" = "" ]; then
	echo "No module name entered."
	exit 1
fi

DIRECTORY_DST="$MM_HOME/modules/$MODULE_NAME"

read -p "Do you want create in $DIRECTORY_DST (y/N) " choice
if [[ ! "$choice" =~ ^[Yy]$ ]]; then
	read -p "Insert destination module path: " DIRECTORY_DST
fi

if [ -d "$DIRECTORY_DST" ]; then
	echo "Warning!. The destination $DIRECTORY_DST exists"
	echo "To prevent override please rename destination directory"
	echo "or run again with another name module or destination path"
	exit 1
fi

# Author & Licenses
AUTHOR_NAME=$(git config user.name)
if [ -z "$AUTHOR_NAME" ]; then
	read -p "Insert your full name: " $AUTHOR_NAME
fi

read -p "Pickup a license
  1. MIT (Default)
  2. ISC
Choice: " LICENSE

case $LICENSE in
	[1] | [MIT] )
		LICENSE="MIT"
		;;
	[2] | [ISC] )
		LICENSE="ISC"
		;;
	* )
		LICENSE="MIT"
		;;
esac


echo "Type a short description of what your module does (leave empty to insert a Todo)"
read -p ": " $DESCRIPTION

if [ "$DESCRIPTION" = "" ]; then
	DESCRIPTION="Todo: Insert description here!"
fi


# Create temporal directory
TMPDIR=$(mktemp -d)
# Clone repository here
git clone $REPOSITORY_URL $TMPDIR


# Here add templates stuff
mkdir -p $DIRECTORY_DST

# copy the needed stuff
cp -a $TMPDIR/* $DIRECTORY_DST
# Copy dot files issue #4
cp -a $TMPDIR/.eslintrc.json $DIRECTORY_DST
cp -a $TMPDIR/.stylelintrc $DIRECTORY_DST


mv $DIRECTORY_DST/MagicMirror-Module-Template.js $DIRECTORY_DST/$MODULE_NAME.js
mv $DIRECTORY_DST/MagicMirror-Module-Template.css $DIRECTORY_DST/$MODULE_NAME.css
mv $DIRECTORY_DST/templates/licenses/$LICENSE $DIRECTORY_DST/LICENSE.txt
mv $DIRECTORY_DST/templates/CHANGELOG.md $DIRECTORY_DST/
mv $DIRECTORY_DST/templates/README.md $DIRECTORY_DST/
mv $DIRECTORY_DST/templates/package.json $DIRECTORY_DST/
rm -frv $DIRECTORY_DST/templates > /dev/null

# remove unneeded files
rm $DIRECTORY_DST/LICENSE          # Module-Template-License
rm $DIRECTORY_DST/create_module.sh # module creation script

# Based on https://stackoverflow.com/a/51060063
# Default case for Linux sed, just use "-i"
sedi=(-i)
case "$(uname)" in
  # For macOS, use two parameters
  Darwin*) sedi=(-i "")
esac

# Expand the parameters in the actual call to "sed"
sed "${sedi[@]}" -e s/\{\{MODULE_NAME\}\}/$MODULE_NAME/g $DIRECTORY_DST/*.*
sed "${sedi[@]}" -e s/\{\{AUTHOR_NAME\}\}/"$AUTHOR_NAME"/g $DIRECTORY_DST/*.*
sed "${sedi[@]}" -e s/\{\{LICENSE\}\}/$LICENSE/g $DIRECTORY_DST/*.*
sed "${sedi[@]}" -e s/\{\{YEAR\}\}/$YEAR/g $DIRECTORY_DST/*.*
sed "${sedi[@]}" -e s/\{\{DESCRIPTION\}\}/"$DESCRIPTION"/g $DIRECTORY_DST/*.*


cd $DIRECTORY_DST
git init

# Delete temporal directory
rm -frv $TMPDIR 2 > /dev/null

echo "Happy coding! Have fun you are an awesome developer :)"
echo "here your development directory $DIRECTORY_DST"
cd $DIRECTORY_DST
ls $DIRECTORY_DST