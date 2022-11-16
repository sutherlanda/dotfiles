#!/bin/bash

# Create and attach a new tmux session with optional name, path, and window.
# defaults: session named 'new' in ${HOME} as working dir with window named 'shell'

# Usage
# $ session
# $ session session-name
# $ session session-name session-directory window-name
session_name="${1:-new}"
session_dir=${2:-~/}
session_window="${3:-main}"

# Check if there is an existing session
tmux has-session -t $session_name 2> /dev/null

# Create a new session if one was not found
if [ $? != 0 ]
then
  tmux new-session -d -s ${session_name} -c ${session_dir} -n ${session_window}  "direnv exec . $SHELL"
fi

tmux attach-session -t ${session_name}

