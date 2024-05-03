#!/bin/bash

if [ $# -ne 2 ]; then
	echo 'You need to enter 2 names of directories: input and output'
	exit 1
fi

input_dir=$1
output_dir=$2

mkdir -p "$output_dir"

find "$input_dir" -type f -print0 | while read -d $'\0' file; do
	filename=$(basename "$file")
	if [ -f "$output_dir/$filename" ]; then
		i=1
		while [ -f "$output_dir/$filename.$i" ]; do
			i=$((i+1))
		done
		filename="$i$filename"
	fi
	cp "$file" "$output_dir/$filename"
done
