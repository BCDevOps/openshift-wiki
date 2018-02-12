### Node Evacuation Process

Reference:
https://github.com/BCDevOps/openshift-wiki/wiki/Effect-on-Pods-with-Standard-Maintenance---Evacuate-Drain-Procedure

RedHat Documentation:
https://docs.openshift.com/container-platform/3.6/admin_guide/manage_nodes.html#evacuating-pods-on-nodes

This document describes the process as follows:

## Evacuating Pods on Nodes
Evacuating pods allows you to migrate all or selected pods from a given node or nodes. Nodes must first be marked unschedulable to perform pod evacuation.

Only pods backed by a replication controller can be evacuated; the replication controllers create new pods on other nodes and remove the existing pods from the specified node(s). Bare pods, meaning those not backed by a replication controller, are unaffected by default.

## Other Notes:
Found the following on the OpenShift origin github page:
https://github.com/openshift/origin/issues/8424
Note: This article is a year old.

## Deleting a POD

``` 
oc delete pod 
```
when OpenShift deletes a pod, it sends the pod a Linux TERM signal, often abbreviated as SIGTERM. The SIGTERM acts as a notification to the process that it needs to finish what it is doing and then exit. One caveat is that the application needs code to catch the signal and perform any handling code to appropriate action. If the container does not exit within a given grace-period then OpenShift will send a Linux Kill signal (SIGKILL) which will immediately terminate the application.

By default, the grace-period is set to 30 seconds (terminationGracePeriodSeconds field in the DeploymentConfiguration).

Although catching basic Linux signals such as SIGTERM is a best practice, many applications are not equipped handle Linux signals. A nice way to externalize the logic from the application itself is to use what is called a preStop hook and is one of two Container Lifecycle Hooks available in OpenShift. Container Lifecycle Hooks allow users to take pre-determined actions during a container management lifecycle event. The two events available in OpenShift are:
* PreStop - Execute a handler before the container is terminated. This event is blocking, meaning that is must finish before the pod is terminated.
* PostStart - Execute a handler immediately after the container is started.
  
TIP:
Container Lifecycle Hooks can be leveraged in conjunction with pod grace periods. If PreStop hooks are used they will take precedence over the pod deletion. In fact the SIGTERM will not be sent to the container until the PreStop hook finishes executing.

