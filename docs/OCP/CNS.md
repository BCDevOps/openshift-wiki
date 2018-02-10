
Author: Matthew J. Robson @ RedHat

# Container Native Storage

Documentation: 
https://access.redhat.com/documentation/en-us/red_hat_gluster_storage/3.3/html/container-native_storage_for_openshift_container_platform/

## What is CNS?
CNS is realized by containerizing GlusterFS in a Docker container. This is deployed on a running OpenShift or Kubernetes cluster using native container orchestration provided by the platform. To provide integration with the storage provisioning framework an additional management component is added to GlusterFS called heketi. It serves as an API and CLI front-end for storage lifecyle operations. In addition it supports multiple deployment scenarios. Heketi runs containerized along side the GlusterFS pods on OpenShift or Kubernetes cluster.
* OpenShift <==> Heketi <==> Gluster
* CNS: Provides dynamic persistent storage for OpenShift with Gluster in a hyper-converged fashion
* Heketi: The high-level service interface to gluster to manage the lifecycle of volumes in one or more Gluster clusters.

## Container Native Storage (CNS) vs Container Ready Storage (CRS) vs Gluster (RHGS)
* Container-Native Storage (CNS) runs gluster in a containerized form inside the OpenShift gluster. If provides dynamic provisioning capabilities which enable end-users to create their own Persistent Volumes backed by Gluster volumes. This is done without having to pre-create the volumes or have any knowledge of Gluster. The volume will be created as requested when the claim request comes in, and the volume will be sized exactly as requested.
* Container-Ready Storage (CRS) is deployed as a stand-alone Red Hat Gluster Storage cluster outside of OpenShift. CRS also provides the same type of dynamic provisioning.
* Traditional Gluster which also runs as a stand-alone cluster outside OpenShift does not provide any dynamic provisioning. This is what is currently backing existing Persistent Volumes in OpenShift. 
* CNS and CRS support two storage types
  * BLOCK  (gluster-block) 
  * FILE (gluster-file)
* Traditional Gluster supports FILE storage only

## CNS BLOCK vs CNS FILE

Access Modes:
* ReadWriteOnce (RWO) – the volume can be mounted as read-write by a single node
* ReadOnlyMany (ROX) – the volume can be mounted read-only by many nodes
* ReadWriteMany (RWX)  – the volume can be mounted as read-write by many nodes    

***

* Block storage allows the creation of high performance individual storage units as iSCSI targets. Unlike the traditional file storage capability that glusterfs supports, each storage volume/block device can be treated as an independent disk drive, so that each storage volume/block device can support an individual file system. 
* Block storage supports and guarantees RWO access and 

Gluster Block Design: https://github.com/gluster/gluster-kubernetes/blob/master/docs/design/gluster-block-provisioning.md
 
* FILE supports all access types but can not guarantee RWO access to a single client (RWX, RWO, ROX)

## FAQ
### When to use BLOCK storage?
* Access is guaranteed RWO
* for metrics, logging, jenkins data
* non-critical, non-production data
* Deployment strategy "RECREATE"
* Single Mount

### When to use FILE storage?
* Access RWX is required
* Any deployment strategy
* Multiple PODs mounting and writing 
* If the data stored on PV is production data

### How do I select file or block?
* Each type of storage has an associated storage class
* The storage class provides the mechanisms for how storage of that type is dynamically provisioned
* If you want a file backed PV, you select the file storage class
* If you want a block backed PV, you select the block storage class
* If you want an existing traditional gluster PV, you select the manual-storage class

Example Storage Class Object:
```
apiVersion: storage.k8s.io/v1beta1
kind: StorageClass
metadata:
  name: gluster-file
provisioner: kubernetes.io/glusterfs
parameters:
  resturl: "http://<url>"
  restuser: "<user>"
  volumetype: "replicate:3"
  clusterid: "<cluster>"
  secretNamespace: "default"
  secretName: "heketi-secret"
```

### How to convert an existing Traditional Gluster PVC to CNS PVC manually? 
* Dynamically create a CNS PVC
* Add CNS PVC to deployment (can be done via GUI, not this will trigger a re-deploy) 
* OC RSH to POD with both PV types (CSR and Traditional Gluster)
* Copy data (use cp or tar, don't forget the -p option to preserve dates, ownership, etc) 
* Change the deploy-config (edit yaml) to connect to CNS PV only
* Verify 
* Delete Legacy Gluster PVC

### What is the reclaim policy and what does it mean?
* Default reclaim policy of CNS is **Delete**
* If you delete your PVC, it will automatically delete the PV and the gluster volumes backing it. All data will be list

### Can I change the reclaim policy?
Policy Options:
* Retain – manual reclamation
* Recycle – basic scrub
* Delete – associated storage asset (gluster volume) is deleted

***

* It can be manually changes on a case by case basis
```
oc patch pv <pv_name> -p '{"spec":{"persistentVolumeReclaimPolicy":"Retain"}}'
```

### Should I manually delete a PV when I no longer need it?
* Never manually delete a PV
* Always delete the PVC you created which will in turn delete the PV and all associated objects

### What are the quotas for CNS PV?
* Gluster-File: 10pv and 200Gi
* Gluster-Block: 5pv and 200Gi

### What does a PVC object look like?
```
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: dynamicclaim
  annotations:
    volume.beta.kubernetes.io/storage-class: <storage_class_name>
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 1Gi
```


