#!/bin/sh

# Copy files from here into $HOME
source './files_to_sync.sh'

echo "Copying files from dotfiles repo to HOME directory"
for file in "${FILES[@]}"
do
  echo "$file"
  cp "./$file" "$HOME/$file"
done

echo "Copying directories from dotiles repo to HOME/.config directory"
for dir in "${DIRS[@]}"
do
  echo "$dir"
  cp -R "./.config/$dir" "$HOME/.config"
done

echo "Finished updating dotfiles!"
