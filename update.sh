#!/bin/sh

# Copy files from $HOME into here
source './files_to_sync.sh'

echo "Copying safelisted files from home to dotfiles"
for file in "${FILES[@]}"
do
  echo "$file"
  cp "$HOME/$file" "$HOME/dev/dotfiles/$file"
done

echo "Copying safelisted .config directories from home to dotfiles"
for dir in "${DIRS[@]}"
do
  echo "$dir"
  cp -R "$HOME/.config/$dir" "$HOME/dev/dotfiles/.config/"
done


echo "Finished updating dotfiles!"
