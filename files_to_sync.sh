#!/bin/sh

# Copy files from $HOME into here

FILES=(
  .tmux.conf
  .vimrc
  .zsh_aliases
  .zshrc
  .config/starship.toml
)

# Config directories, prefixed with ~/.config/
DIRS=(
  helix
  iterm2
  nvim
  ranger
  raycast
)
