# Structure within Vault

## Introduction

HashiCorp Vault offers multiple solutions to structure its stored secrets and provide access to different teams.

The following structure is flexible such that large consumers can be onboarded to the same
underlying Vault infrastructure without further constraints to how they consume Vault,
and teams and apps within BCgov Platform Services, for instance, utilize the same Vault Authentication Methods, naming convention, base structure, Vault roles, and Vault policies.

We will refer to those as use cases, as follows:

1. Use-Case (1): Teams/Apps, e.g., within BCgov Platform Services
2. Use-Case (2): Large consumers, e.g., separate ministry

## Structure Explained

This section describes the structure for the two use cases outlined above.

### Use Case 1 - Teams and Apps

For each team or app, a separate Vault Secrets Engine mount point is created.
Think about these mount points as entirely separate Windows or Linux file systems as a mental model. Furthermore, team A cannot even see the mount point of team B, and vice versa.

Note that mount points, similar to file systems, cannot conflict with each other, meaning they (a) cannot have the same name, i.e., `teamA/` must be a unique mount point, and (b) they cannot be nested, meaning `teamB/` cannot be mounted on `teamA/teamB/`.

In addition, each OpenShift cluster must have a corresponding Vault Kubernetes Authentication Backend.

The following table showcases the OpenShift cluster and Vault Auth structure. The columns hold the following information:

- **OpenShift Cluster:** The OpenShift cluster that needs to authenticate with Vault.
- **Vault Kubernetes Auth Backend:** The Vault path on which the OpenShift cluster specific Vault Auth Backend is mounted. (One Vault Auth Backend per OpenShift cluster is required.)
- **Vault Auth Role Name:** The name of the Vault role within the Auth Backend. The name is last part of the Vault path (after the last slash `/`).
- **Vault Auth Role Parameters:** Each Vault Auth Backend holds its roles that are used to authenticate
Kubernetes Service Accounts (KSA) from defined Kubernetes namespaces.

| OpenShift Cluster | Vault Kubernetes Auth Backend | Vault Auth Role Name              | Vault Auth Role Parameters                                                                                  |
|-------------------|-------------------------------|-----------------------------------|-------------------------------------------------------------------------------------------------------------|
| KLAB              | /auth/k8s-klab/               | /auth/k8s-klab/role/licensePlate-nonprod | bound_service_account_names=licensePlate-nonprod bound_service_account_namespaces=licensePlate-dev,licensePlate-test,licensePlate-tools |
| KLAB              | /auth/k8s-klab/               | /auth/k8s-klab/role/licensePlate-prod    | bound_service_account_names=licensePlate-prod bound_service_account_namespaces=licensePlate-prod                          |
| CLAB (KLAB DR)    | /auth/k8s-clab/               | /auth/k8s-clab/role/licensePlate-nonprod | bound_service_account_names=licensePlate-nonprod bound_service_account_namespaces=licensePlate-dev,licensePlate-test,licensePlate-tools |
| CLAB (KLAB DR)    | /auth/k8s-clab/               | /auth/k8s-clab/role/licensePlate-prod    | bound_service_account_names=licensePlate-prod bound_service_account_namespaces=licensePlate-prod                          |
| Silver            | /auth/k8s-silver/             | /auth/k8s-silver/role/licensePlate-nonprod | bound_service_account_names=licensePlate-nonprod bound_service_account_namespaces=licensePlate-dev,licensePlate-test,licensePlate-tools |
| Silver            | /auth/k8s-silver/             | /auth/k8s-silver/role/licensePlate-prod    | bound_service_account_names=licensePlate-prod bound_service_account_namespaces=licensePlate-prod                          |
| Gold         | /auth/k8s-gold/          | /auth/k8s-gold/role/licensePlate-nonprod | bound_service_account_names=licensePlate-nonprod bound_service_account_namespaces=licensePlate-dev,licensePlate-test,licensePlate-tools |
| Gold         | /auth/k8s-gold/          | /auth/k8s-gold/role/licensePlate-prod    | bound_service_account_names=licensePlate-prod bound_service_account_namespaces=licensePlate-prod                          |
| GoldDR         | /auth/k8s-golddr/          | /auth/k8s-golddr/role/licensePlate-nonprod | bound_service_account_names=licensePlate-nonprod bound_service_account_namespaces=licensePlate-dev,licensePlate-test,licensePlate-tools |
| GoldDR         | /auth/k8s-golddr/          | /auth/k8s-golddr/role/licensePlate-prod    | bound_service_account_names=licensePlate-prod bound_service_account_namespaces=licensePlate-prod                          |

