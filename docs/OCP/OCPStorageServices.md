---
title: Persistent Storage Services
description: Documentation regarding persistent storage options supported by the platform.
tags:
  - netapp
  - net app
  - nfs
  - storage
  - pvc
  - persistent
---

## OpenShift Storage Solutions

- [Storage Technologies](#storage-technologies)
- [Tools](#tools)
- [Storage Class FAQ](#storage-class-faq)

The platform has several different storage technologies in use as we work to provide an ever-improving storage experience. Currently we have 3 types of persistent storage that are available:

**FILE** - File storage is a great all-purpose storage type that can be attached to 1 or more containers, and is the recommended storageClass for most general application uses. This is powered by NFS.

**BLOCK** - Block storage can offer additional performance and reliability for database or similar workloads, but is only able to be attached to 1 container at a time. This is powered by iSCSI.

**S3 Object Storage** - Object based storage that is available via a web based API instead of through a mounted directory. A common implementation of this is the Amazon S3 API. This allows remote access storage over the internet that does not require directly attaching to a running system.

## Storage Technologies

### NetApp

The primary storage solution for the OpenShift platform is backed by a NetApp storage appliance that provides both file and block storage types to the cluster.

All NetApp storage classes support resizing (bigger only). So you can start with a small volume and just edit your PVC to have a bigger `.spec.resources.requests.storage` later if you need more. You may need to restart the pods attached to let the resize trigger on re-mount.

**NetApp File** - `netapp-file-standard` is the default storage class for the platform and the type of storage you will get if you do not specify a specific storageClass.

`netapp-file-backup` is the same as `netapp-file-standard` but its contents are backed up daily by the OCIO backup infrastructure. More details at [Backup and Restore](https://developer.gov.bc.ca/OCP4-Backup-and-Restore)

**NetApp Block** - `netapp-block-standard` is the current block storageClass target and the storageClass you should use for your block storage needs.

There are two additional storage classes not available to dev teams that are just for the operations teams to use for infrastructure components like the ElasticSearch stack or the image registry. They are `netapp-file-extended` and `netapp-block-extended`.

### Dell EMC Elastic Cloud Storage

The OCIO has an [object store](https://ssbc-client.gov.bc.ca/services/ObjectStorage/overview.htm) service that supports the AWS S3 protocol. The service is aimed at objects typically over 100 KB, updated infrequently, retained longer term, with performance response targets of 100ms or more. This may be a good option if your application needs to store large amounts of archival data that won’t fit in the typical PVC quotas provided. It may also be good for large backup zip files or tarballs.

This service replicates data between the two datacenters and the API endpoints are load balanced between them to ensure uptime even if a datacenter goes offline.

Please contact your Ministry IMB to get access to the Ministry service account that controls access and where a bucket for your app will be provisioned.

[More details](https://github.com/BCDevOps/OpenShift4-Migration/issues/59)

## Tools

There are a few tools available to help with managing your persistent storage above and beyond the built in OpenShift features.

**Database Backups**: Wade Barnes has curated a community project to help teams implement regular backups of their databases hosted within the platform, please check out the repo here: [BCDevOps/Backup-Container](https://github.com/bcdevops/backup-container)

**Migrating Storage**: another community supported repository is available to help with migrating data from one PVC to another (moving from one storageClass to another, moving to a larger PVC, etc). Please check out the repo here: [BCDevOps/StorageMigration](https://github.com/BCDevOps/StorageMigration)

## Storage Class FAQ

### Which should I choose

If you don't have a specific need, choose file. Only choose block storage if you have a specific reason to do so, preferably only in your PROD projects.

As this is a shared platform with automatic provisioning enabled for your needs, the urge to provision "more" or "the best available" is contradictory to the best use of the platform. With resizing available on request, there should be no reason to order more than you know you need *today*. Specifically, don't request what you *think* you need, only request what you know you currently need. If those needs change, then simply update your storage requests.

### Mins and Maxes (NetApp storageClasses)

The minimum size is 20Mi, provisioning will fail any smaller. You no longer need to request a full 1Gi if you don't need it.

Maximum size is 256Gi, provisioning will fail any bigger. Larger custom quotas won't get around this currently as we've set the provisioner to this limit to ensure the NetApp can remain properly balanced.

### Performance

One question is often "how fast is each", and well, it depends on your workload.

ElasticSearch specifically does not work with NFS protocol and needs block storage.

If you have specific performance needs, then we would suggest testing both types of storage with your specific workload to see which meets your needs.

### Pros and Cons of each

File storage can be mounted by multiple pods at the same time. The protocol is also a bit more robust to maintenance and fails over faster to the secondary storage node better.

Block storage cannot be mounted during maintenance. Any pods already running will failover properly to the secondary NetApp node, but any newly launched pods will fail to start until both NetApp nodes are available. We have an open case with NetApp to see if this can be improved.

File storage ends up being a bit more flexible (mountable as RWX, etc), while Block storage is generally more performant for database or other small transaction/write intensive application uses.

Object storage is great for storing large volumes of data (many terabytes) for long periods of time very cheaply. But its response time can be quite slow for retrieving individual files.

### Other fun details

All netapp-*-standard volumes are thin provisioned and have de-duplication and compression enabled. The de-duplication and compression jobs are currently run during a nightly job at 00:10.
