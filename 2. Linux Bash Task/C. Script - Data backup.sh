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


Path_Config=".config_Script_Data_backup"
Backup_FileName=Backup_Setiings_for_C_Task.txt
LOGFILE=logs_sync_path_from2to.log
LOGDATA=$(date +%Y%m%d_%H%M%S)
for_log_file_info=$Path_Config/$LOGFILE
  
FILE=./$Path_Config/$Backup_FileName

Line1_Backup_Settings="Path to source:"
Line2_Backup_Settings="Path to destination:"

func_Backup_and_LOG_File_Create() {
  echo "===================================================================="
  mkdir $Path_Config
  chmod a+rwx $Path_Config
  cd $Path_Config

  echo "Backup Setiings Create => $(date +%Y.%m.%d\ %Hh%Mm%Ss)" >> $Backup_FileName
  echo "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^" >> $Backup_FileName
  echo "$Line1_Backup_Settings $Path_From" >> $Backup_FileName
  echo "$Line2_Backup_Settings $Path2Sync">> $Backup_FileName
  chmod a+rwx $Backup_FileName
  
  echo "$(date +%Y%m%d_%H%M%S) == LOGFILE create at: $(pwd)/$LOGFILE">> $LOGFILE
  chmod a+rwx $LOGFILE
  echo "$(pwd)/$LOGFILE creating ... Done!"  
  
  touch list_files_in_FROM.txt
  chmod a+rwx list_files_in_FROM.txt
  
  echo "$LOGDATA == touch list_files_in_FROM.txt">> $LOGFILE
  
  touch list_files_in_TO.txt
  chmod a+rwx list_files_in_TO.txt
  echo "$LOGDATA == touch list_files_in_TO.txt">> $LOGFILE
  echo "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^" >> $LOGFILE
  
  echo "List files in TO path: $(pwd)/list_files_in_FROM.txt">> $Backup_FileName
  echo "List files in FROM path: $(pwd)/list_files_in_TO.txt">> $Backup_FileName
  echo "LOGFILE create at: $(pwd)/$LOGFILE">> $Backup_FileName
  echo "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^" >> $Backup_FileName
  echo "Backup Setiings Done => $(date +%Y.%m.%d\ %Hh%Mm%Ss)" >> $Backup_FileName

  echo "$(pwd)/$Backup_FileName creating ... Done!"
  echo "===================================================================="
  echo  
}


func_Path_2Sync_Directories_Create() {
  echo "===================================================================="
  echo -n "Path for Source of Syncing: "
  read Path_From
  
  until [ -d "$Path_From" ]
  do
    echo "$Path_From doesn't exist. Please, create this directory or enter correct path:"
    read Path_From
  done
  echo "$Line1_Backup_Settings => $Path_From"
  
  echo "--------------------------------------------------------------------"  
  
  echo -n "Path to Destination: "
  read Path2Sync
  
  until [ -d "$Path2Sync" ]
  do
    echo "$Path2Sync doesn't exist. Please, create this directory or enter correct path:"
    read Path2Sync
  done
  echo "$Line2_Backup_Settings => $Path2Sync" 
  
  echo "===================================================================="
  echo
  #exit
}

func_check_sync_path_from2to() {
  Path_From_Check=$(cat $FILE | grep "$Line1_Backup_Settings" | sed 's/.*: //')
  #echo "$Path_From_Check"
  if [ ! -d "$Path_From_Check" ]; then
    echo "===================================================================="  
    echo "!!! ----------------- ERROR ----------------- !!!"
    echo "!!! $Line1_Backup_Settings $Path_From_Check => missing, needs to be edited: $FILE"
    echo "===================================================================="
    echo "$LOGDATA == func_check_sync_path_from2to !!!ERROR!!! $Line1_Backup_Settings $Path_From_Check => missing, needs to be edited: $FILE" >> $for_log_file_info
    exit
  fi
  
  Path_From_Check=$(cat $FILE | grep "$Line2_Backup_Settings" | sed 's/.*: //')
  #echo "$Path_From_Check"
  if [ ! -d "$Path_From_Check" ]; then
    echo "===================================================================="
    echo "!!! ----------------- ERROR ----------------- !!!"
    echo "!!! $Line2_Backup_Settings $Path_From_Check => missing, needs to be edited: $FILE"
    echo "===================================================================="
    echo "$LOGDATA == func_check_sync_path_from2to !!!ERROR!!! $Line2_Backup_Settings $Path_From_Check => missing, needs to be edited: $FILE" >> $for_log_file_info
    exit  
  fi
  echo
}


