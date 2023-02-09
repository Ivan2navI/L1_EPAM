#!/bin/bash
echo
echo "=========================================================="
echo "------------- Install Git --------------------------------" 
echo "=========================================================="
git --version
echo "----------------------------------------------------------"
echo
echo "sudo apt update"
echo "----------------------------------------------------------"
sudo apt update
echo
echo "sudo apt install git"
echo "----------------------------------------------------------"
sudo apt install git -y
echo "=========================================================="
echo
echo
echo "=========================================================="
echo "------------- Setting Up Git -----------------------------" 
echo "=========================================================="
echo
echo "Enter you git name:"
echo "----------------------------------------------------------"
read git_name
  until [ ! -z "$git_name" ]
  do
    echo "Please, Enter you git name:"
    read git_name
  done
git config --global user.name $git_name
echo "git config --global user.name $git_name"
echo "----------------------------------------------------------"
echo

echo "Enter you git e-mail:"
echo "----------------------------------------------------------"
read git_mail
  until [ ! -z "$git_mail" ]
  do
    echo "Please, Enter you git e-mail:"
    read git_mail
  done
git config --global user.email $git_mail
echo "git config --global user.email $git_mail"
echo "----------------------------------------------------------"

echo
echo "Display all of the configuration items for Git"
echo "----------------------------------------------------------"
git config --list
echo "=========================================================="
echo