#!/bin/sh

echo "Setting up your Mac..."

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle
brew cleanup

mkdir $HOME/dev
DEV=$HOME/dev

# TODO:
# set up zsh
# sudo chsh -s /usr/local/bin/zsh
# # asdf
# . $HOME/.asdf/asdf.sh
#
# source $HOME/.zsh_aliases
#
# # native zsh autocomplete
# autoload -Uz compinit && compinit
#
# # fish like autosuggestions
# source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
#
# # Probably needs to be last(-ish)
# eval "$(starship init zsh)"
#
# # Syntax highlighting must be last, so they say. we shall see
# source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Set macOS preferences
# We will run this last because this will reload the shell
source .macos
