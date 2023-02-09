#!/bin/bash -i
echo
echo "=========================================================="
echo "------------- Alias BEFORE -------------------------------"
    cat ~/.bashrc
echo "=========================================================="
echo
    echo "Updating ...."
echo
echo
    echo "alias grep='grep --color=auto'" >> ~/.bashrc
    echo "alias l='ls -CF'" >> ~/.bashrc
    echo "alias la='ls -A'" >> ~/.bashrc
    echo "alias ll='ls -alF'" >> ~/.bashrc
    echo "alias ls='ls --color=auto'" >> ~/.bashrc
    echo source ~/.bashrc

echo "=========================================================="
echo "------------- Alias AFTER -------------------------------"
    cat ~/.bashrc
echo "=========================================================="
source ~/.bashrc
exec bash