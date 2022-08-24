# Backup with Raft Snapshot

## Automated Solution

In a production environment, a backup should run on a clear schedule.
The time between backups depends on the Recovery Point Objective (RPO).
As Vault is typically a read-heavy solution while secrets are less often added or changed,
an hourly schedule is sufficient.

Every full hour, i.e., at 6:00, 7:00, 8:00, ..., a full backup is written to the
NFS storage endpoint, which is backed by NetApp.
Each backup's filename includes a date timestamp of the form **YYYY-MM-DD_HHMMSS**.
The table below provides a quick overview.

|||
|---------------------|--------------------------|
| **Source**          | Vault Integrated Storage via Vault API call |
| **Destination**     | NFS Storage Class (backed by NetApp)        |
| **Frequency**       | Hourly, i.e., at 6:00, 7:00, 8:00, ...      |
| **Filename Format** | YYYY-MM-DD_HH-MM.snap                       |

A Kubernetes CronJob is defined to backup Vault every hour to the NFS storage endpoint.
This CronJob will use Vault's Kubernetes Authentication Method.
Currently, it uses a pre-created Vault Token for authentication (`VAULT_TOKEN`).

The CronJob is set up directly after the deployment of Vault with an Ansible role, named `vault_backup_install`.
Notice that it forbids concurrent job execution to ensure a consistent backup state.
Furthermore, it automatically deletes backups older than ten days.

The CronJob is backed by a 20 GiB PVC using the NetApp StorageClass. The cronjob and PVC manifest can be found from Vault kustomize repo, which the auth configuration can be found from the Vault service setup doc.

## Manual Option

The `vault` binary has subcommands to manage the integrated Raft storage backend.

To run a backup manually, execute the following command:

```bash
vault operator raft snapshot save raft.snap
```

## Reference

[API docs for Raft storage](https://www.vaultproject.io/api-docs/system/storage/raft)
