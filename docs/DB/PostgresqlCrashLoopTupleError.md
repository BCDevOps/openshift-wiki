---
description: Issue and Fix for a Postgres crash loop caused by 'tuple concurrently updated' error
---
Author: Wade Barnes
# Postgres Crash Loop Error and Solution
## Fixing a Postgres crash loop caused by a `tuple concurrently updated` error

If a Postgres database pod gets terminated unexpectedly it can trigger a crash loop with the following log signature.

```
pg_ctl: another server might be running; trying to start server anyway
waiting for server to start....LOG:  redirecting log output to logging collector process
HINT:  Future log output will appear in directory "pg_log".
..... done
server started
=> sourcing /usr/share/container-scripts/postgresql/start/set_passwords.sh ...
ERROR:  tuple concurrently updated
```

To fix the issue:
- Find the name of the postgres pod that is in the crash loop.
- Start an `oc debug` session with the pod.
- Scale the associated Postgres deployment to zero pods.
- From the cmd line of the debug session;
  - Run `run-postgresql`.  This is the `CMD` for the docker image.  As part of the start-up process the script creates a number of files that won't exist in the pod otherwise, namely `/var/lib/pgsql/openshift-custom-postgresql.conf` and `/var/lib/pgsql/passwd`, which will stop you from running any of the `pg_ctl` commands.  When you run the command you should see the same error output listed above.
  - Run `pg_ctl stop -D /var/lib/pgsql/data/userdata` to cleanly shutdown Postgres.  You should see;
    ```
    waiting for server to shut down.... done
    server stopped
    ```
  - Run `pg_ctl start -D /var/lib/pgsql/data/userdata` to start Postgres.  You should see the following output and it should wait there indefinitly (no errors);
    ```
    server starting
    sh-4.2$ LOG:  redirecting log output to logging collector process
    HINT:  Future log output will appear in directory "pg_log".
    ```
  - Press `enter` a couple of times to get back to the cmd prompt.
  - Run `pg_ctl stop -D /var/lib/pgsql/data/userdata`, and wait for postgres to stop.  This will ensure a clean shutdown.
    ```
    waiting for server to shut down.... done
    server stopped
    ```
  - Exit the debug session.
  - Scale the deployment to 1 pod.  Postgres should start normally now.


