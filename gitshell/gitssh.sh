#!/bin/bash

# save current params
currentPathShell=$(pwd)
sshPathShell="~/.ssh/"

# output text and go to ./ssh directory
echo "   # Start git ssh configuration..."
echo "   # Go to $sshPathShell"
cd $sshPathShell

echo "   # We are in [ $(pwd) ]"
echo "   # Attempt connection to git@github.com by ssh..."

# check github permissions
sshResult=$((ssh -T git@github.com) 2>&1)

# git config --global core.autocrlf true
# git config --global core.safecrlf true

# if denied, restart ssh agent and add id_rsa (or/and another rsa)
if [[ $sshResult == "Permission denied (publickey)." ]]
then
  echo "   # Failed: Permission denied (publickey)."
  echo "   # Reconfigure SSH Agent!"
  echo "   # Set agent..."
  eval "$(ssh-agent -s)"
  $(ssh-add id_rsa)
  echo "   # Check ssh key"
  ssh-add -l -E md5
  echo "   # Again attempt connection to git@github.com by ssh..."
  ssh -T git@github.com
else
  echo "true"
fi

# go back to current directory
echo "   # Return to [ $currentPathShell ]"
cd $currentPathShell

# finally test
echo "   # Check git clone..."
git clone git@github.com:chrislgarry/Apollo-11.git

exit "$?"
