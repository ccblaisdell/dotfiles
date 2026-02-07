# README

Right now this is mostly Mac-specific, but someday soon I will make it more linux-friendly!

## How to

```sh
cd ~
git init
git remote add origin git@github.com:ccblaisdell/dotfiles.git
git fetch
git checkout -f main
```

To add something just use git add --force

```sh
git add -f .vimrc
```

## TODO:

- [ ] Check in files in home directory
- [ ] Figure out how to separate work stuff out of gh and git configs, then check them in
- [ ] Clean up .spiff repo