Each team currently has four different Kubernetes namespaces per app, i.e., `licensePlate-tools`, `licensePlate-dev`, `licensePlate-test`, and `licensePlate-prod`. The license plate is a random ID that is generated by the Project Provisioner Workflow. The four Kubernetes namespaces can be simplified to only two Vault mount points per app, i.e., `licensePlate-nonprod`, and `licensePlate-prod`.

Components of the naming convention:

- licensePlate: Random ID
- dash-separator: `-`
- Kubernetes namespace indicator: tools, dev, test, or prod
- Example: `fi4Gh-tools`

When all these elements are combined, we get the following table that outlines the final structure. The three Kubernetes namespaces `tools`, `dev`, and `test` will use the same named Kubernetes Service Account that maps to one Vault role of the form `licensePlate-nonprod`. Similarly, they map to one Vault policy called `licensePlate-nonprod`. Additionally, they map to one Vault KV Secrets Engine mount point, also named `licensePlate-nonprod`. The `prod` Kubernetes namespace maps analogous with the `-prod` suffix instead of `-nonprod`.

All teams and apps reside in the same Vault namespace, i.e., `platform-services`.

| Kubernetes Namespace | Kubernetes Service Account (ns-scoped) | Vault k8s Auth Role | Vault Namespace   | Vault Policy    | Vault KV Path (KV mount before 1st /) |
|----------------------|-----------------|---------------------|-------------------|-----------------|---------------------------------------|
| licensePlate-tools        | licensePlate-nonprod | licensePlate-nonprod     | platform-services | licensePlate-nonprod | licensePlate-nonprod/tools                 |
| licensePlate-dev          | licensePlate-nonprod | licensePlate-nonprod     | platform-services | licensePlate-nonprod | licensePlate-nonprod/dev                   |
| licensePlate-test         | licensePlate-nonprod | licensePlate-nonprod     | platform-services | licensePlate-nonprod | licensePlate-nonprod/test                  |
| licensePlate-prod         | licensePlate-prod    | licensePlate-prod        | platform-services | licensePlate-prod    | licensePlate-prod/prod                     |

### Use Case 2 - Large Consumers

For large consumers, it is recommended to discuss license cost participation and a potential chargeback strategy first before continuing with the Vault onboarding process.

Once the initial decisions are made, the onboarding can start. To accommodate maximum flexibility in how Vault is consumed by a large Vault customer, a separate Vault Namespace should be provisioned.

**Important:** As different Vault namespaces are completely independent from each other, all other Vault components need to be configured in this new namespace, including Authentication Methods, Secret Engines, roles, and policies.

The question is who is responsible for provisioning the aforementioned objects in the new Vault namespace?

In case it is the large Vault customer's duty, the minimum Vault objects that need to be pre-provisioned to the new Vault namespace by the Platform Services Team are:

- a Vault admin policy needs to be applied to the new namespace, and
- a Vault Token, for example, to grant initial access to the new Vault consumer.

Additional Vault objects will need to be provisioned depending on the desired use. For example, if the large consumer wishes to consume their secrets on one of the OpenShift clusters managed by Platform Services, k8s authenication will need to be configured per cluster.
