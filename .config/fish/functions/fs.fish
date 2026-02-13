function fs
    set -l initial_query $argv[1]

    # Adaptive preview: right side if terminal is wide enough, otherwise top
    set -l cols (tput cols)
    if test $cols -ge 120
        set preview_position 'right,50%,border-left,+{2}+3/3,~3'
    else
        set preview_position 'up,60%,border-bottom,+{2}+3/3,~3'
    end

    fzf --ansi \
        --disabled \
        --query "$initial_query" \
        --bind "change:reload:rg --color=always --line-number --no-heading --smart-case {q} || true" \
        --bind "start:reload:rg --color=always --line-number --no-heading --smart-case {q} || true" \
        --color "hl:-1:underline,hl+:-1:underline:reverse" \
        --delimiter : \
        --preview 'bat --color=always {1} --highlight-line {2}' \
        --preview-window "$preview_position" \
        --bind 'enter:become($EDITOR {1}:{2})'
end
