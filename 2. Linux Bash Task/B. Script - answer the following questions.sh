#!/bin/bash

clear

# Sometimes you need to pass a multiline text block to a command or variable. 
# Bash has a special type of redirect called Here document (heredoc) that allows you to do that

cat << EOF
---------------------------------------------------------------------------------			
                  В. Script - answer the following questions
---------------------------------------------------------------------------------
B. Using Apache log example create a script to answer the following questions: 
    1. From which ip were the most requests?  
    2. What is the most requested page?  
    3. How many requests were there from each ip?  
    4. What non-existent pages were clients referred to?  
    5. What time did site get the most requests?  
    6. What search bots have accessed the site? (UA + IP) 
---------------------------------------------------------------------------------
EOF
echo


echo "---------------------------------------------------------------------------------"
echo "1. From which ip were the most requests?" 
echo
echo "apache_logs.txt =>"
awk '{print $1}' apache_logs.txt | sort | uniq -c | sort -nr

echo
echo "example_log.log =>"
awk '{print $1}' example_log.log | sort | uniq -c | sort -nr
echo "---------------------------------------------------------------------------------"
echo


echo "---------------------------------------------------------------------------------"
echo "2. What is the most requested page?" 
echo
echo "apache_logs.txt =>"
cat apache_logs.txt | grep -Eo "(http|https)://[a-zA-Z0-9./?=_%:-]*" | sort | uniq -c | sort -nr | head -n 1
echo
echo "example_log.log =>"
cat example_log.log | grep -Eo "(http|https)://[a-zA-Z0-9./?=_%:-]*" | sort | uniq -c | sort -nr | head -n 1

#    grep -E : is the same as egrep
#    grep -o : only outputs what has been grepped
#    (http|https) : is an either / or
#    a-z : is all lower case
#    A-Z : is all upper case
#    . : is dot
#    / : is the slash
#    ? : is ?
#    = : is equal sign
#    _ : is underscore
#    % : is percentage sign
#    : : is colon
#    - : is dash
#    *: is repeat the [...] group
#    sort -u : will sort & remove any duplicates

echo "---------------------------------------------------------------------------------"
echo

