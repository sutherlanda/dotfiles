#!/bin/bash

if [ "$#" -ne "1" ]; then
  echo "usage: dev-shell session";
  exit 1
fi

SESSION=$1

# Check if there is an existing session
tmux has-session -t $SESSION 2> /dev/null

# Create a new session if one was not found
if [ $? != 0 ]
then
  tmux new-session -s $SESSION -n ranger -d "ranger"
  tmux new-window -t $SESSION -n shell 
  tmux send-keys -t $SESSION:2 'clear' C-m
  tmux select-window -t $SESSION:1
fi

tmux attach-session -t $SESSION

