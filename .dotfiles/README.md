# README

Right now this is mostly Mac-specific, but someday soon I will make it more linux-friendly!

## Work Configuration

This repo contains public/personal configurations. Work-specific configs live in a separate private repo at `~/.work`.

### Setup on New Machine

**IMPORTANT**: Before cloning repos, you must configure SSH and Git for multi-account support. See detailed instructions in [ssh_config.md](./ssh_config.md).

#### Quick Setup Summary

1. **Configure 1Password SSH Agent** (see [ssh_config.md](./ssh_config.md) for details):
   - Export public keys from 1Password to `~/.ssh/id_personal.pub` and `~/.ssh/id_work.pub`
   - Configure `~/.config/1Password/ssh/agent.toml`
   - Set up `~/.ssh/config` with host aliases

2. **Configure Git Identity Files**:
   - Create `~/.gitconfig-personal-identity` with personal email and signing key
   - Create `~/.gitconfig-personal-urls` with URL rewrite rule
   - See [ssh_config.md](./ssh_config.md) for exact file contents

3. **Clone personal dotfiles to home directory**:
   ```sh
   cd ~
   git init
   git remote add origin git@github-personal:ccblaisdell/dotfiles.git
   git fetch
   git checkout -f main
   ```

   Note: Uses `git@github-personal:` to ensure personal SSH key is used.

4. **Install packages**:
   ```sh
   brew bundle --file ~/.dotfiles/Brewfile
   ```

5. **Clone work repo** (optional):
   ```sh
   git clone git@git.soma.salesforce.com:cblaisdell/dotfiles.git ~/.work
   brew bundle --file ~/.work/Brewfile
   ```

6. **Set up macOS preferences**:
   ```sh
   source ~/.dotfiles/.macos
   ```

7. **Verify multi-account setup** (see [ssh_config.md](./ssh_config.md) for testing commands):
   ```sh
   # Test work directory uses work identity
   cd ~/dev && git config user.email

   # Test personal directory uses personal identity
   cd ~/personal && git config user.email
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

## SSH, Git, and 1Pass

See ssh_config.md

