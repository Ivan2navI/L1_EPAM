## A. Create a script that uses the following keys: 
1. When starting without parameters, it will display a list of possible keys and their description.  
2. The --all key displays the IP addresses and symbolic names of all hosts in the current subnet  
3. The --target key displays a list of open system TCP ports. 
The code that performs the functionality of each of the subtasks must be placed in a separate function 



![Screenshot A](https://github.com/Ivan2navI/L1_EPAM/blob/main/2.%20Linux%20Bash%20Task/!!!!%20RESULTS%20!!!/A%20task%20-%20result.png)


## B. Using Apache log example create a script to answer the following questions: 
1. From which ip were the most requests?  
2. What is the most requested page?  
3. How many requests were there from each ip?  
4. What non-existent pages were clients referred to?  
5. What time did site get the most requests?  
6. What search bots have accessed the site? (UA + IP) 
![Screenshot B](https://github.com/Ivan2navI/L1_EPAM/blob/main/2.%20Linux%20Bash%20Task/!!!!%20RESULTS%20!!!/B%20task%20-%20result.png)

## C. Create a data backup script that takes the following data as parameters: 
1. Path to the syncing  directory. 
2. The path to the directory where the copies of the files will be stored. 
In case of adding new or deleting old files, the script must add a corresponding entry to the log file indicating the time, type of operation and file name. [The command to run the script must be added to crontab with a run frequency of one minute]

### C1. Preparing to Sync

![Screenshot C1](https://github.com/Ivan2navI/L1_EPAM/blob/main/2.%20Linux%20Bash%20Task/!!!!%20RESULTS%20!!!/C%20task%20-%20result%201_Preparing.png)

### C2. Sync and Results
Results info of sync [here](https://github.com/Ivan2navI/L1_EPAM/tree/main/2.%20Linux%20Bash%20Task/!!!!%20RESULTS%20!!!/C%20task%20(files)/.config_Script_Data_backup)

```console
# ============================ Setiing for crontab -e ===============================
# Setiing for crontab -e

SHELL=/bin/bash
HOME=/home/ubuntu
MAILTO=""
PATH=/home/ubuntu/L1_EPAM/2.\ Linux\ Bash\ Task/:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games

* * * * * /home/ubuntu/L1_EPAM/2.\ Linux\ Bash\ Task/C.\ Script\ -\ Data\ backup.sh
```
![Screenshot C2](https://github.com/Ivan2navI/L1_EPAM/blob/main/2.%20Linux%20Bash%20Task/!!!!%20RESULTS%20!!!/C%20task%20-%20result%202_Sync.png)
