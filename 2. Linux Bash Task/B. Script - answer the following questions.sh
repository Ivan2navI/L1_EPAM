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
awk '{print $1}' apache_logs.txt | sort | uniq | sort -n

echo
echo "example_log.log =>"
awk '{print $1}' example_log.log | sort | uniq | sort -n
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


echo "---------------------------------------------------------------------------------"
echo "3. How many requests were there from each ip?" 
echo
echo "apache_logs.txt =>"
awk '{print $1}' apache_logs.txt | sort | uniq -c | sort -nr

echo
echo "example_log.log =>"
awk '{print $1}' example_log.log | sort | uniq -c | sort -nr
echo "---------------------------------------------------------------------------------"
echo


echo "---------------------------------------------------------------------------------"
echo "4. What non-existent pages were clients referred to?" 
echo
echo "apache_logs.txt =>"
cat apache_logs.txt | grep -v 'HTTP/1.0" 200' | grep -Eo "(http|https)://[a-zA-Z0-9./?=_%:-]*"

echo
echo "example_log.log =>"
cat example_log.log | grep -v 'HTTP/1.0" 200' | grep -Eo "(http|https)://[a-zA-Z0-9./?=_%:-]*"
echo "---------------------------------------------------------------------------------"
echo


echo "---------------------------------------------------------------------------------"
echo "5. What time did site get the most requests?" 
echo
echo "apache_logs.txt =>"
awk '{print $1, $4, $5}' apache_logs.txt | sort | uniq -c | sort -nr

echo
echo "example_log.log =>"
awk '{print $1, $4, $5}' example_log.log | sort | uniq -c | sort -nr
echo "---------------------------------------------------------------------------------"
echo


echo "---------------------------------------------------------------------------------"
echo "6. What search bots have accessed the site? (UA + IP) " 
# host yourdomain.com | cut -d ' ' -f 4 | curl ipinfo.io/$1
# awk '{print $1}' apache_logs.txt | sort | uniq -c | sort -nr | curl ipinfo.io/$1
# curl ipinfo.io/23.66.166.151
#curl https://ipinfo.io/212.115.253.100 | grep "UA"
#curl https://json.geoiplookup.io/212.115.253.100
#curl https://ipapi.co/212.115.253.100/json
# curl https://ipapi.co/212.115.253.100/country/

echo
echo "apache_logs.txt =>"

#cat apache_logs.txt | grep -Eo "[[:alpha:]]*bot\/([a-zA-Z0-9_\-\.]*)"
#cat apache_logs.txt | grep -Eo '([0-9]*\.){3}[0-9]*'
#cat apache_logs.txt | grep -Eo "(http|https)://[a-zA-Z0-9./?=_%:-]*" 

# 157.55.39.250 - - [30/Sep/2015:02:26:56 +0300] "GET /index/935/ HTTP/1.0" 200 10205 "-" "Mozilla/5.0 (compatible; bingbot/2.0
# Replace everything from "[" (must be \[) to "compatible"; with empty string:
#sed 's/\[.*compatible; //'
#    cat apache_logs.txt | grep 'HTTP\/1.0\" 200' | grep -Eo '(([0-9]*\.){3}[0-9]*)(.*)([[:alpha:]]*bot\/([a-zA-Z0-9_\-\.]*))((http|https)://[a-zA-Z0-9./?=_%:-]*)' | sed 's/\[.*compatible; //'
#!!!!

#cat apache_logs.txt | grep "HTTP\/1.0\" 200" | grep "[[:alnum:]].*ot" | sed 's/\[.*compatible; //' | sort -n | uniq 
cat apache_logs.txt | grep -v "HTTP\/1.0\" 4[0-9][0-9]" | grep "[[:alnum:]].*ot" | sed 's/\[.*compatible; //' | sort -n | uniq  #Find all BOT'S that not 400 

echo
echo "example_log.log =>"
awk '{print $1}' example_log.log | sort | uniq | sort -n
awk '{print $1}' example_log.log | sort | uniq | sort -n | grep 'HTTP/1.0" 200' | grep -Eo "(http|https)://[a-zA-Z0-9./?=_%:-]*" | grep "/bot."
#  cat example_log.log | grep 'HTTP/1.0" 200' | grep -Eo "(http|https)://[a-zA-Z0-9./?=_%:-]*" | grep "/bot."

echo "---------------------------------------------------------------------------------"
echo


#Специальные классы символов https://habr.com/ru/company/ruvds/blog/327896/

#В BRE имеются специальные классы символов, которые можно использовать при написании регулярных выражений:

#    [[:alpha:]] — соответствует любому алфавитному символу, записанному в верхнем или нижнем регистре.
#    [[:alnum:]] — соответствует любому алфавитно-цифровому символу, а именно — символам в диапазонах 0-9, A-Z, a-z.
#    [[:blank:]] — соответствует пробелу и знаку табуляции.
#    [[:digit:]] — любой цифровой символ от 0 до 9.
#    [[:upper:]] — алфавитные символы в верхнем регистре — A-Z.
#    [[:lower:]] — алфавитные символы в нижнем регистре — a-z.
#    [[:print:]] — соответствует любому печатаемому символу.
#    [[:punct:]] — соответствует знакам препинания.
#    [[:space:]] — пробельные символы, в частности — пробел, знак табуляции, символы NL, FF, VT, CR.
