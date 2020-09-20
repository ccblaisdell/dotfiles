#!/bin/sh

# Copy files from $HOME into here

files=(
  .gitconfig
  .gitignore
  .vimrc
  .zsh_aliases
  .zshrc
  tmux.conf
)

echo "Copying safelisted files from home to dotfiles"
for file in "${files[@]}"
do
  cp "$HOME/$file" "$HOME/dev/dotfiles/$file"
done
echo "Finished updating dotfiles!"

