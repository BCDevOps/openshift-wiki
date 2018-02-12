**Issue:**

Container does not start. Events show errors binding to persistent storage. Glusterfs serice and endpoint do net exist.

**Solution:**

While in your project re-create glusterfs-cluster-app service and endpoint from yaml file with 'oc create -f' 

Yaml files for endpoint and service are at
* https://github.com/BCDevOps/openshift-tools/blob/master/resources/glusterfs-cluster-app-endpoints.yml
* https://github.com/BCDevOps/openshift-tools/blob/master/resources/glusterfs-cluster-app-service.yml

Run 
```
oc create -f https://raw.githubusercontent.com/BCDevOps/openshift-tools/master/resources/glusterfs-cluster-app-service.yml
oc create -f https://raw.githubusercontent.com/BCDevOps/openshift-tools/master/resources/glusterfs-cluster-app-endpoints.yml
```
to re-create.

Verify:

```
oc get endpoints
oc get svc
```
Both should show a glusterfs-cluster-app entry. 



