#!/bin/bash

clear

# Sometimes you need to pass a multiline text block to a command or variable. 
# Bash has a special type of redirect called Here document (heredoc) that allows you to do that

cat << EOF
# ---------------------------------------------------------------------------------
#						C. Script - Data backup.sh
# ---------------------------------------------------------------------------------
# C. Create a data backup script that takes the following data as parameters: 
#     1. Path to the syncing  directory. 
#     2. The path to the directory where the copies of the files will be stored. 
#
# In case of adding new or deleting old files, the script must add a corresponding 
# entry to the log file indicating the time, type of operation and file name. 
#
# [The command to run the script must be added to crontab 
# with a run frequency of one minute] 
# ---------------------------------------------------------------------------------
EOF
echo


# ==================================== FUNCTIONS ====================================

# DATA info
backupdate=$(date +%Y%m%d%H%M%S)
echo "===================================================================="
echo "Local TIME $backupdate"
echo "===================================================================="
echo


Backup_FileName=Backup_Setiings_for_C_Task.txt
FILE=./$Backup_FileName
Line1_Backup_Settings="Path to source:"
Line2_Backup_Settings="Path to destination:"

func_Backup_FileName_Create() {
  echo "===================================================================="
  echo "$Backup_FileName creating ... Done!"
  echo "Backup Setiings Create => $(date +%Y.%m.%d\ %Hh%Mm%Ss)" >> $Backup_FileName
  echo "$Line1_Backup_Settings $Path_From" >> $Backup_FileName
  echo "$Line2_Backup_Settings $Path2Sync">> $Backup_FileName
  chmod a+rw $FILE
  echo "===================================================================="
  echo
}


func_Path_2Sync_Directories_Create() {
  echo "===================================================================="
  echo -n "Path for Source of Syncing: "
  read Path_From
  
  until [ -d $Path_From ]
  do
    echo "$Path_From doesn't exist. Please, create this directory or enter correct path:"
    read Path_From
  done
  echo "$Line1_Backup_Settings => $Path_From"
  
  echo "--------------------------------------------------------------------"  
  
  echo -n "Path to Destination: "
  read Path2Sync
  
  until [ -d $Path2Sync ]
  do
    echo "$Path2Sync doesn't exist. Please, create this directory or enter correct path:"
    read Path2Sync
  done
  echo "$Line2_Backup_Settings => $Path2Sync" 
  
  echo "===================================================================="
  echo
  #exit
}

# ==================================== ========= ====================================

# ====================================   MAIN    ====================================

if [ -w $FILE ]; then
  # При проверке существования файла наиболее часто используются операторы FILE -e и -f . 
  # Первый проверит, существует ли файл независимо от типа, а второй вернет истину, 
  # только если ФАЙЛ является обычным файлом (а не каталогом или устройством).
  # -e file    Проверяет, существует ли файл.
  # -f file    Проверяет, существует ли файл, и является ли он файлом.
  # -w file    Проверяет, существует ли файл, и доступен ли он для записи.
  echo "===================================================================="  
  echo "$Backup_FileName exists, so Data backup was configureted."
  echo "===================================================================="
else 
  func_Path_2Sync_Directories_Create
  func_Backup_FileName_Create
  
fi
echo

# ==================================== ========= ====================================



# ==================================== ========= ====================================
