#!/bin/bash

create_symlinks(){
# $1 Target dir
# $2 Link dir

for FILE in  $(ls $1); do

	if [[ $FILE == *.symlink ]]; then # File should be symlinked
		TARGETPATH=$(realpath "$1"/"$FILE")
		LINKNAME=${FILE%".symlink"}
		LINKNAME=${LINKNAME/"dot."/"."}
		LINKPATH="$2"/"$LINKNAME"

		if [[ -d "$TARGETPATH" ]]; then # if file is a dir
			echo "$TARGETPATH is dir and should be copied to $LINKNAME"

			if [[ ! -e "$LINKPATH" ]]; then
				mkdir "$LINKPATH"
			fi

			create_symlinks "$TARGETPATH" "$LINKPATH"


		elif [[ -e "$LINKPATH" ]]; then # if linkpath exists
			if [[ -L "$LINKPATH" ]]; then # linkpath is link
				if [[ $(realpath "$LINKPATH") == "$TARGETPATH" ]]; then
					echo "$LINKNAME is already set up properly"
				# code for recursion belonss here *
				fi
			fi
		else # if linkpath doesn't exist
			ln -s "$TARGETPATH" "$LINKPATH"
			echo "Symlink set up for $LINKNAME"
		fi
	fi
done
}

create_symlinks "$HOME"/dotfiles "$HOME"
echo "Symlinks created to dotfiles"
