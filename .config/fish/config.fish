if status is-interactive
    # Commands to run in interactive sessions can go here
    # TODO: Still need this if we use onepass for ssh?
    ssh-add --apple-load-keychain
end

# Ensure homebrew is loaded so everything it installs is available
set brewcmd (path filter /opt/homebrew/bin/brew /usr/local/bin/brew)[1]
and $brewcmd shellenv | source

# ASDF configuration code
if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# NOTE: Temporarily disabling this bc in tmux for some reason asdf shims
# are already in the path and therefore don't get prepended, causing the
# shims to be overridden by homebrew.
# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
# if not contains $_asdf_shims $PATH
#     set -gx --prepend PATH $_asdf_shims
# end
set -gx --prepend PATH $_asdf_shims
set --erase _asdf_shims

export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export EDITOR="hx"
export ZK_NOTEBOOK_DIR="/Users/ccblaisdell/dev/cyborg-brain"

# Direnv hook
direnv hook fish | source

# Utils
alias ls='eza'
alias mux='tmuxinator'
alias tf='terraform'
alias vim="nvim"
alias y='yazi'

# Pipe rg into delta for paging
function rgg
    rg --json $argv | delta
end

# Git

alias cof="git for-each-ref --sort=-committerdate --format='%(refname:short)' refs/heads | fzf --reverse --height 35% --nth 1 | awk '{print $1}' | xargs git checkout"
alias gg="cof"

function git_delete_branches_grep
    git branch -D $(git branch | string trim | grep $argv[1])
end

alias gbd="git_delete_branches_grep"

starship init fish | source

# Work stuff all goes in here!
source ~/.work/config.fish
