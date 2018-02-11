# Increasing the size of an existing PVC

Basic steps:
- shut down apps using storage 
- backup current storage content (you can use oc login + oc get pods + oc rsync <pod>:/<path> <local-path>
- create a new pvc for under a new name
- update the deployment config and add the new pvc to be mounted under a new name (volume and volumeMounts)
- oc rsh into the pod and verify both mounts are there (or check in the pathfinder gui)  
- oc rsh to pod and copy content to new mount
- update the deployment config and remove old mount and mount new increased pvc to old location.
- verify


See write-up by Kuan Fan at

https://github.com/bcgov/gwells/wiki/Increase-PostgreSQL-Database-storage

for a good example for a postgress pvc increase.

