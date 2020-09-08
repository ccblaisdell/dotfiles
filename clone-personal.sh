#!/bin/sh

echo "Cloning personal repositories..."

DEV=$HOME/dev

git clone git@github.com:ccblaisdell/dotfiles.git $DEV/dotfiles
git clone git@github.com:ccblaisdell/cyborg-brain.git $DEV/cyborg-brain
git clone git@github.com:ccblaisdell/colbyblaisdell.com.git $DEV/colbyblaisdell.com
