Author: Kuan Fan 

# PostgreSQL Backup and Restore
Postgresql provides various backup and restore options. After exploring all of them, we choose the following two solutions for TFRS project:
* SQL Dump backup and restore
* Continuous Archiving and Point-in-Time Recovery (PITR)
### Common domain names for both solutions
* master postgresql is the pod of dc\postgresql
* standby postgresql is the pod of dc\postgresql-standby
* [pgdatahome] is /var/lib/pgsql/data/userdata
* create gluster file cns storage postgresql-backup-cns RWX (Read-Write-Many) with at least 5G 
* mount above storage to /postgresql-backup on master
* mount above storage to /postgresql-backup on standby
* create the following folder under /postgresql-backup
    * SQLDump, include the SQLDump files named like tfrs-[DateTime].gz
    * basebackup, include the base backup files name tfrs-<datatime>.tar
    * walbackup, include archived transaction log files from master /var/lib/pgsql/data/userdata/pg_xlog
    * walbackup-standby, include archived transaction log files from standby /var/lib/pgsql/data/userdata/pg_xlog
## SQL Dump backup and restore
### Backup on master
* Scale dc/tfrs down to zero
* Login master
    * Run command "pg_dump tfrs | gzip > /postgresql-backup/SQLDump/[env]/tfrs-[DateTime].gz"
### Recover on standby
* Login standby
    * Run "psql -c drop database tfrs" to remove the existing tfrs database on standby server
    * Run "psql -c create database tfrs" to create a new tfrs database on standby server
    * Run "gunzip -c /postgresql-backup/SQLDump/tfrs-[DateTime].gz | psql tfrs"
    * Connect to tfrs database and verify the credit_trade table having up to date records as master
