
Author: Shea Stewart @ Artic


# Purpose

During regular maintenance of a node, which could include (OS) operating system or application (ie. OpenShift) upgrade tasks, a procedure is undertaken with evacuates the node of all running pods. Depending on the application deployment, this process may affect running applications. This document outlines a few key details as it pertains to running applications on an OpenShift node and strategies to ensure application uptime. 


# TL'DR (Too long;didn't read)

Planned maintenance activities will cause disruption to your application if appropriate action is not taken. Pod evictions will not wait for the application to be fully up and running. To reduce or remove impact; 

- Increase replica counts > 1
  - This technique must support the application availability architecture
  - Pods will try to "spread out" across nodes as much as possible by default
- Utilize `PodDisruptionBudget`  on OCP ≥ 3.6
- Increase deployments and replicate at the application layer where appropriate
  - More appropriate for applications such as elasticsearch or databsases
  - Use Pod Affinity/Anti-affinity rules when appropriate

# Evacuation Process

An administrative command `oc adm drain`  or `kubectl drain`  is used to peform the following tasks: 

- Set a desired node to `unschedulable` , preventing new workloads from arriving on the node
- Evactuate pods with **graceful termination**  by restarting on another node prior to termination on the existing node
  - Timeout periods apply before a pod is forcefully terminated
  - Some pods are never terminated gracefully based on their schedule type, such as daemonsets
  - Containers using `emptyDir`  for storage will lose any stored data and should be fully architected as empheral pods

### What Graceful Termination Is

Graceful termination at a glance: 

- Upon termination, the pod is set to shut down
  - Shows up as "Terminating"
  - Executes any `preStop`  hooks that may be configured
- The replication controller starts another pod on a `schedulable`  node

### What Graceful Termination Is NOT

Graceful termination, despite the name, does not take into account the intelligence of deployment stragtegies or deployments in general. The termination is not waiting for the application to be running (if appropriate) before cutting over services, but is simply the act of a replication controller restarting a pod on a new available node. The behaviour here is **exactly**  the same as simply deleting your pod. 

By example with a sample; notice that the container is still in `ContainerCreating`  status even though the previous container has been completely removed. 

- The following output is an example of a pod being evicted from a node

```
[root@osjump01 ~]# oc get pods -o wide 
NAME              READY     STATUS    RESTARTS   AGE       IP             NODE
jenkins-1-g5npk   0/1       Running   0          1m        10.129.2.237   osa102.dev.arctiq.ca
[root@osjump01 ~]$ oc adm drain osa102.dev.arctiq.ca
node "osa102.dev.arctiq.ca" cordoned
pod "jenkins-1-g5npk" evicted
node "osa102.dev.arctiq.ca" drained
[root@osjump01 ~]# 
```

- The following is observed during the evactuation process

```
[root@osjump01 ~]# oc get pods -o wide 
NAME              READY     STATUS              RESTARTS   AGE       IP             NODE
jenkins-1-5tcq7   0/1       ContainerCreating   0          9s        <none>         osa103.dev.arctiq.ca
jenkins-1-g5npk   0/1       Terminating         0          2m        10.129.2.237   osa102.dev.arctiq.ca
[root@osjump01 ~]# oc get pods -o wide 
NAME              READY     STATUS              RESTARTS   AGE       IP             NODE
jenkins-1-5tcq7   0/1       ContainerCreating   0          11s       <none>         osa103.dev.arctiq.ca
[root@osjump01 ~]#
```

# Increasing Availability to Survive Planned Maintenance

In order to increase availability of an application during planned maintenance activities; 

### Increase Replica Count + PodDisruptionBudgets

Increase the replica count of the desired pods and set a PodDisruptionBudget that ensures at least one pod is running at all times. 

By example: 

- A **node-js**  app with 2 replicas on the same node (this was a forced task, typical behaviour would schedule pods across multiple nodes)

```
[root@osjump01 ~]# oc get pods -o wide 
NAME               READY     STATUS    RESTARTS   AGE       IP             NODE
node-app-1-crf5f   1/1       Running   0          2m        10.128.2.168   osa101.dev.arctiq.ca
node-app-1-cw6gm   1/1       Running   0          1m        10.128.2.172   osa101.dev.arctiq.ca
```

- A PodDisruptionBudget with minimum 1 required pod

```
[root@osjump01 ~]# oc describe PodDisruptionBudget
Name:		node-pdb
Min available:	1
Selector:	app=node-app
Status:
    Allowed disruptions:	1
    Current:			2
    Desired:			1
    Total:			2
Events:				<none>
```

- Draining the node will not let the **Ready**  pods to drop below the minimum of **1**

