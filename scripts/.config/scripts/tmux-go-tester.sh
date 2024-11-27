#!/bin/bash

curDir=`tmux display-message -p -F "#{pane_current_path}" -t0`
dirs=`cd $curDir && ls -Rd */*_test.go  | cut -d '/' -f 1 | sed 's/^/.\//g' | tr ' ' '\n'`

selected=`echo $dirs | tr ' ' '\n' | fzf`
echo $selected

# tmux neww bash -c "echo $curDir | less"
tmux neww bash -c "cd $curDir && go test $selected | less"