## Continuous Archiving and Point-in-Time Recovery (PITR)
PostgreSQL maintains write ahead logs (WAL) in the pg_xlog directory. The logs record every change made to the database.  These logs exist primarily for crash-safety purposes: if the system crashes, the database can be restored to consistency by "replaying" the log entries made since the last checkpoint.
### Continuous Archiving
* Scale dc/tfrs down to zero
* Login master
    * Update [pgdatahome]/postgresql.conf
        * open and change wal_level=archive
        * open and change archive_mode=on
        * open and change max_wal_senders=3
        * open and change archive_command='test ! -f /postgresql-backup/walbackup/[env]/%f && cp %p /postgresql-backup/walbackup/[env]/%f'
    * Scale master down to 0, wait 10 seconds and scale it up to 1. Make sure /var/lib/pgsql/data/userdata/pg_xlog contains log files.
    * run "psql tfrs" command to connect to database
        * run "SELECT pg_start_backup('[backup-datetime]')"
        * open another terminal (don't quit pgsql session) to run the command "cd /var/lib/pgsql/data; tar --ignore-failed-read -cf /postgresql-backup/basebackup/[env]/tfrs-[env]-[datatime].tar userdata"
        * run "SELECT pg_stop_backup()"
    * Make sure /postgresql-backup/basebackup/[env] having the base backup tar file, for example:  
-rw-------. 1 1000230000 root 16777216 Apr  9 21:56 000000010000000000000006  
-rw-------. 1 1000230000 root      299 Apr  9 21:56 000000010000000000000006.00000028.backup  
-rw-------. 1 1000230000 root 16777216 Apr  9 21:56 000000010000000000000007  
-rw-------. 1 1000230000 root 16777216 Apr  9 21:51 000000010000000000000008  
    * Make sure /postgresql-backup/walbackup/[env] having the logs files transferred from [pgdatahome]/pg_xlog folder, for example:  
-rw-------. 1 1000230000 2178 16777216 Apr  9 21:46 000000010000000000000002  
-rw-------. 1 1000230000 2178 16777216 Apr  9 21:47 000000010000000000000003  
-rw-------. 1 1000230000 2178 16777216 Apr  9 21:47 000000010000000000000004  
-rw-------. 1 1000230000 2178 16777216 Apr  9 21:51 000000010000000000000005  
-rw-------. 1 1000230000 2178 16777216 Apr  9 21:56 000000010000000000000006  
-rw-------. 1 1000230000 2178      299 Apr  9 21:56 000000010000000000000006.00000028.backup  

### Point-in-Time Recovery (PITR)
The recovery has two steps including base backup restore and applying WAL log files.
* Base backup restore
    * scale down both master and slave to 0
    * run "debug dc/postgresql-standby"
        * cd to /var/lib/pgsql/data and remove the directory userdata
        * restore the basebackup to current folder by running command "tar -xvf /postgresql-backup/basebackup/tfrs-[datatime].tar ."
        * remove all files in userdata/pg_xlog folder but keep the archive_status folder
        * if the master folder [pgdatahome]/pg_xlog contains log files, copy them to /postgresql-backup and then copy them to here. This way, we can have the up to date transaction logs which didn't get a chance to be archived.
* Apply log files on top of base backup
    * still on the debug pod "debug dc/postgresql-standby"
        * create a file called recovery.conf under [pgdatahome] folder. 
             * the file contains one line "restore_command='cp /postgresql-backup/walbackup/%f %p'". The command will copy all archived transaction logs over to [pgdatahome]/pg_xlog folder.
             * make sure this file has same ownership of other files under same fold. also it it better to run command "chmod 666 recovery.conf" to grant read and write permission for others.
        * open file userdata/postgresql.conf file, update archive_command='test ! -f /postgresql-backup/walbackup/%f && cp %p /postgresql-backup/walbackup-standby/%f' and save the file.
* kick off the recovery
    * scale up standby to 1
    * verify the [pgdatahome]/postgresql.conf is renamed to be [pgdatahome]/postgresql.done
    * check if there are errors under /var/lib/pgsql/data/userdata/pg_log
    * rsh to the standby, connect to tfrs database and verify if the credit_trade table has the up to date records as the original one
## Switch TFRS to use standby database
After the standby database has been recovered from master database. Here are the steps to have the standby database in working order with tfrs backend application:
* Scale down dc/tfrs to 0 (this should be done already)
* Scale down master to 0 (this should be done already)
* Scale down standby to 0 (this should be done already)
* Scale up standby to 1
* Open service postgresql yaml file
    * update selector -> name from postgresql to postgresql-standby
    * after saving the yaml file and verify the server is selecting the standby
* Scale up dc/tfrs to 1 
* At this point, the standby database has been created from backup. It is ready to be connected by TFRS backend.
* Test login to make sure you can see the up to date credit trades.
# File System Level Backup 
This is the third option of backup. It backups the entire file system which is [pgdatahome]
* Run rsync while * database is running
* Run rsync --checksum after database is shut down, --checksum can only copy the changed files so that can reduce the database down time.  
Note, this option hasn't been tested a the time of writing this document.
# Sample Postgresql Corruption Messages
* Could not locate a valid checkpoint record
018-03-09 20:35:37 UTC LOG:  invalid primary checkpoint record  
2018-03-09 20:35:37 UTC LOG:  invalid secondary checkpoint record  
2018-03-09 20:35:37 UTC PANIC:  could not locate a valid checkpoint record  
2018-03-09 20:35:37 UTC postgresFATAL:  the database system is starting up  
2018-03-09 20:35:38 UTC postgresFATAL:  the database system is starting up  
2018-03-09 20:35:39 UTC postgresFATAL:  the database system is starting up  
2018-03-09 20:35:40 UTC postgresFATAL:  the database system is starting up  
2018-03-09 20:35:41 UTC postgresFATAL:  the database system is starting up  
2018-03-09 20:35:42 UTC postgresFATAL:  the database system is starting up  
2018-03-09 20:35:43 UTC postgresFATAL:  the database system is starting up  
2018-03-09 20:35:44 UTC LOG:  startup process (PID 22) was terminated by signal 6: Aborted  
2018-03-09 20:35:44 UTC LOG:  aborting startup due to startup process failure  
# Referenced Material
* https://www.postgresql.org/docs/9.5/static/backup.html
* https://www.youtube.com/watch?v=WZps_MYYvV8
* https://www.youtube.com/watch?v=-3gs-akUg-g
