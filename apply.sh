#!/bin/sh

# Copy files from here into $HOME
source './files_to_sync.sh'

echo "Copying from dotfiles repo to HOME directory"
for file in "${FILES[@]}"
do
  echo "$file"
  cp -R "./$file" "$HOME/$file"
done
echo "Finished updating dotfiles!"
