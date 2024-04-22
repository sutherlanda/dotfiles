#!/bin/bash

# Create and attach a new tmux session with optional name, path, and window.
# defaults: session named 'new' in ${HOME} as working dir with window named 'shell'

# Usage
# $ session
# $ session session-name
SESSION_NAME="${1:-new}"
SESSION_DIR=${2}

# Check if the session directory exists
if [ ! -d "$SESSION_DIR" ]
then
  echo "Directory does not exist: $SESSION_DIR"
  exit 1
fi

# Check if there is an existing session
tmux has-session -t $SESSION_NAME 2> /dev/null

# Create a new session if one was not found
if [ $? != 0 ]
then
  echo "Creating new session: $SESSION_NAME"
  tmux new-session -d -s $SESSION_NAME -c $SESSION_DIR -n "main" "direnv exec . $SHELL"
fi

tmux attach-session -t $SESSION_NAME

