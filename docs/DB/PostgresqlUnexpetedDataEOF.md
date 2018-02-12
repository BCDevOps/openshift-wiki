# Postgresql unexpected data beyond EOF in block


## Issue:

When loading data into postgres db (seeding of db or reload from backup for example) the following error shows
~~~
psql: ERROR:  unexpected data beyond EOF in block 1314 of relation base/17835/122175
HINT:  This has been seen to occur with buggy kernels; consider updating your system.
~~~
Once this error occurs postgresql does not start up.

## Troubleshooting Steps:

Connect to postgresql pod (oc debug {pod}).

In the /var/lib/pgsql/data/userdata_broken/pg_log/postgresql*.log the lines similar to the ones below are recorded:
~~~
WARNING:  corrupted statistics file "pg_stat_tmp/global.stat"
LOG:  incomplete startup packet

ERROR:  unexpected data beyond EOF in block 321 of relation base/68243/373021
HINT:  This has been seen to occur with buggy kernels; consider updating your system.
STATEMENT:  ...

FATAL:  the database system is starting up
~~~ 

## Solution:
1. 
Increase the max_wal_size postgresql setting (max_wal_size = 2GB)

/var/lib/pgsql/data/userdata/postgresql.conf
(does an include '/var/lib/pgsql/openshift-custom-postgresql.conf')

More info on postgres config settings:
* https://www.postgresql.org/docs/9.5/static/wal-configuration.html
* https://www.postgresql.org/docs/9.5/static/runtime-config.html
* https://www.postgresql.org/docs/9.5/static/libpq-envars.html

2. 
Dealing with the corrupted psqldata.

Connect to postgresql pod (oc debug {pod}) and rename userrdata folder.
Postgres will create a new userdata folder on startup.
Restore data from backup.

Reference: 
https://github.com/bcgov/gwells/wiki/Recovering-from-a-corrupt-PostgreSQL-Database


