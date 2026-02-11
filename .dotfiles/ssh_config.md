# Multi-Account SSH + Git Setup with 1Password

This guide explains how to configure your machine for seamless multi-account git operations using 1Password SSH agent, SSH host aliasing, and conditional git includes.

## Overview

The setup isolates personal and work GitHub accounts using three mechanisms:
1. **SSH Host Aliasing**: Different SSH hosts (`github.com` vs `github-personal`) route to different keys
2. **Git URL Rewriting**: Personal repos transparently rewrite URLs to use the personal SSH host
3. **Conditional Git Includes**: Git identity and URL rewrites apply based on directory context

## Directory Structure

- **Personal repos**: `~/` (dotfiles), `~/personal/*`
- **Work repos**: `~/dev/*`, `~/.work/`, `~/.yak/`

## Step 1: Export SSH Public Keys from 1Password

Since we use `IdentitiesOnly yes`, SSH needs public key files to tell 1Password which key to use.

1. Open 1Password and find your **Personal SSH Key**
2. Click "Download/Export Public Key"
3. Save as `~/.ssh/id_personal.pub`
4. Repeat for your **Work SSH Key** (Auth Key)
5. Save as `~/.ssh/id_work.pub`

Verify both files exist:
```bash
ls -la ~/.ssh/id_*.pub
```

## Step 2: Configure 1Password SSH Agent

Edit `~/.config/1Password/ssh/agent.toml`:

```toml
# Order determines which key is tried first (work is most common)
# 1. Work GitHub key
[[ssh-keys]]
item = "Auth Key"
vault = "Employee"

# 2. Personal GitHub key
[[ssh-keys]]
item = "Personal SSH Key"
vault = "Employee"
```

## Step 3: Configure SSH

Create/update `~/.ssh/config`:

```ssh-config
# Personal GitHub (use alias for personal repos)
Host github-personal
	HostName github.com
	IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
	IdentityFile ~/.ssh/id_personal.pub
	IdentitiesOnly yes

# Work GitHub (default)
Host github.com
	HostName github.com
	IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
	IdentityFile ~/.ssh/id_work.pub
	IdentitiesOnly yes

Host *
	IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
	IdentitiesOnly yes
```

**Key Points:**
- `IdentitiesOnly yes` forces SSH to use ONLY the specified key
- `github-personal` is an alias that routes to github.com but uses personal key
- Default `github.com` uses work key

## Step 4: Create Git Configuration Files

### 4a. Personal Identity (`~/.gitconfig-personal-identity`)

```gitconfig
[user]
	email = ccblaisdell@gmail.com
	signingkey = ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGdrSTsqFJJ/1jxTCyUWK7AMBgm5bHsvhkUNwGNzzW+p
[gpg "ssh"]
  program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"
```

### 4b. Personal URL Rewriting (`~/.gitconfig-personal-urls`)

```gitconfig
[url "git@github-personal:"]
	insteadOf = git@github.com:
```

### 4c. Work Identity (`~/.work/.gitconfig`)

See the work dotfiles README for this configuration.

## Step 5: Configure Main Git Config

Edit `~/.gitconfig` to include these sections:

```gitconfig
[user]
	name = Colby Blaisdell

[gpg]
	format = ssh

[commit]
	gpgsign = true

# Contextual overrides
# Personal identity by default for all of ~/
[includeIf "gitdir:~/"]
    path = ~/.gitconfig-personal-identity

# Work overrides (identity only) for specific work directories
[includeIf "gitdir:~/dev/"]
    path = ~/.work/.gitconfig
[includeIf "gitdir:~/.work/"]
    path = ~/.work/.gitconfig
[includeIf "gitdir:~/.yak/"]
    path = ~/.work/.gitconfig

# Personal URL rewrites for personal repos only
# Match home directory repo specifically (not subdirectories)
[includeIf "gitdir:~/.git"]
    path = ~/.gitconfig-personal-urls
[includeIf "gitdir:~/personal/"]
    path = ~/.gitconfig-personal-urls
```

