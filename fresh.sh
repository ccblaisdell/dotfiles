#!/bin/sh

echo "Setting up your Mac..."

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# # Update Homebrew recipes
brew update

# # Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle
brew cleanup

mkdir $HOME/dev
DEV=$HOME/dev

# Clone github repos

echo "Cloning personal repositories..."

# git clone git@github.com:ccblaisdell/dotfiles.git $DEV/dotfiles
# git clone git@github.com:ccblaisdell/cyborg-brain.git $DEV/cyborg-brain
# git clone git@github.com:ccblaisdell/colbyblaisdell.com.git $DEV/colbyblaisdell.com

# Set macOS preferences
# We will run this last because this will reload the shell
source .macos
