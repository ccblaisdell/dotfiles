# 1. The Directory Structure

* Personal: ~/ (your dotfiles) and ~/Documents/personal/
* Work: ~/.work/ (work dotfiles) and ~/Documents/work/

# 2. Global Git Config (~/.gitconfig)

This file routes your identity based on your current folder. Order matters: the default (Personal) is at the top, and Work overrides are at the bottom.

```
[user]
    name = Your Name
    email = personal@email.com
    signingkey = <Paste_Personal_Public_Key_Here>

[gpg "ssh"]
    program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"

[commit]
    gpgsign = true

[gpg]
    format = ssh

# Include Work settings for specific directories
[includeIf "gitdir:~/Documents/work/"]
    path = ~/.gitconfig-work

[includeIf "gitdir:~/.work/"]
    path = ~/.gitconfig-work
```

# 3. Work Git Config (~/.gitconfig-work)

```
[user]
    email = cblaisdell@work.com
    signingkey = <Paste_Work_Public_Key_Here>
```

# 4. SSH Configuration (~/.ssh/config)

Since you are using IdentitiesOnly yes, you must have the public key files saved on your Mac so SSH knows what to "offer" to 1Password.

1. Open 1Password, select your Personal Key, and click Download/Export Public Key. Save it as ~/.ssh/id_personal.pub.
2. Do the same for your Work Key and save it as ~/.ssh/id_work.pub.

Update your config:

```
Host *
    IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    IdentitiesOnly yes
```

# 5. The "Handshake" Fix (The "Silver Bullet")

To stop the personal dotfiles from defaulting to your work identity, we will tell those specific repos exactly which public key file to present to the 1Password agent.

In your personal dotfiles (~/):

```
git config core.sshCommand "ssh -i ~/.ssh/id_personal.pub"
```

In your work dotfiles (~/.work/):

```
git config core.sshCommand "ssh -i ~/.ssh/id_work.pub"
```

# 6. Testing the Handshake

Now that the .pub files are in place, the commands will work without "Not accessible" errors:

* Test Personal: ssh -T -ai ~/.ssh/id_personal.pub git@github.com (Should say: "Hi ccblaisdell!")
* Test Work: ssh -T -ai ~/.ssh/id_work.pub git@github.com (Should say: "Hi cblaisdell_sfemu!")

Why this setup wins:

* agent.toml priority: Ensures your personal key is checked first by default.
* IdentitiesOnly: Prevents SSH from trying random keys that might "hit" the wrong account.
* core.sshCommand: Hard-codes the correct key pointer into your dotfiles repos so they never swap identities again.
