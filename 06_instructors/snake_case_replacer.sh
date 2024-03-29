#!/bin/bash

echo "Starting script to replace dashes with underscores"
dirlist=(`ls ./*`)

if [ ${#dirlist[@]} -eq 0 ]; then
  echo "No files in directory, exiting."
  exit 0
fi

for filename in ${dirlist[*]}
do
  mv "./$filename" `echo $filename | tr "-" "_" | tr "[:upper:]" "[:lower:]"`
done

echo "Finished."
