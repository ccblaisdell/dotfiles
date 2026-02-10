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

# Show which git repo you're currently in
function git_repo_root
    set -l git_dir (git rev-parse --git-dir 2>/dev/null)
    if test -n "$git_dir"
        set -l repo_root (git rev-parse --show-toplevel 2>/dev/null)
        set -l remote (git config --get remote.origin.url 2>/dev/null)

        if test "$repo_root" = "$HOME"
            echo "📍 Home dotfiles repo"
        else if test "$repo_root" = "$HOME/.work"
            echo "💼 Work dotfiles repo"
        else
            echo "📁 Repo: $repo_root"
        end

        if test -n "$remote"
            echo "   Remote: $remote"
        end
    else
        echo "Not in a git repository"
    end
end

alias gr="git_repo_root"
alias where="git_repo_root"

# Set a variable to indicate which repo context we're in for the prompt
function set_git_context --on-variable PWD
    set -l git_dir (git rev-parse --git-dir 2>/dev/null)
    if test -n "$git_dir"
        set -l repo_root (git rev-parse --show-toplevel 2>/dev/null)
        if test "$repo_root" = "$HOME/.work"
            set -gx GIT_REPO_CONTEXT "work"
        else if test "$repo_root" = "$HOME"
            set -gx GIT_REPO_CONTEXT "home"
        else
            set -e GIT_REPO_CONTEXT
        end
    else
        set -e GIT_REPO_CONTEXT
    end
end

# Run once on startup
set_git_context

starship init fish | source

# Work stuff all goes in here!
test -f ~/.work/config.fish; and source ~/.work/config.fish
