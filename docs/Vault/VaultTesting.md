# Testing Vault Service

Resources to test on Vault services.

There are project sets and sample applications created to test on Vault service in each OpenShift clusters.

## Where to find the testing resources:
| cluster | namespaces |
|---|---|
| klab | abe3e9-dev |
| clab | dbfa0f-dev |
| silver | 6e2f55-dev |
| gold | 87d478-dev |
| golddr | 87d478-dev |

In the namespaces of klab and clab, you shall see a deployment called `vault-test`. Manifest can be found [here](./assets/vault-test-klab.yaml) and [here](./assets/vault-test-clab.yaml). Scale up one more pod to test if the init container runs without issues. The deployment is generated from [the vault demo app](https://github.com/bcgov/how-to-workshops/tree/master/vault/getting-started-demo)

In the production clusters, you'll see a RocketChat deployment in the dev namespace. Use that as a test. Please note this is temporary, vault test shall be moved to another project set!
