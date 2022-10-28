#!/bin/bash

clear

# Sometimes you need to pass a multiline text block to a command or variable. 
# Bash has a special type of redirect called Here document (heredoc) that allows you to do that

cat << EOF
# -----------------------------------------------------------------------------------------------------------
#						C. Script - Data backup.sh
# -----------------------------------------------------------------------------------------------------------
# C. Create a data backup script that takes the following data as parameters: 
#     1. Path to the syncing  directory. 
#     2. The path to the directory where the copies of the files will be stored. 
#
# In case of adding new or deleting old files, the script must add a corresponding entry to the log file 
# indicating the time, type of operation and file name. [The command to run the script must be added to 
# crontab with a run frequency of one minute] 
# -----------------------------------------------------------------------------------------------------------
EOF
echo


# ==================================== FUNCTIONS ====================================


# ==================================== ========= ====================================

# ====================================   MAIN    ====================================

# DATA info
backupdate=$(date +%Y%m%d%H%M%S)
echo $backupdate
echo "===================================================================="
echo


# ==================================== ========= ====================================


echo -n "Path for Source of Syncing: "
read Path_From
echo "Path to the syncing directory => $Path_From"

echo -n "Path to the Destination: "
read Path2Sync
echo "The path to the directory where the copies of the files will be stored => $Path2Sync"
echo "===================================================================="
echo

# ==================================== ========= ====================================

Backup_FileName=Data_backup_script_Control.txt

FILE=./$Backup_FileName

if [ -w $FILE ]; then
  # При проверке существования файла наиболее часто используются операторы FILE -e и -f . 
  # Первый проверит, существует ли файл независимо от типа, а второй вернет истину, 
  # только если ФАЙЛ является обычным файлом (а не каталогом или устройством).
  # -e file    Проверяет, существует ли файл.
  # -f file    Проверяет, существует ли файл, и является ли он файлом.
  # -w file    Проверяет, существует ли файл, и доступен ли он для записи.

  
  echo "$Backup_FileName exists, so Data backup was configureted."
  #echo
else 
  echo "$Backup_FileName creating ... Done!"
  echo "ARGUMENTS=> $backupdate" >> $Backup_FileName
  echo "Path for Source of Syncing: $Path_From" >> $Backup_FileName
  echo "Path to the Destination: $Path2Sync">> $Backup_FileName
  chmod +x $FILE
  echo  
fi