#!/usr/bin/env bash

languages=$(echo -e "go lua rust c cpp typescript js html css nodejs python bash htmx" | tr ' ' '\n')
core_utils=$(echo -e "xargs find sed awk tmux" | tr ' ' '\n')
selected=$(echo -e "$languages\n$core_utils" | fzf)

read -p "Query: " query

if echo "$languages" | grep -qs $selected; then
    tmux neww bash -c "curl cht.sh/$selected/$(echo "$query" | tr " " "+") | bat"
else
    
    tmux neww bash -c "curl cht.sh/$selected~"$query") | bat"
fi
