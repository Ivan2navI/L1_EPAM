## Connect to MySQL(Ubuntu) from Workbench(Win10) via LAN 

```console
mysql> CREATE USER 'root'@'%' IDENTIFIED BY 'PASSWORD';
mysql> GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
mysql> FLUSH PRIVILEGES;
```

I see a lot of (wrong) answers, it is just as simple as this:

```console
USE mysql;
CREATE USER 'user'@'localhost' IDENTIFIED BY 'P@ssW0rd';
GRANT ALL ON *.* TO 'user'@'localhost';
FLUSH PRIVILEGES;
```
_Note: instead of a self-created user you can use root to connect to the database. 
However, using the default root account to let an application connect to the database is not the preferred way._

Alternative privileges (be careful and remember the least-privilege principle):

- Grant user permissions to all tables in my_database from localhost

GRANT ALL ON my_database.* TO 'user'@'localhost';

- Grant user permissions to my_table in my_database from localhost

GRANT ALL ON my_database.my_table TO 'user'@'localhost';

- Grant user permissions to all tables and databases from all hosts--

GRANT ALL ON *.* TO 'user'@'*';

You need add/change the following lines in /etc/mysql/my.cnf, restart mysql and check port 3306:
```console
[mysqld]
bind-address=0.0.0.0

sudo service mysql restart

netstat -tln
================> result must be: 0.0.0.0:3306
```
