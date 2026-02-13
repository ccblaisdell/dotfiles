function ff
    set -l initial_query $argv[1]

    # Adaptive preview: right side if terminal is wide enough, otherwise top
    set -l cols (tput cols)
    if test $cols -ge 120
        set preview_position 'right,50%,border-left'
    else
        set preview_position 'up,60%,border-bottom'
    end

    rg --files | fzf --ansi \
        --query "$initial_query" \
        --preview 'bat --color=always --style=numbers --line-range=:500 {}' \
        --preview-window "$preview_position" \
        --bind 'enter:become($EDITOR {})'
end
