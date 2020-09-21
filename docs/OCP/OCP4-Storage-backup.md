---
title: OCP4 Backup and Restore
description: Documentation regarding backups and restore services in OCP4.
tags:
  - OCP4
  - backup
  - restore
  - netapp-file-backup
  - netapp
  - net app
  - nfs
  - storage
  - pvc
  - persistent
---

## OCP4 Backup and Restore

## Backups

The storage class `netapp-file-backup` is backed up with the standard [OCIO Backup](https://ssbc-client.gov.bc.ca/services/AppHosting/base.htm#databackup) infrastructure. Full backups are performed monthly, incremental backups are performed daily, and the backups are retained for 90 days.

Quota for this storage class is 25Gi by default. If you need more please put in a [request](https://github.com/BCDevOps/devops-requests/issues/new/choose) for a quota change.

Simply create a PVC with the `netapp-file-backup` and mount it to your pod as you would any other PVC.

## Restores

NetApp and Trident use pretty unhelpful names for the volumes they create. So be sure to track the name of your PV.

```console
$ oc get pvc
NAME           STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS           AGE
backup-test    Bound    pvc-02e9d855-cd63-480d-a1d7-9b638b04f6ff   20Gi       RWX            netapp-file-backup     3d19h
```

Save the part `pvc-02e9d855-cd63-480d-a1d7-9b638b04f6ff` for later in case you delete your PVC.

When you find that you need a restore, submit a [request](https://github.com/BCDevOps/devops-requests/issues/new/choose) for a restore. Supply the source PV you need restored, the date you need restored from, and the destination path. Source and destination can be the same PVC or separate. You can specify sub-folders instead of the whole volume.

DXC will swivel the request to our Backup team for execution and report back when completed.

Sample request:

```text
Date: June 19 2020 @2pm
Cluster: Silver
Source PV: pvc-02e9d855-cd63-480d-a1d7-9b638b04f6ff
Destination PV: pvc-6d81a45c-bd21-4f87-a855-dde9f0c512e0/2020-06-19
```

*Note: both PVC source and destination must be a netapp-file-backup PVC on the same cluster.*
