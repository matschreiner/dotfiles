#!/bin/bash

for FILE in $(ls); do
	if [[ $FILE == *.symlink ]]

	then
		FILENAME=.${FILE%".symlink"}
		REALPATH=$(realpath $FILE)
		LINKNAME=../$FILENAME
		if [[ -e $LINKNAME ]]
		then
			if [[ -L $LINKNAME ]] 
			then
				echo "$FILENAME is already set up"	
			else
				echo "ERROR: $FILENAME already exists"
			fi
		else
			echo "Creating symlink for ${FILENAME%".symlink"}" 
			ln -s $REALPATH $LINKNAME
		fi

	fi	
done

echo
echo "Symlinks created to dotfiles"
