# Vault Terraform

## Background:

We are leverage Vault terraform modules to manage policies and mountPath for application teams.

Here are the setup and module manifests:
- [Vault Setup for Terraform](https://github.com/bcgov-platform-services/platform-gitops-vault/tree/main/hack/ansible/roles/vault_prepare_for_terraform)
  - setup the Vault Namespace `root` and `platform-services`
  - create policies
    - policyadmin: to manage policies
    - namespaceadmin: to manage vault namespaces
    - approle-secret-id: to rotate access tokens
    - backup: to do periodic raft db backup
  - create AppRole (as an auth provider) for Terraform
  - create the role (attach polices to AppRole)
  - manually add the AppRole role ID as a secret in GitHub repo
- [Terraform Module for Provisioning Vault Resources](https://github.com/bcgov-c/terraform-vault-module).
- The Vault module resources are in the following repos:
  - [production Vault (silver, gold, golddr)](https://github.com/bcgov-c/terraform-vault-prod)
  - [production Vault (klab, clab, klab2)](https://github.com/bcgov-c/terraform-vault-lab)

Here is a typical flow for new project set on Vault:
1. app team creates/changes project set from Registry app
1. Provisioner creates a PR in the `vault-terraform-env` repo that contains the terraform module resources for app team mountPath
1. PRs like this have an `auto-merge` label that will merge it right away
1. Github workflow gets triggered and creates a job to apply all the new terraform modules in vault service

## Things to know and note:
- we are using the Terraform service provided by the Cloud Platform team, for any requests and troubleshooting need, post a message on [RocketChat channel](https://chat.developer.gov.bc.ca/group/aws-tenant-requests)
- Registry app triggered PRs get merged automatically, but manually created PRs need to be approved by one of the platform team member. Please make sure to check the workflow job runs successfully for all changes to the repo!
- during PR creation, workflow will get triggered and run a job that only plan for the changes, which is a sanity check that doesn't really do anything. It is the merge to `main branch` that cause an actual apply of the update-to-date manifest.
- if there are multiple PRs created by Registry at the same time, only the job triggered by the last PR merge event will run. This is because we setup `concurrency groups` to prevent terraform from locking itself. GitHub workflow doesn't queue up jobs, it only has one waitlist spot, that said the latest one gets picked! No worries about the other rejected jobs, we only need the latest version of the `main branch` for module update.
- there is no extra notification when workflow jobs fail, please make sure to watch the repo which will send you email when things go wrong
- We are currently running the Terraform module locally in GitHub workflow runs, where there is a clone of the module code base and `terraform apply` locally on GitHub machines. There will be benefits to upload the .tf files up to TFC, where runs can't be killed once triggered (that prevents locking). Also then we are able to access the terraform server logs from TFC. This is a supported usage from cloud pathfinder team. For now, we are okay with this run, but should investigate of migrating to TFC later on.
