# Vault Rotate and Rekey

## Rotate

The `operator rotate` rotates the underlying encryption key which is used to secure data written to the storage backend. This installs a new key in the key ring. This new key is used to encrypted new data, while older keys in the ring are used to decrypt older data.
This is an online operation and does not cause downtime. This command is run per-cluster (not per-server), since Vault servers in HA mode share the same storage backend.

```console
$ vault operator rotate
Success! Rotated key

Key Term        2
Install Time    11 May 20 11:41 UTC
```

The log message looks similar to this:

```console
May 11 11:41:20 vm vault[99149]: 2020-05-11T11:41:20.696Z [INFO]  secrets.system.system_8461edb9: installed new encryption key
```

This completes the rotate process.

## Rekey

The `operator rekey` command generates a new set of unseal keys. This can optionally change the total number of key shares or the required threshold of those key shares to reconstruct the master key. This operation is zero downtime, but it requires the Vault is unsealed and a quorum of existing unseal keys are provided.

Login to a Vault system with RSH or locally with the appropriate token.

Important: The parameter `-target=recocery` in all following commands must be supplied for Vaults set up with Auto-Unseal.

```console
$ vault operator rekey -target=recovery -init -key-shares=5 -key-threshold=3
WARNING! If you lose the keys after they are returned, there is no recovery.
Consider canceling this operation and re-initializing with the -pgp-keys flag
to protect the returned unseal keys along with -backup to allow recovery of
the encrypted keys in case of emergency. You can delete the stored keys later
using the -delete flag.

Key                      Value
---                      -----
Nonce                    c7999768-1d1f-2cb3-b78e-1c8d09ef0f69
Started                  true
Rekey Progress           0/3
New Shares               5
New Threshold            3
Verification Required    false
```

This creates a log entry similar to the following.

```console
May 11 11:56:22 vm vault[99149]: 2020-05-11T11:56:22.688Z [INFO]  core: rekey initialized: nonce=c7999768-1d1f-2cb3-b78e-1c8d09ef0f69 shares=5 threshold=3 validation_required=false
```

Proceed with the `-target` and `-nonce` parameters.

```console
$ vault operator rekey -target=recovery -nonce=c7999768-1d1f-2cb3-b78e-1c8d09ef0f69
Rekey operation nonce: c7999768-1d1f-2cb3-b78e-1c8d09ef0f69
Unseal Key (will be hidden): 
Key                      Value
---                      -----
Nonce                    c7999768-1d1f-2cb3-b78e-1c8d09ef0f69
Started                  true
Rekey Progress           1/3
New Shares               5
New Threshold            3
Verification Required    false
```

Finish with the last command.

```console
$ vault operator rekey -target=recovery -nonce=c7999768-1d1f-2cb3-b78e-1c8d09ef0f69
Rekey operation nonce: c7999768-1d1f-2cb3-b78e-1c8d09ef0f69
Unseal Key (will be hidden): 
Key                      Value
---                      -----
Nonce                    c7999768-1d1f-2cb3-b78e-1c8d09ef0f69
Started                  true
Rekey Progress           2/3
New Shares               5
New Threshold            3
Verification Required    false

Rekey operation nonce: c7999768-1d1f-2cb3-b78e-1c8d09ef0f69
Unseal Key (will be hidden): 

Key 1: /fsRA/tWlkkSppl0yWUn
Key 2: 1p49phzIApwE6DxadNVNTMWbgieVCR26JAI
Key 3: /E8Vd/hFozwpTjd2L384OoSdjmm5shlW
Key 4: +0B+JsHg8igcoVraVyhTlY
Key 5: 374HeNY77fAdUkWeLiAEHi7ara

Operation nonce: c7999768-1d1f-2cb3-b78e-1c8d09ef0f69

Vault rekeyed with 5 key shares and a key threshold of 3. Please securely
distribute the key shares printed above. When Vault is re-sealed, restarted,
or stopped, you must supply at least 3 of these keys to unseal it before it
can start servicing requests.
```

This completes the Rekey process.
