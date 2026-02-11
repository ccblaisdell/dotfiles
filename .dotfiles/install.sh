#!/bin/bash

IGNORE_FILE="$HOME/.dotfiles/.gitignore"

if [ -f "$IGNORE_FILE" ]; then
  echo "Setting up dotfiles git config"
  git config --local core.excludesFile "$IGNORE_FILE"
  chmod +x "$0"
  echo "Your dotfiles in home repo is now isolated from other repos"
else
  echo "Error: $IGNORE_FILE not found."
  exit 1
fi
