# Patroni Stability Issue Hot Fix

During the upgrade to Openshift 4.8.28 in the Silver cluster during the week of Feb 7, 2022 we observed that app's Patroni clusters that use Patroni `v1.6.51` experienced outages when the cluster nodes where the PostgreSQL pods were running, were restarted as part of the upgrade. The troubleshooting narrowed down the root cause to the [known bug](https://github.com/zalando/patroni/issues/1508) in this Patroni version. It is highly recommended that the teams apply the fix suggested below **as soon as possible** to minimize the risk of service disruption for their database services. 

**The OCP 4.8.28 upgrade will resume on Wed Feb 23, 2022 at 9am**

**Please note: while this fix has been testing multiple times in a lab environment by the Platform Services Team the nature of the bug means that we cannot guarantee that this fix will be completely outage-free. We did repeat the test multiple times and were unable to cause an outage using this method, but this may depend somewhat on your particular deployment. Therefore, please ensure that you test sufficiently in your test environment before applying the upgrade to prod!** If this is of particular concern to you, you may wish to consider turning off the readiness probe for the duration of the upgrade (but make sure you turn it back on again once you finish). Note that the method performed by the Platform Team did not involve turning off the readiness probe - even with it on, we were still unable to cause an outage using this method.

We recommend moving from Patroni v1.6.5 to v2.0.1. If your team wishes to upgrade further, please feel free to do so.

## Step 1: Preparation

Before you begin, as is always best practice, please make sure that you back up your database. 

You may also wish to switch the leader of your Patroni cluster over to pod 0 in your stateful set. This shouldn't be necessary, but will probably make things easier on you.

This list of steps requires that the stateful set not automatically redeploy on image change. Please ensure that this is true of your Patroni stateful set before proceeding.

Note that there are some time constraints in these instructions - certain steps which should be performed relatively quickly. None of these time constraints are so tight that you should feel rushed, but you should ensure that you can finish this process in a single sitting and understand the requirements of each step before you begin. As such, **please read all of these instructions from start to finish before you begin.**

Lastly make sure that the current state of your Patroni cluster is healthy, that all members are communicating properly, that you have plenty of space in your PVCs, and that there is a low `Lag in MB` value when you check `patronictl list` to see the status of your cluster. You can run this command from the terminal of any pod in your cluster.

## Step 2: Put your Patroni cluster into Maintenance Mode

Maintenance mode means that your cluster turns off all Patroni-controlled governance of your database pods - in short, this means no failover in the event that your leader pod goes down. This is useful for us because, normally, updating the Patroni version of any pod in your cluster forces the other pods to upgrade immediately as well, which would result in an outage. Turning on maintenance mode allows us to control when and how each pod gets restarted, so we can ensure that there is always at least one pod up. Your app will continue to communicate with the leader pod during the maintenance mode window, but will fail if the leader pod goes down while maintenance mode is on, as a member will not be elected as a new leader. Please aim to reduce the length of time in which your cluster remains in maintenance mode in order to reduce this risk. 

Go to the terminal of any pod in your patroni cluster and run the following command:

`patronictl pause`

This should produce the following message:

`Success: cluster management is paused`

You can also double-check your cluster's mode using the following command:

`patronictl list`

If your cluster is in maintenance mode, you will something like the following:

```
    + Cluster: patroni-001 (7065071675363201060) ------+----+-----------+
    | Member        | Host         | Role    | State   | TL | Lag in MB |
    +---------------+--------------+---------+---------+----+-----------+
    | patroni-001-0 | 10.97.19.146 | Replica | running |  2 |         0 |
    | patroni-001-1 | 10.97.13.94  | Leader  | running |  2 |           |
    +---------------+--------------+---------+---------+----+-----------+
    Maintenance mode: on
 ```

If your cluster is not in maintenance mode, the bottom line will be missing.

## Step 3: Build a New Image

