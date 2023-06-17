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

# McFly history search
eval "$(mcfly init zsh)"

# native zsh autocomplete
autoload -Uz compinit && compinit

# google cloud CLI autocomplete
source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

# fish like autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Make autosuggest colors look nicer in tmux
# https://github.com/zsh-users/zsh-autosuggestions/issues/229#issuecomment-300675586
export TERM=xterm-256color

# Direnv hook
eval "$(direnv hook zsh)"

# Probably needs to be last(-ish)
eval "$(starship init zsh)"

# Syntax highlighting must be last, so they say. we shall see
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PATH="/usr/local/sbin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ccblaisdell/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/ccblaisdell/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/ccblaisdell/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/ccblaisdell/google-cloud-sdk/completion.zsh.inc'; fi
