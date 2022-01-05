---
description: Summary of the Vault service
tags:
- security
- stra
---
# BC Government Vault Secrets Management  

## Service Definition

### Summary

The BC Government **Vault Secrets Management Service**, based on the Hashicorp Vault product, provides a tool for securely accessing secrets. A secret is anything that you want to tightly control access to, such as API keys, passwords, or certificates. Vault provides a unified interface to any secret, while providing tight access control and recording a detailed audit log.

Kubernetes Secrets backed by ETCD are still available for use by platform teams. It is recommended that Kubernetes Secrets be reserved for non-secrets (e.g. environment variables).

>Non-secrets may be stored in Vault if desired.

### Features & Functions

Users of this service gain access to the following:

**Secure Secret Storage**: Arbitrary key/value secrets can be stored in Vault. Vault encrypts these secrets prior to writing them to persistent storage, so gaining access to the raw storage isn't enough to access your secrets.

**Dynamic Secrets**: Vault can generate secrets on-demand for some systems, such as Azure or SQL databases. For example, when an application needs to access a PostgreSQL database, it asks Vault for credentials, and Vault will generate a keypair with valid permissions on demand. After creating these dynamic secrets, Vault will also automatically revoke them after the lease is up. <https://www.vaultproject.io/docs/secrets/databases/postgresql>

**Data Encryption: Vault** can encrypt and decrypt data without storing it. This allows security teams to define encryption parameters and developers to store encrypted data in a location such as SQL without having to design their own encryption methods.

**Leasing and Renewal**: All secrets in Vault have a leaseassociated with them. At the end of the lease, Vault will automatically revoke that secret. Clients are able to renew leases via built-in renew APIs.

**Revocation**: Vault has built-in support for secret revocation. Vault can revoke not only single secrets, but a tree of secrets, for example all secrets read by a specific user, or all secrets of a particular type. Revocation assists in key rolling as well as locking down systems in the case of an intrusion.

### Eligibility & Prerequisites

Development teams are provisioned a Vault service account for each environment (dev, test, prod, and tools) through the automation backing the [Platform Services Registry](https://registry.developer.gov.bc.ca). Each ProjectSet created in the Registry can have up to two technical contacts assosicated with it, these technical contacts are given write access to Vault and can manage secrets within a ProjectSet's two mount points (nonprod, prod).

### How to Request

You don’t need to!! If you have a project set, you have at least one technical contact who can access Vault through the CLI or UI, and you have a Kubernetes Service Account associated with your project set's Vault Mount Points in each namespace environment. (dev, test, prod, and tools)

> Service Accounts take the form of `licensePlate-vault`

### Availability

The Vault Secrets Management Service is deployed in a high-availability configuration within the highly available BC Government OpenShift Gold Service clusters. This service is available 24/7 with best effort to restart failed systems.

## How do I get help? (help and self service)

The best source of help is the vibrant community of development teams using Vault for their projects.

You can find this highly talented and knowledgeable group in the [#devops-vault channel on RocketChat](https://chat.developer.gov.bc.ca/channel/devops-vault).

For help beyond this contact one of the Vault administrators via the [#devops-sos channel on RocketChat](https://chat.developer.gov.bc.ca/channel/devops-sos).

## What does it Cost?

There is no charge for this service.

## Support Roles, Processes, Communications (platform ops)

The team supporting this service administers the Vault application, its supporting services.

Vault interfaces with Kubernetes services to provide authentication via service accounts.

RocketChat is the primary mode of communication. Specifically, the [#devops-vault](https://chat.developer.gov.bc.ca/channel/devops-vault) channel should be used to engage the community for best practices, configuration and troubleshooting questions.

For cluster wide service notifications that may impact Vault monitor the [#devops-alerts channels in RocketChat](https://chat.developer.gov.bc.ca/channel/devops-alerts).

For teams without RocketChat access, escalation, or to talk to a person IRL contact [Olena Mitovska](mailto:olena.mitovska@gov.bc.ca), Product Owner for Platform Services, BCDevExchange, Office of the Chief Information Officer.

## Service Delivery

### **request workflow(s)**

There is no onboarding to use Vault.

As part of project onboarding Kubernetes service accounts are generated for your project namespaces and these service accounts are used for integrating team applications with Vault.

Project teams can choose to use Vault or ETCD backed Kubernetes Secrets, but it is recommended that Vault be used for secrets.

### **change management**

Any service change will be communicated via #devops-vault and #internal-devops-vault RocketChat channels. For major service update, the Vault Ops team will reach out to product owner for notice.

### **service improvements**

Vault Secrets Management Service improvements including system upgrades, feature integration, issue fixing and etc. The Vault Ops team will be conducting the operation on a scheduled time, with advanced notice in the #devops-vault RocketChat channel. If disruption/downtime is expected during service improvement, the team will discuss on maintenance time in the channel to minimize effects.

### **service level**

TBD

### **security reviews**

An STRA for Vault has been completed by the Platform Services team.
