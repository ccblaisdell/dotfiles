#!/bin/sh

# Copy files from $HOME into here
source './files_to_sync.sh'

echo "Copying safelisted files from home to dotfiles"
for file in "${FILES[@]}"
do
  echo "$file"
  cp -R "$HOME/$file" "$HOME/dev/dotfiles/$file"
done
echo "Finished updating dotfiles!"

