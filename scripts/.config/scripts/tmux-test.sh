#!/bin/bash

curDir=`tmux display-message -p -F "#{pane_current_path}" -t0`
echo $curDir
