# Pod to Pod communication through OpenShift internal DNS

Connect to running pod:
```
oc exec <pod> -it -- cat /etc/resolv.conf
```
returns
```
nameserver 142.34.143.175
search <project name>.svc.cluster.local svc.cluster.local cluster.local dmz gov.bc.ca hs.advsol.tech
options ndots:5
```
When one pod needs to communicate to another one, use the following format
<service name>.<project name>.svc.cluster.local. 


