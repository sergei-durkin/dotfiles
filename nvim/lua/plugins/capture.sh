#!/bin/bash

pattern=$1

function capture_panes() {
    local pane captured
    captured=""

    for pane in $(tmux list-panes -as -F "#{pane_id} #{session_name}" | grep scratch); do
      captured+="$(tmux capture-pane -pJS - -t ${pane[0]})"
      captured+=$'\n'
    done

    echo "$captured" | grep -oiE "[.]*[\/]?([a-z\_\-]+\/)+[a-z.]+(.)*" | cut -d' ' -f1 | grep "$pattern" 
}

capture_panes
