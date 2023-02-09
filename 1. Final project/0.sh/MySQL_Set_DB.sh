#!/bin/bash
clear

# First, navigate to the /tmp directory: cd /tmp
cd $HOME

echo
echo "=========================================================="
echo "Download the database to $HOME/trackizer_DB"
echo "=========================================================="
echo
# Download the database
      mkdir trackizer_DB
      wget https://raw.githubusercontent.com/Ivan2navI/L1_EPAM/main/1.%20Final%20project/.db/text_database -P ./trackizer_DB
      ls -alF ./trackizer_DB
echo "=========================================================="
echo
echo
echo "=========================================================="
echo "Inesert DB to MySQL"
echo "=========================================================="
echo
echo "mysql -u root -p < ./trackizer_DB/text_database > outputCreate.log"
echo "----------------------------------------------------------"       
      mysql -u root -p < ./trackizer_DB/text_database > ./trackizer_DB/outputCreate_trackizer.log
echo
echo "Create Dump of MySQL to HOME directory"
echo "----------------------------------------------------------" 
      cd $HOME
echo "Backup Directory:" 
      pwd
echo
      mysqldump -u root -p trackizer > ./trackizer_DB/trackizerDB_dump.sql
echo
echo "----------------------------------------------------------" 
      ls -alF ./trackizer_DB
echo "=========================================================="  
echo