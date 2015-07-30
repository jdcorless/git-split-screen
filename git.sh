#!/bin/bash
# John D. Corless 2015-07-29
# Create terminal for Software Carpentry lesson
# to visualize working directory/index/repo in git
# Monitors changes to file ./planets/mars.txt
#
# This is inspired by this script
# http://blog.rgaiacs.com/_downloads/shell.sh
# from Rainere Silva

# Make sure directory and file exist
CWD=$(pwd)
DIRECTORY=../planets
FILE=mars.txt
if [ ! -d "$DIRECTORY" ]; then
  mkdir $DIRECTORY
fi
cd $DIRECTORY
echo "first line in mars.txt" > $FILE
git init

# Create the session to be used
# Target pane 0 will be where visualization is shown
# Target pane 1 will be where git commands are issued
tmux new-session -d -s swc
# Split the window horizontally
tmux split-window -v
# Move to directory with file to work on
#tmux send-keys -t 0 "cd planets" enter
tmux send-keys -t 0 "clear" enter
#tmux send-keys -t 1 "cd planets" enter
tmux send-keys -t 1 "clear" enter
# Run the script in parent directory
tmux send-keys -t 0 "ipython $CWD/git-demo.ipy $DIRECTORY/$FILE" enter
# Resize the log window to show the last five commands
# Need to use the number of lines desired + 1
#tmux resize-pane -t 0 -y 6

tmux attach-session
# Clean up after exiting tmux session
cd $CWD
rm -r $DIRECTORY
