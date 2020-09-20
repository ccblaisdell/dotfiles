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

echo "Copying from dotfiles repo to HOME directory"
for file in "${files[@]}"
do
  cp "./$file" "$HOME/$file"
done
echo "Finished updating dotfiles!"

