# Testing Vault Service

Resources to test on Vault services.

There are project sets and sample applications created to test on Vault service in each OpenShift clusters.

## Where to find the testing resources:
| cluster | namespaces |
|---|---|
| klab | b01faf-dev |
| clab | dbfa0f-dev |
| silver | ea8776-dev |
| gold | b4d659-dev |
| golddr | b4d659-dev |
| klab2 | TBD |

Things to know about testing setup:
- There is a Vault Test project set created in each OpenShift cluster by Registry. A `vault-test` deployment is created in the dev namespace in each of the project set
- We have created an ArgCD application for each testing manifest
- Manifest can be found [here](https://github.com/bcgov-platform-services/platform-gitops-vault/test)
- The deployment is generated based on [the vault demo app](https://github.com/bcgov/how-to-workshops/tree/master/vault/getting-started-demo)
- After each Vault service change, make sure to restart the `vault-test` pod to verify it can pull secrets from Vault properly!
