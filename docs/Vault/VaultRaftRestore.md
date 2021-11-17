# Raft Snapshot Restore

**Warning:** Restores involve a potentially dangerous low-level Raft operation that is not designed to handle server failures during a restore. This command is primarily intended to be used when recovering from a disaster, restoring into a fresh cluster.

Running the restore process should be straightforward. However, there are a couple of actions you can take to ensure the process goes smoothly. First, make sure the datacenter you are restoring is stable and has a leader. You can see this using vault operator raft list-peers and checking server logs and telemetry for signs of leader elections or network issues.

Also, shutdown all Vault nodes except one to ensure consistency.

You will only need to run the process once, on the leader. The Raft consensus protocol ensures that all servers restore the same state.

```console
$ vault operator raft snapshot restore raft.snap
Restored snapshot
```

The above command creates a syslog entry on the leader node similar to the following:

```console
May 14 14:08:00 vm vault[21094]:     2020/05/14 14:08:00 [INFO]  raft: Restored user snapshot (index 813590)
```

## Reference

[API docs for Raft storage](https://www.vaultproject.io/api-docs/system/storage/raft)