```
[root@osjump01 ~]# oc get pods -o wide 
NAME               READY     STATUS              RESTARTS   AGE       IP             NODE
node-app-1-crf5f   1/1       Terminating         0          3m        10.128.2.168   osa101.dev.arctiq.ca
node-app-1-cw6gm   1/1       Running             0          2m        10.128.2.172   osa101.dev.arctiq.ca
node-app-1-k5fpn   0/1       ContainerCreating   0          2s        <none>         osa103.dev.arctiq.ca
....
[root@osjump01 ~]# oc get pods -o wide 
NAME               READY     STATUS        RESTARTS   AGE       IP             NODE
node-app-1-9pqtx   1/1       Running       0          5s        10.129.2.245   osa102.dev.arctiq.ca
node-app-1-crf5f   0/1       Terminating   0          3m        <none>         osa101.dev.arctiq.ca
node-app-1-cw6gm   1/1       Terminating   0          2m        10.128.2.172   osa101.dev.arctiq.ca
node-app-1-k5fpn   1/1       Running       0          36s       10.131.2.161   osa103.dev.arctiq.ca
...
[root@osjump01 ~]# oc get pods -o wide 
NAME               READY     STATUS        RESTARTS   AGE       IP             NODE
node-app-1-9pqtx   1/1       Running       0          22s       10.129.2.245   osa102.dev.arctiq.ca
node-app-1-cw6gm   1/1       Terminating   0          3m        10.128.2.172   osa101.dev.arctiq.ca
node-app-1-k5fpn   1/1       Running       0          53s       10.131.2.161   osa103.dev.arctiq.ca
...
[root@osjump01 ~]# oc get pods -o wide 
NAME               READY     STATUS    RESTARTS   AGE       IP             NODE
node-app-1-9pqtx   1/1       Running   0          2m        10.129.2.245   osa102.dev.arctiq.ca
node-app-1-k5fpn   1/1       Running   0          2m        10.131.2.161   osa103.dev.arctiq.ca
```

### Utilise Multiple Deployments with Application Replication and Pod Affinity/Anti-Affinity Rules

For applications that don't easily lend themselves to the strategy above, such as: 

- Clustered applications
- Clustered Databases (mysql, postresql, cassandra, etc.)
- Any other non-stateful applications

The typical strategy is to have multiple deployments of the application (sometimes as a `StatefulSet` ) and to configure each application instance to replicated with their known partners. This level of application clustering must be supported by the application, but should also have additional configurations in place to ensure that they are distributed across nodes such as affinity rules. 

**Pod Affinity/Anti-Affinity**

- Anti-affinity rules
  - Ensure pods are not scheduled on a node that already has a matching pod running
- Affinity rules
  - Ensure pods are only scheduled on nodes that have the matching pods running

Pod affinity allows a **pod** to specify an affinity (or anti-affinity) towards a group of **pods** (for an application’s latency requirements, due to security, and so forth) it can be placed with. The node does not have control over the placement. Pod affinity uses labels on nodes and label selectors on pods to create rules for pod placement. Rules can be mandatory (required) or best-effort (preferred).

To ensure higher-availability of applications during planned or unplanned maintenance, it would be recommended (for production environments) that appropriate pod **anti-affinity**  configurations be applied to deployments with replicas > 2 or on applications that leverage independent `DeploymentConfigs`  or `StatefulSets` with replication at the application level. 

# References

The following links provide additional reading material on this topic: 

OpenShift Specific Documentation

- [https://docs.openshift.com/container-platform/3.7/admin_guide/manage_nodes.html#evacuating-pods-on-nodes](https://docs.openshift.com/container-platform/3.7/admin_guide/manage_nodes.html#evacuating-pods-on-nodes)
- [https://docs.openshift.org/latest/admin_guide/manage_nodes.html#evacuating-pods-on-nodes](https://docs.openshift.org/latest/admin_guide/manage_nodes.html#evacuating-pods-on-nodes)
- [https://docs.openshift.com/container-platform/3.7/admin_guide/scheduling/pod_affinity.html](https://docs.openshift.com/container-platform/3.7/admin_guide/scheduling/pod_affinity.html)

Kubernetes Documentation

- [https://kubernetes.io/docs/tasks/administer-cluster/safely-drain-node/](https://kubernetes.io/docs/tasks/administer-cluster/safely-drain-node/)
- [https://kubernetes.io/docs/concepts/workloads/pods/pod/#termination-of-pods](https://kubernetes.io/docs/concepts/workloads/pods/pod/#termination-of-pods)
- [https://kubernetes.io/docs/concepts/workloads/pods/disruptions/](https://kubernetes.io/docs/concepts/workloads/pods/disruptions/)
- [https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/)

