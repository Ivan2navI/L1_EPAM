https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token

git remote add origin git@github.com:Ivan2navI/bash_epam.git

git remote add origin https://github.com/Ivan2navI/bash_epam.git

Username: your_username
Password: your_token

-------------------------------------------------
1. Configure local GIT

Once we have a token, we need to configure the local GIT client with a username and email address. 
On a Linux machine, use the following commands to configure this, replacing the values in the brackets with your username and email.

git config --global user.name ""
git config --global user.email ""
git config -l

-------------------------------------------------
2. Setup Git Username and Password Credentials 
!!(OR LOOK to the next step - 3)!!

If you don’t set up or configure username and password, git will ask you to enter username and password every time you try to pull or push the code. This will be really frustrating.
If you want to avoid providing a username and password every time, you can just store that username and password.

git config --global credential.helper store

Now when you try to connect to the remote repo, you will be asked for the username and password. This time your username and password will be saved so that you don’t need to provide a username and password again.
Note: This command saves the username and password in plain text format on your disk.
You can check the configuration in the file ~/.gitconfig.

vi ~/.gitconfig

The username and password will be saved in the file ~/.git-credentials. in the format

https://git-user:git-password@domain.xxx

You can check that with the command
vi ~/.git-credentials

You can also opt for cache to store the username and password instead of disk.

git config --global credential.helper cache

This is more secure than storing credentials on a disk.

---------------------------------------
3. Set Origin URL

This is an alternative step to step 2.

You can also set the origin URL for your remote git access.


git remote set-url origin <new_git_repo_url_with_toekn>

git remote set-url origin https://fgfdgfdg_344545566ssddfgffg_example___@github.com/Ivan2navI/bash_epam.git

The format for the new_git_repo_url_with_toekn is

https://<personal_git_acess_toekn>@<git_repo_url>

Some of the related articles I have written and you might like reading them.

===============================================================================

echo "# DIRECTORY_NAME" >> README.md

  git init
  
  git add README.md
  
  git commit -m "first commit"
  
  git branch -M main
  
  git remote add origin https://github.com/NAME/DIRECTORY.git
  
  git push -u origin main
  

  git add -A
  
  git commit -m "first commit"
  
  git push --all

======================================================================

  $ git init
  
  $ git add .
  
  $ git commit -m "Initial commit"
  
  $ git remote add origin https://github.com/dfdfn/second-site.git
  
  $ git push -u origin master

https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token

Username: your_username
Password: your_token

=====================================
GIT шпаргалка
1. https://webdevkin.ru/courses/git/git-commit

2. https://www.atlassian.com/ru/git/tutorials/learn-git-with-bitbucket-cloud

3. https://nuancesprog.ru/p/3598/

[![Alt text](https://github.com/Ivan2navI/bash_epam/blob/master/!!%20--%20info%20--%20!!/GIT%20commands.jpg)] (#"Optional title")
