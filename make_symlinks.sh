#!/bin/bash

create_symlinks(){
# $1 Target dir
# $2 Link dir

for FILE in $(ls $1); do

	if [[ $FILE == *.symlink ]]

	then
		TARGETPATH=$(realpath $1/$FILE)
		LINKNAME=.${FILE%".symlink"}
		LINKPATH=$2/$LINKNAME

		if [[ -e $LINKPATH ]]
		then # if linkpath exists
			if [[ -L $LINKPATH ]]
			then # linkpath is link
				if [[ $(realpath $LINKPATH) == $TARGETPATH ]]
				then
					echo "$LINKNAME is already set up properly"
				# code for recursion belonss here *
				fi
			fi
		else # if linkpath doesn't exist
			ln -s $TARGETPATH $LINKPATH
			echo "Set up link form $LINKNAME"
		fi
	fi
done
}

create_symlinks $HOME/.dotfiles $HOME
echo "Symlinks created to dotfiles"


# * CODE FOR RECURSION
# else # linkpath is not link
# 	if [[ -d $LINKPATH ]]
# 	then # If the linkpath is a dir we go recursively into that dir and copy
# 		create_symlinks $TARGETPATH $LINKPATH
# 	fi
