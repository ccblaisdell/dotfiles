# Config

export EDITOR="vim"
export GOKU_EDN_CONFIG_FILE="/Users/ccblaisdell/dev/dotfiles/karabiner.edn"

# asdf
. $HOME/.asdf/asdf.sh

# My aliases
source $HOME/.zsh_aliases
source $HOME/.spiff/.zsh_aliases

# Z
. /usr/local/etc/profile.d/z.sh

# native zsh autocomplete
autoload -Uz compinit && compinit

# fish like autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Make autosuggest colors look nicer in tmux
# https://github.com/zsh-users/zsh-autosuggestions/issues/229#issuecomment-300675586
export TERM=xterm-256color

# Probably needs to be last(-ish)
eval "$(starship init zsh)"

# Syntax highlighting must be last, so they say. we shall see
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

