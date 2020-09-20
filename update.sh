#!/bin/sh

# Copy files from $HOME into here

files=(
  .gitconfig
  .gitignore
  .vimrc
  .zsh_aliases
  .zshrc
)

for file in "${files[@]}"
do
  bat "$HOME/$file"
done

