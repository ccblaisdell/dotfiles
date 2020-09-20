#!/bin/sh

# Copy files from $HOME into here
source './files_to_sync.sh'

echo "Copying from dotfiles repo to HOME directory"
for file in "${FILES[@]}"
do
  echo "$file"
  cp "./$file" "$HOME/$file"
done
echo "Finished updating dotfiles!"