## How It Works

### Work Repository Flow
```bash
cd ~/dev
git clone git@github.com:spiff-emu/yak.git
```

1. Git config: Work identity applied (due to `includeIf "gitdir:~/dev/"`)
2. Remote URL: `git@github.com:spiff-emu/yak.git` (no rewrite)
3. SSH: Matches `Host github.com` → uses `id_work.pub`
4. 1Password: Provides work private key
5. ✅ Work credentials authenticate successfully

### Personal Repository Flow
```bash
cd ~/personal
git clone git@github.com:ccblaisdell/my-repo.git
```

1. Git config: Personal identity + URL rewrite applied
2. Remote URL: `git@github.com:ccblaisdell/my-repo.git`
3. URL Rewrite: Transforms to `git@github-personal:ccblaisdell/my-repo.git`
4. SSH: Matches `Host github-personal` → uses `id_personal.pub`
5. 1Password: Provides personal private key
6. ✅ Personal credentials authenticate successfully

### Home Directory Dotfiles
```bash
cd ~  # Home directory is the git repo
git pull
```

1. Git config: Personal identity + URL rewrite (matches both `gitdir:~/` and `gitdir:~/.git`)
2. SSH: Routes through `github-personal` host
3. ✅ Personal credentials used automatically

## Testing Your Setup

### Test 1: Git Config Resolution

```bash
# Work directory - should show work identity, NO URL rewrite
cd ~/dev
git config user.email  # Expected: cblaisdell@salesforce.com
git config --get-regexp 'url\..*\.insteadof'  # Expected: (no output)

# Personal directory - should show personal identity AND URL rewrite
cd ~/personal
git config user.email  # Expected: ccblaisdell@gmail.com
git config --get-regexp 'url\..*\.insteadof'  # Expected: url.git@github-personal:.insteadof

# Home directory - should show personal identity AND URL rewrite
cd ~
git config user.email  # Expected: ccblaisdell@gmail.com
git config --get-regexp 'url\..*\.insteadof'  # Expected: url.git@github-personal:.insteadof
```

### Test 2: SSH Key Selection

```bash
# Test work key (should offer only id_work.pub)
GIT_SSH_COMMAND="ssh -v" git ls-remote git@github.com:spiff-emu/yak.git 2>&1 | grep -i "offering"

# Test personal key (should offer only id_personal.pub)
GIT_SSH_COMMAND="ssh -v" git ls-remote git@github-personal:ccblaisdell/dotfiles.git 2>&1 | grep -i "offering"
```

### Test 3: Actual Cloning

```bash
# Clone work repo - should succeed
git clone git@github.com:spiff-emu/yak.git /tmp/test-work

# Clone personal repo - should succeed
git clone git@github.com:ccblaisdell/dotfiles.git /tmp/test-personal

# Clean up
rm -rf /tmp/test-work /tmp/test-personal
```

## Troubleshooting

### "Repository not found" for work repos
- Check that you're NOT in a directory with personal URL rewrite
- Verify: `git config --get-regexp 'url\..*\.insteadof'` should show nothing in work dirs

### Wrong identity in commits
- Verify conditional includes: `git config --show-origin user.email`
- Check that work directories are listed correctly in `~/.gitconfig`

### SSH offering wrong key
- Verify public key files exist: `ls -la ~/.ssh/id_*.pub`
- Check SSH config has correct `IdentityFile` paths
- Ensure `IdentitiesOnly yes` is set for both hosts

## Why This Works

The combination of URL rewriting, SSH host aliasing, and `IdentitiesOnly yes` provides perfect isolation:

1. **URL Rewrite**: Only applies in personal directories, transforming `github.com` → `github-personal`
2. **SSH Host**: Different hosts route to different `IdentityFile` directives
3. **IdentitiesOnly**: Prevents SSH from trying multiple keys, ensures correct account every time
4. **1Password Integration**: The agent seamlessly provides the requested key without storing private keys on disk
