# Raft Snapshot Restore

**Warning:** Restores involve a potentially dangerous low-level Raft operation that is not designed to handle server failures during a restore. This command is primarily intended to be used when recovering from a disaster, restoring into a fresh cluster.

Running the restore process should be straightforward. However, there are a couple of actions you can take to ensure the process goes smoothly. First, make sure the datacenter you are restoring is stable and has a leader. You can see this using vault operator raft list-peers and checking server logs and telemetry for signs of leader elections or network issues.

Also, shutdown all Vault nodes except one to ensure consistency.

You will only need to run the process once, on the leader. The Raft consensus protocol ensures that all servers restore the same state.

```console
$ vault operator raft snapshot restore raft.snap
Restored snapshot
```

In the scenario where you have to restart/reinitialize the vault instance, following are the steps:

```bash
# First thing first, disable auto-sync from ArgoCD and stop the DB backup cronjob:
oc delete cronjob vault-backup

# ONLY IF THERE IS A NEED to restart everything brand new:
oc scale statefulset vault --replicas=0
oc delete pvc [<vault_data_pvc_name>]

# scale the vault server to one pod and initialize:
oc scale statefulset vault --replicas=1
oc exec -ti vault-0 -- vault operator init -recovery-shares=5 -recovery-threshold=3
# NOTE: make sure to capture the Root Token from output!!!!

# create a pod for BD restore usage according the yaml manifest down below

# once the pod is up, copy over the db snapshot:
oc cp <pod_name>:/backup/raft-<timestamp>.snap vault-0:/tmp/raft-<timestamp>.snap

# start the restore:
oc rsh vault-0
export VAULT_TOKEN=<new_root_token>
vault operator raft snapshot restore /tmp/raft-<timestamp>.snap

```

The above command creates a syslog entry on the leader node similar to the following:

```console
May 14 14:08:00 vm vault[21094]:     2020/05/14 14:08:00 [INFO]  raft: Restored user snapshot (index 813590)
```

or from the pod log you would see:
```console
storage.raft: restored user snapshot: index=1
```

Wrap up the restore:
```bash
# Wait for restore is complete, then scale up the rest of Vault pods (3 in lab & 5 in prod):
oc scale statefulset vault --replicas=3

# delete the pod:
oc delete pod vault-db-restore
```

Test the restore:
Refer to the [troubleshooting guide](./Troubleshooting.md) to test the Vault service.

Finally, reenable auto-sync from ArgoCD!

### DB restore pod manifest:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: vault-db-restore
  namespace: openshift-bcgov-vault
spec:
  containers:
    - name: vault
      command:
      - /bin/sh
      - '-c'
      args:
      - while true; do echo i am waiting; sleep 60; done
      env:
        - name: VAULT_ADDR
          value: https://vault-active:8200
      image: docker.io/hashicorp/vault-enterprise:1.8.3_ent
      imagePullPolicy: IfNotPresent
      resources: {}
      terminationMessagePath: /dev/termination-log
      terminationMessagePolicy: File
      volumeMounts:
        - name: vault-backup-cronjob
          mountPath: /backup
  dnsPolicy: ClusterFirst
  restartPolicy: Never
  securityContext: {}
  terminationGracePeriodSeconds: 30
  volumes:
    - name: vault-backup-cronjob
      persistentVolumeClaim:
        claimName: vault-backup-pv-claim

```

## Reference

[API docs for Raft storage](https://www.vaultproject.io/api-docs/system/storage/raft)
