---
title: Persistent Storage Services
description: Find helpful documentation regarding persistent storage options supported by the platform. 
---

## Pathfinder storage solutions

The platform has several different storage technologies in use as we work to provide an ever-improving storage experience.  These storage technologies support in-cluster storage types.  Currently we have 2 types of in-cluster persistent storage that we are able to support:

**FILE** - File storage is a great all-purpose storage type that can be attached to 1 or more containers, and is the recommended storageClass for most general application uses.

**BLOCK** - Block storage can offer additional performance and reliability for database or similar workloads, but is only able to be attached to 1 container at a time.

**Coming Soon!** **S3 Object Storage** - Object based storage that is available via a web based API instead of through a mounted directory.  A common implementation of this is the Amazon S3 API.  This allows remote access storage over the internet that does not require directly attaching to a running system.  We are targeting late January to have automatically provision-able object storage available to the platform.  The first Object Store integration will be hosted through the On-Prem OCIO object store service and available as S3 compatible buckets.

## Storage Technologies

### NetApp

The latest storage solution for the OpenShift platform is backed by a NetApp storage appliance that provides both file and block storage types to the cluster.  This technology is the target for all new FILE and BLOCK storage on the platform.

**NetApp File** - *netapp-file-standard* is the default storage class for the platform and the type of storage you will get if you do not specify a specific storageClass.

**NetApp Block** - *netapp-block-standard* is the current block storageClass target and the storageClass you should use for your block storage needs.

### Gluster (CNS)

The cluster has been using a gluster backed storage solution for the past 2 years to provide on-demand PVC provisioning for teams.  While this storage solution has helped grow our platform and has provided us with a great developer experience, it has reached the end of it's available capacity and new volume provisioning has been disabled.

This storage is **NOT** being decommissioned at this time, however it does mean that **new** provisioning will need to be directed to the current storage solution (NetApp), while all existing gluster storage volumes will remain available and supported on the 3.11 platform.

There are 3 CNS storage classes in use:

- gluster-file - All purpose storage
- gluster-file-db - All purpose storage with some tweaks for light DB use
- gluster-block - targeted workload that requires block access to storage.

### NFS Netbackup integrated

This storageClass **(nfs-backup)** was created to bridge the gap between in-cluster storage and the BCGov Netbackup infrastructure.  It is currently available as file storage only.  While this solution has provided us with a short term bridge for application backups, there are some caveats for it's use:

- **NOT** highly available storage
- Custom provisioning process (no direct provisioning via creating a PVC)
- Low default quota (for larger quota needs, a discussion and proof of concept implementation are requested before any quota increases are approved)
- Slower performance
- Deprecated for the OpenShift 4 environment.

### Legacy Gluster (decommissioned)

Our first storage solution was manually managed gluster storage.  While this storage was a decent first storage solution, it was not able to provide automatic PVC provisioning, and had higher costs than were sustainable.  This storage class has since been retired and is no longer available on the platform.

## Tools

There are a few tools available to help with managing your persistent storage above and beyond the built in OpenShift features.

**Database Backups**: Wade Barnes has curated a community project to help teams implement regular backups of their postgres databases hosted within the platform, please check out the repo here: [BCDevOps/Backup-Container](https://github.com/bcdevops/backup-container)

**Migrating Storage**: another community supported repository is available to help with migrating data from one PVC to another (moving from one storageClass to another, moving to a larger PVC, etc).  Please check out the repo here: [BCDevOps/StorageMigration](https://github.com/BCDevOps/StorageMigration)
