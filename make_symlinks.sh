#!/bin/bash

for file in $(ls); do
	if [[ $file == *.symlink ]]
	then
		REALPATH=$(realpath $file)
		LINKNAME=../.${file%".symlink"}
		ln -s $REALPATH $LINKNAME
	fi	
done