func_copy_from2to() {
  #echo "----------func_copy_from2to------------------"
 
  echo "$LOGDATA == func_copy_from2to RUN" >> $for_log_file_info
  
  path_FROM=$(cat $FILE | grep "$Line1_Backup_Settings" | sed 's/.*: //')
  path_TO=$(cat $FILE | grep "$Line2_Backup_Settings" | sed 's/.*: //')
  #echo $path_FROM
  #echo $path_TO
    
  list_files_FROM=$(cat $FILE | grep "List files in TO path" | sed 's/.*: //')
  list_files_TO=$(cat $FILE | grep "List files in FROM path" | sed 's/.*: //')
  #echo $list_files_FROM
  #echo $list_files_TO
  
  echo "---------------------------"
  echo "------ BEFORE Sync --------" 
  echo "---------------------------" 
  echo
  
  echo "...... Folder FROM consist from such files:"
  # ls >> dir.txt
  ls "$path_FROM" > $list_files_FROM
  cat "$list_files_FROM"
  echo
  echo "...... In folder TO such files !!! WILL BE REMOVE !!!:"
  ls "$path_TO" > $list_files_TO
  cat "$list_files_TO"
  echo 
  
  #diff "$list_files_FROM" "$list_files_TO"  
  # diff - compare files line by line
  #    -y, --side-by-side / output in two columns  
  echo ":::::::::::::::::: DIFF between FROM & TO ::::::::::::::::::::::::"
  echo "::::::::::::::::::       BEFORE Sync      ::::::::::::::::::::::::"
  diff -y "$list_files_FROM" "$list_files_TO" > $Path_Config/changes.diff
  cat $Path_Config/changes.diff 
  echo
  
  # Remove files in 
  rm -r "$path_TO/"
  cp -r "$path_FROM/" "$path_TO/"
  
  
  
  echo "---------------------------"
  echo "------- AFTER Sync --------"
  echo "---------------------------"  
  echo
  
  echo "...... Folder FROM consist from such files:"
  ls "$path_FROM" > $list_files_FROM
  cat "$list_files_FROM"
  echo
  echo "...... Folder TO consist from such files:"
  ls "$path_TO" > $list_files_TO
  cat "$list_files_TO"
  echo 
  
  echo ":::::::::::::::::: DIFF between FROM & TO ::::::::::::::::::::::::" 
  echo "::::::::::::::::::       AFTER Sync       ::::::::::::::::::::::::" 
  diff -y "$list_files_FROM" "$list_files_TO" > $Path_Config/changes.diff
  cat $Path_Config/changes.diff 
  
  echo "$LOGDATA == func_copy_from2to FINISH" >> $for_log_file_info
  echo
  exit
  
  #if         
}

# ==================================== ========= ====================================

# ====================================   MAIN    ====================================


if [ -w "$FILE" ]; then
  # При проверке существования файла наиболее часто используются операторы FILE -e и -f . 
  # Первый проверит, существует ли файл независимо от типа, а второй вернет истину, 
  # только если ФАЙЛ является обычным файлом (а не каталогом или устройством).
  # -e file    Проверяет, существует ли файл.
  # -f file    Проверяет, существует ли файл, и является ли он файлом.
  # -w file    Проверяет, существует ли файл, и доступен ли он для записи.
  #echo "===================================================================="  
  #echo "$Backup_FileName exists, so Data Backup was configureted."
  
  #echo "--------------------------------------------------------------------" 
  
  func_check_sync_path_from2to
  
  
  # Перенаправляем вывод в файл и показываем его на экране
  #   Этот вариант подобен оператору > из предыдущего пункта, то имеется при записи в файл, 
  #   все старые данные будут удалены. Если вам нужно дописать в файл, в конструкцию необходимо 
  #   добавить параметр -a:
  #          команда | tee -a /путь/к/файлу
  
  # Всю информацию с экрана о копировании файлов поместить в лог файл
  func_copy_from2to | tee -a $for_log_file_info

  
  echo "!!!!!!!!!!!!!!! FINISh !!!!!!!!!!!!!!!!!!!!!!!!!"  
  echo "===================================================================="
else 

  func_Path_2Sync_Directories_Create
  func_Backup_and_LOG_File_Create
  echo "!!!!!!!!!!!!!!! RUN Script AGAIN for Sync !!!!!!!!!!!!!!!!!!!!!!!!!"
  echo "===================================================================="
  echo
fi
echo

# ==================================== ========= ====================================



# ==================================== ========= ====================================
