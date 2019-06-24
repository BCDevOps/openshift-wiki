---
description: your applications may have jobs that need to run on a schedule.  When do you leverage OpenShift (k8s) cronjobs instead of managing your scheduled jobs within a dedicated pod?
title: Scheduling Jobs
---
## Scheduled Jobs

There are many ways to look at scheduling jobs in an OpenShift environment.

- OpenShift (k8s) CronJobs
- Cron tools in a container (like go-cron)
- More advanced scheduling software running as a project service

As with all choices, each of these solutions has their own "best fit" scenarios.

### OpenShift (k8s) CronJobs

These objects are great for when you have a specific devops tasks that you want the platform to schedule for you.
A great use case could be database backups/imports, daily data loads, etc.

**Pro's:**

- you don't need to manage your own scheduling software, and can create purpose built containers to perform a wide variety of jobs.
- includes features like log collections, retry scenarios, history cleanup, concurrency, etc

**Con's:**

- High cluster overhead for frequent workloads (1/min is very frequent)
  - cronjob creates a job for each scheduled instance
  - job creates and manages the containers, restarts, etc
  - container is started to run the workload
- scheduling is all in UTC
- separate objects for each job

#### Further Reading

[OCP dev_guide](https://docs.openshift.com/container-platform/3.11/dev_guide/cron_jobs.html)

[backup-container Sample](https://github.com/BCDevOps/backup-container/blob/master/openshift/templates/backup/backup-cronjob.yaml)

### Cron tools in a container

Adding a job scheduler to a long running pod can work well for application scheduled workloads.  If you have a lot of small or frequent jobs that are helpful to your application, consolidating the scheduling into a single container can make a lot of sense.

**Pro's:**

- Coordinating multiple job schedules and dependencies can be done in one place
- Scheduling can be done in your local timezone
- overhead can be contained for high frequency, low resource jobs

**Con's:**

- Can miss a scheduled job if it occurs during a pod restart or evacuation
- does not have extended features (retry scenarios, etc)

#### Further Reading

[webdevops/go-crond](https://github.com/webdevops/go-crond)

[BCDevops fork of go-crond](https://github.com/BCDevOps/go-crond)

### Advanced Scheduling Software

Advanced job or workflow scheduling software would be driven by specific project requirements and would need to be evaluated based on those requirements.  Without those additional requirements, this would be a bit of overkill for simple job scheduling.
