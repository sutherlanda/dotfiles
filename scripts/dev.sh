#!/bin/bash

if [ $# -ne 2 ]; then
  echo "usage: dev session_name env_type";
  exit 1
fi

session=$1
env_type=$2

# Check if there is an existing session
tmux has-session -t $session 2> /dev/null

# Create a new session if one was not found
if [ $? != 0 ]
then
  tmux new-session -s $session -n ranger -d 'ranger'
  tmux new-window -t $session -n shell
  tmux select-window -t $session:1
fi

tmux attach-session -t $session
