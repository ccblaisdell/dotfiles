# Config

export EDITOR="vim"
export GOKU_EDN_CONFIG_FILE="/Users/ccblaisdell/dev/dotfiles/karabiner.edn"

# asdf
. "$HOME/.asdf/asdf.sh"
# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

# My aliases
source $HOME/.zsh_aliases
source $HOME/.spiff/.zsh_aliases

# Z
. /opt/homebrew/etc/profile.d/z.sh

# native zsh autocomplete
autoload -Uz compinit && compinit

# Fish-like autosuggestions
# https://github.com/zsh-users/zsh-autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Make autosuggest colors look nicer in tmux
# https://github.com/zsh-users/zsh-autosuggestions/issues/229#issuecomment-300675586
export TERM=xterm-256color

# Direnv hook
eval "$(direnv hook zsh)"

# Probably needs to be last(-ish)
eval "$(starship init zsh)"

export PATH="/usr/local/sbin:$PATH"
