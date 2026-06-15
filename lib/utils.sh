#!/usr/bin/env bash

get_tmux_option() {
    local option=$1
    local default_value=$2
    local option_value
    option_value=$(tmux show-option -gqv "$option")
    if [ -z "$option_value" ]; then
        echo "$default_value"
    else
        echo "$option_value"
    fi
}

normalize_padding() {
    percent_len=${#1}
    max_len=${2:-4}
    diff_len=$(( max_len - percent_len ))
    # if the diff_len is even, left will have 1 more space than right
    left_spaces=$(( (diff_len + 1) / 2 ))
    right_spaces=$(( diff_len / 2 ))
    printf "%${left_spaces}s%s%${right_spaces}s\n" "" "$1" ""
}

get_pane_dir() {
    tmux display-message -p -F "#{pane_current_path}" 2>/dev/null
}