**Note: If you are still building from the dockerfile in the BCDevops/platform-services repo, please note that this file is no longer being maintained.** It does contain this particular fix, in order to allow teams using that file to perform this upgrade without having to deal with the additional complication of switching Dockerfiles. For what it's worth, I switched between the files several times during testing and never saw an issue - however, it would be understandable if this seems like an unnecessary risk. In either case, please note that you should change your buildconfig, whether now or in the future, to point to the dockerfile in bcgov/patroni-postgres-container in take advantage of future file maintenance.

You will need to update your build-config to include the following: 

```
spec:
    strategy:
        dockerStrategy:
            from:
                kind: ImageStreamTag
                name: postgres:{{ postgres_version }}
            buildArgs:
                - name: "patroniv"
                  value: {{ patroni_version }}
```

You may already be specifying your own `from` image tag, in which case you should leave it the same. If you are not, you should add one and ensure appropriately that it points to a postgres image that is **the same version as the one you are currently using**. If you do not, you may pull a different image version from the one your cluster currently uses. This is not to be a good time to perform a surprise database version upgrade (or downgrade), so please ensure that you specify your postgres version explicitly.

You must also include the `buildArgs` section in order to upgrade the patroni version. If you don't have this line, your image will continue to build as version 1.6.5. This is the default, in order to avoid pushing upgrades to those who are not prepared for them. You must explicitly state your new version in order to upgrade. If you're unsure of which version to select, use 2.0.1 - this is the next version without the bug.

When you run the build, note that you may see a line in the build logs like this:

`STEP 3: ARG patroniv=1.6.5`

This is fine - it only indicates the default value. It will be overwritten if you specified a `patroniv` build argument in your build config. If you are uncertain of the version, once the build is complete you will see a series of lines around 70% of the way down the build log with the following at the end of most lines: 

`(from patroni[kubernetes]==2.0.1)`

This is how you can be sure that you've built an image using version 2.0.1.

## Step 4: Tagging your Image

Please ensure that you tag your new image with the same tag that your current deployment is using. This will allow us to apply the new image by simply restarting each pod one at a time.

## Step 5: Restart Non-Leader Pods

**Note: Steps 5 and 6 need to be completed within a few minutes of each other.**

Kill one of the member pods (**not the leader**) in your cluster. 

When it restarts, it will not enter a ready state. When you check `patronictl list` this member will show as not running, and the log will indicate that postgres has not started. This is all expected behaviour. Run `patronictl version` on the restarted member pod to ensure that it displays the new version of patroni.

Repeat with each member pod until all pods except the leader have been restarted.

## Step 6: Resume Patroni Pod Management

On any pod in the cluster, issue the following command:

`patronictl resume`

This will resume patroni's management of the cluster. Check `patronictl list` to see that your upgraded member pod is now listed as a functioning member pod once more.

You now have member pods operating on an upgraded version of patroni while the leader is operating on the old version.

## Step 7: Switchover Cluster Leader to an Upgraded Pod

On any pod in the cluster, issue the following command:

`patronictl switchover [cluster-name]`

The prompts will ask you to confirm the current leader of the cluster, and to select a new leader. Select an upgraded member as your new leader. Tell it to switchover now. It will provide you with an overview of the current cluster state (before switchover) and ask you to confirm that you want the switchover to occur. Ensure that everything you've entered makes sense. Make sure the `Lag in MB` listed for your target leader is 0, and then confirm the switchover.

Once you do so, the original leader's postgres process will stop for a moment. This is expected behaviour. Give it a minute, and then run `patronictl list` - it should indicate that the old leader has recovered on its own and is now functioning as a member pod.

## Step 8: Restart the Remaining Pod

Your old leader pod is now a member pod, but is still operating with the old patroni version. Head over to that pod and restart it. Once the restart is completed, run `patronictl version` on this pod - it should show the new version.

Double-check that you are finished the upgrade by checking each pod with `patronictl version`. If any members were missed, just restart them now. If the leader was missed, start at step 5 again by restarting all pods *except* the leader, and proceed to this step again.

## You're Finished!

Congratulations on upgrading Patroni!

As always, if you have any questions, please shout on #devops-how-to or #patroni on our Rocketchat instance!