# Troubleshooting

Here are some steps to take when you encounter errors.

## Check the status of Vault system in the cluster

- All cluster members should be in either a leader (1) or follower (4) state. Five (5) raft systems total in the Vault cluster
- Should be unsealed and the DR site should be active.

```bash
# show cluster members and their state: leader/follower
vault operator raft list-peers
# Run on each Vault: show status of the local Vault system
vault status
```

## Analyze log messages

- Use the central logging solution to analyze log messages from the erroneous Vault system
- Vault log messages can be found in Kibana by filtering on `kubernetes.namespace=openshift-bcgov-vault`

## Increase log-level

When the log messages do not reveal any or more information about the
observed behavior, consider increasing the log-level for Vault.

## Support ticket

Open a support ticket by visiting
[https://support.hashicorp.com/hc/en-us](https://support.hashicorp.com/hc/en-us)

If the error is reproducible, the support may ask to attach a debug file.
Generate this only if asked by the support.

To generate a debug archive, use the following command. Adjust the
*interval* and *duration* as needed.

```bash
vault debug -interval=1m -duration=10m
```