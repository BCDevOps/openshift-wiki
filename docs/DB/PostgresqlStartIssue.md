
# Postgres does not start up, claiming an instance of server is already running

***Issue:***

Postgres server does not start up. Error indicates instance of server is already running.
Container error event:
```
"Crash loop back off status"
```
Postgres error from Postgres log:
```
pg_ctl: another server might be running; trying to start server anyway. ERROR:  tuple already updated by self.
```

***Solution:***

Remove PID file from Postgres PVC.

