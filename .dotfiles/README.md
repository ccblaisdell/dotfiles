# README

Right now this is mostly Mac-specific, but someday soon I will make it more linux-friendly!

## Work Configuration

This repo contains public/personal configurations. Work-specific configs live in a separate private repo at `~/.work`.

### Setup on New Machine

1. Clone and setup personal dotfiles:
```sh
cd ~
git init
git remote add origin git@github.com-ccblaisdell:ccblaisdell/dotfiles.git
git fetch
git checkout -f main
```

Add this to ~/.gitconfig

```yml
[include]
    path = ~/.gitconfig-common
# Work or personal stuff
```

```sh
# Set up work stuff if needed...
brew bundle --file ~/.dotfiles/Brewfile
```

2. Clone work repo (optional):
```sh
git clone git@git.soma.salesforce.com:cblaisdell/dotfiles.git ~/.work
brew bundle --file ~/.work/Brewfile
```

3. Set up mac preferences:
```sh
source ~/.dotfiles/.macos
```

### Extension Pattern

Personal configs automatically load work extensions via:
- **Fish**: sources `~/.work/config.fish` (line 62 of ~/.config/fish/config.fish)
- **Zsh**: sources `~/.work/.zshrc`
- **Git**: includes `~/.work/.gitconfig`
- **Neovim**: loads `~/.work/init-work.lua`
- **Tmux**: sources `~/.work/.tmux-work.conf`

### What Goes Where

**Personal repo (public):**
- Base configurations
- Personal preferences (themes, keybindings, aliases)
- Shared packages (Brewfile-core)

**Work repo (private):**
- Work credentials/keys
- Work email, signing keys
- Company tools (Falcon, DevOps CLI)
- Work aliases/scripts
- Work packages

### Adding New Files

To add something use git add --force:
```sh
git add -f .vimrc
```
