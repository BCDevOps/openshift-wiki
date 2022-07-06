# Troubleshooting

Here are some steps to take when you encounter errors.

## Check the status of Vault system in the cluster

- All Vault cluster members should be in either a leader (1) or follower (4) state. Five (5) raft systems total in the Vault cluster
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

## Using Vault CLI on console

Login to a Vault instance, and open the Vault terminal from console (top right corner).

> Note: this vault command line is limited. For full access, rsh into the vault pod instead!

Here are some common things to check:
```shell
# get list of role for a specific auth method
vault list auth/<auth_name>/role
# approle - terraform
# oidc - team access

# get details about a role (this should match the module from vault terraform repos)
vault read auth/<auth_name>/role/<role_name>
```

## Commons issues

### Vault SA authentication issue:

We have disabled issuer validation for the Vault SA auth request. See [doc ref](https://discuss.hashicorp.com/t/after-upgrading-to-kubernetes-1-21-kubernetes-authentication-request-to-vault-fails-with-permission-denied/29392/2)

Sometimes during Vault server restart, this configuration might be reverted back to default. Which will cause error messages like this:
```shell
2022-04-26T21:10:49.332Z [ERROR] auth.handler: error authenticating:
  error=
  | Error making API request.
  |
  | URL: PUT https://vault-lab.developer.gov.bc.ca/v1/platform-services/auth/k8s-klab/login
  | Code: 403. Errors:
  |
  | * permission denied
   backoff=18.22s
```

When app teams report this, use [our vault test deployment](./VaultTesting.md) to verify the issue in the same cluster first. If it's Vault wide, do the following:
```shell
# go to a vault server pod
export CLUSTER_NAME=<klab,clab,silver,gold,golddr>
export K8S_HOST=https://api.$CLUSTER_NAME.devops.gov.bc.ca:6443
export VAULT_TOKEN=<root_token>

# see if disable_iss_validation is set to false now:
vault read -namespace=platform-services auth/k8s-$CLUSTER_NAME/config
# if so, run the following to update it!
# vault write is just updating not overwriting,
# so we just need to include the disable_iss_validation instead of the full token_reviewer_jwt + kubernetes_ca_cert
vault write -namespace=platform-services auth/k8s-$CLUSTER_NAME/config kubernetes_host="$K8S_HOST" disable_iss_validation=true
```

Now test again.

### Vault Terraform lock:

This should not happen again, but for any reason if you see `Error: Error locking state: Error acquiring the state lock: workspace already locked (lock ID: "bcgov/xxx-prod")` from the GitHub action output, that means there used to be mutiple processes executing on Vault terraform at the same time and they locked each other. The fix to prevent it from happening has been added [here](https://github.com/bcgov-c/terraform-vault-prod/pull/161).

First make sure there is no running GitHub workflows from the terraform repo. If nothing else is indicating a different error, try to force unlock:
```shell
❯ curl \
--header "Authorization: Bearer $TOKEN" \
--header "Content-Type: application/vnd.api+json" \
--Request POST \
https://app.terraform.io/api/v2/workspaces/ws-uL3nwzQGkoyQzvAX/actions/unlock
```
