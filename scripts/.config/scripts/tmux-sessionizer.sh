#!/usr/bin/env bash

sessionDirs=$( find \
    ~/workspace/school \
    ~/workspace/Projects \
    ~/workspace/Learning/ \
    ~/.config \
    ~/Workspace \
    ~/Workspace/Leetcode \
    ~/Workspace/Projects/CS400 \
    ~/Obsidian \
    -mindepth 1 -maxdepth 1 -type d)
sessionLinks=$(find ~/.config -maxdepth 1 -type l)
session=$(printf "$sessionDirs\n$sessionLinks" | fzf)
session_name=$(basename "$session" | tr . _)

if tmux info &> /dev/null; then 
    if ! tmux has-session -t "$session_name" 2> /dev/null; then
        tmux new-session -s "$session_name" -c "$session" -d
    fi

    tmux switch-client -t "$session_name"
else
    if ! tmux has-session -t "$session_name" 2> /dev/null; then
        tmux new-session -s "$session_name" -c "$session" -d
    fi
    tmux attach-session -t $session_name
fi

