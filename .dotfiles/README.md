# README

Right now this is mostly Mac-specific, but someday soon I will make it more linux-friendly!

## How to set up a new machine

```sh
cd ~
git init
git remote add origin git@github.com:ccblaisdell/dotfiles.git
git fetch
git checkout -f main
```

Add this to ~/.gitconfig

```yml
[include]
    path = ~/.gitconfig-common
# Work or personal stuff
```

# Set up work stuff if needed...

# Install brew stuff
if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update
brew tap homebrew/bundle

## personal
brew bundle --file=~/.dotfiles/Brewfile-personal
## work
brew bundle --file=~/.work/Brewfile-work

# Set up mac preferences
source ~/.dotfiles/.macos
```

To add something just use git add --force

```sh
git add -f .vimrc
```
