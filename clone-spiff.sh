#!/bin/sh

echo "Cloning Spiff repositories..."

DEV=$HOME/dev

git clone git@github.com:SpiffInc/spiff_ex.git $DEV/spiff_ex
git clone git@github.com:SpiffInc/spiff_react.git $DEV/spiff_react
git clone git@github.com:SpiffInc/spiff_rb.git $DEV/spiff_rb
