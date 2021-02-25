---
description: The EDB Service Definition outlines roles and responsibilities for operating the service.
resourceType: Documentation
title: BC Government EDB Operator Service Definition
tags:
  - edb
  - postgres
  - enterprisedb
  - rdba
  - operator
---

# BC Government EDB Operator Service Definition

## Service Description

### Summary

### Features & Functions

The EnterpriseDB (EDB) service is provided as one of the Shared Services on the BC Gov's DevOps OpenShift 4 Platform. 
This service enables product teams to use the EnterpriseDB version of PostgreSQL to create HA database instances in their app. 
The service is enabled by an operator built by EDB and installed in OCP 4 Silver cluster, which can be used to install and add HA capabilities to the instances of Postgres in various namespaces.

You can find further information on the operator's features and functionality here: https://docs.enterprisedb.io/cloud-native-postgresql

Associated with the operator is the RemoteDBA (RDBA) support service offered by the EnterpriseDB vendor under a separate license. 
The Enterprise DB's RDBA team assist the Platform Services Team with providing support for the EDB operator and can also provide support for database clusters belonging to the product teams which have purchased a license for their service. 

### Eligibility & Prerequisites

This service is currently offered to BC Government development teams building cloud native applications on the OpenShift 4 Platform. 
The EnterpriseDB Service is available to all the product teams **who have purchased a license from the EnterpriseDB vendor**. 

Those without a license can use the operator to build a database cluster to test, which will operate for 30 days. 
If there is no license added to the database cluster before the end of the 30 period, the operator will no longer perform work on the database pods.
This means that the database version will not be updated, and new pods will not automatically spin up to join the cluster if necessary.
Please see EDB's documentation for more details about what may happen to an operator-built database without a license after the trial period has expired.

### How to Request  

Teams do not need to request anything from the platform team in order to make use of this operator. 
Licenses are required in order to ensure that your database maintains its HA status after 30 days.
If a team wishes to purchase a license, they should contact [Olena Mitovska](mailto:olena.mitovska@gov.bc.ca) in order to discuss options - 
licenses are purchased collectively for ease of administration.

### Availability

The operator is available to permit installation at all hours on the Silver cluster. Availability on Gold is to follow.
Teams with RDBA support should contact the the EDB's RDBA team first, in the event of an issue with the operator. 
Hours of availability for RDBA depend on your team's SLA with them.

If something goes wrong with the operator that requires the Platform Services Team's intervention, platform support is available during business hours.

## How do I get help? (help and self service)

### Getting Help

#### Help with your Database - RDBA

Those who have purchased a license will have access to the RDBA support team. 
They will contact you about the best methods for obtaining their support.
They will require some access to your project in order to provide full support for your database -
each team is welcome to determine how much access they are willing to provide.
Teams who have purchased this type of support should turn to RDBA first with any problem regarding their database.

Should RDBA determine that the problem requires elevated privileges, teams are encouraged to work with RDBA to provide that support where possible.
If, for example, the RDBA team requires admin privileges on a namespace but your team has determined that they will not provide that level of access,
an admin from the your team should work directly with RDBA to take the necessary action.

If the elevated privileges required to deal with the problem are beyond what the project team can provide, 
please contact the Platform Services team directly in #edb channel in Rocketchat if the problem is not urgent or in #devops-sos if it is urgent and is impacting production workloads. 
It is very unlikely that the platform services team should be involved in any issue that is not directly related to the operator itself.
Please ensure that this level of cluster-wide privileges are needed, before contacting the Platform Services team.

If you are certain that it is a cluster-level issue, please contact the team via the `#devops-sos` channel on [RocketChat](https://chat.developer.gov.bc.ca/channel/devops-sos).

#### Help with your Database - Community

The best source of help is the vibrant community of development teams using Postgres for their projects. 
You can find this highly talented and knowledgeable group in the `#edb` channel on [RocketChat](https://chat.developer.gov.bc.ca/channel/edb).

If there is a cluster-wide problem with the operator, the platform services team should be notified in order to troubleshoot and fix the issue.
Please be sure that this level of cluster-wide privileges are needed before contacting platform services.
If you are certain that it is a cluster-level issue, please contact the team via the `#devops-sos` channel on [RocketChat](https://chat.developer.gov.bc.ca/channel/devops-sos).


## What Does It Cost?

The platform team does not charge anything for this service. EDB licenses, however, are required for long-term use of the operator.

There are three total licenses available for purchase:
- An enterprise EDB cluster unicore license provides a license for up to 1 core of use of the full-featured enterprise version of EDB's database.
- A community cluster unicore license provides a license for up to 1 core of use of the Postgres opensource database with EDB's operator in order to make use of full HA features.
- An RDBA license provides more active and preventative support from RDBA for your databases, at a rate of one database cluster per license.

If you wish to purchase a database and/or support license, contact [Olena Mitovska](mailto:olena.mitovska@gov.bc.ca) to discuss costs.

## Support Roles, Processes, Communications (platform ops)

The team supporting this service administers the EDB operator used to install the database, but does not administer your database itself.

[RocketChat](https://chat.developer.gov.bc.ca) is the primary mode of communication. 
Specifically the `#edb` channel should be used for engage the community for best practices, configuration and troubleshooting questions.
You may also wish to keep an eye on the `#patroni` channel as well to keep up with database problems, as Patroni also uses Postgres and thus some issues may cross over between the two HA solutions.

For cluster wide service notifications that may impact the operator or your database, monitor the `#devops-alerts` channels in [RocketChat](https://chat.developer.gov.bc.ca/channel/devops-alerts).

For teams without RocketChat access, escalation, or to talk to a person IRL, contact [Olena Mitovska](mailto:olena.mitovska@gov.bc.ca), Product Owner for Platform Services, BCDevExchange, Office of the Chief Information Officer.

## Service Delivery

Teams can create a custom resource in order to create a EDB Postgres database in the same way they typically create other OpenShift objects.
Please see the [Operator Documentation](https://docs.enterprisedb.io/cloud-native-postgresql) for more details on how to use the operator.

### Change Management

Any service change will be communicated via the `#edb` and `#devops-alerts` RocketChat channel.

### Service Improvements

Updates to the operator will be performed on a regular basis in order to provide new functionality and security as developed by EDB.
These updates should very rarely impact teams directly, as the operator only performs installation and updates - 
changes to the operator have no impact on already-running databases.
As such, teams will be notified of changes to the operator, but only limited notice may be provided. 

Updates to your database itself will be controlled by your team.

### Service Level

TBD

### Security Reviews

EDB is covered by the existing OpenShift PIA.

A STRA is currently underway.


```

---

# License

[![Creative Commons License](https://i.creativecommons.org/l/by/4.0/88x31.png)](http://creativecommons.org/licenses/by/4.0/)

```
Copyright 2021 Province of British Columbia

This work is licensed under the Creative Commons Attribution 4.0 International License.
To view a copy of this license, visit http://creativecommons.org/licenses/by/4.0/.
```

# Template

This document is based heavily on [Service Definition Questions and Checklist](https://its.ucsc.edu/itsm/checklist.html) from UC Santa Cruz.
