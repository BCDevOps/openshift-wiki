# PostgreSQL Server stuck in recovery loop - not starting up


Errors in log file observed:

```
PANIC:  could not locate a valid checkpoint record

LOG:  connection received: host=[local]
FATAL:  the database system is starting up
```


Referrence:

https://stackoverflow.com/questions/8799474/postgresql-error-panic-could-not-locate-a-valid-checkpoint-record


Solution:

PostgreSQL < version 10:
```
oc debug <pod>
pg_resetxlog [-f] DATADIR
```

PostgreSQL >= version 10:
```
oc debug <pod>
pg_resetwal [-f] DATADIR
```

