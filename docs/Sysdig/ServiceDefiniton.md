---
description: The Sysdig Monitoring Service Definition outlines roles and responsibilities for operating the service.
resourceType: Documentation
title: BC Government Sysdig Monitoring Service Definition
tags:
  - sysdig
  - monitoring
---

# BC Government Sysdig Monitoring Service Definition

## Service Description

### Summary

### Features & Functions

Users of the service can leverage the Sysdig Monitoring Service running in the Silver cluster of the Openshift 4 Platform to build monitoring dashboards for their applications running on the Platform.

The Sysdig Service architecture comprises of 3 main components:
1) Sysdig agents installed on each node in the OCP 4 Silver cluster that collects information about the cluster and integrated apps. This component is supposed by the Platform Service Team.
2) A Sysdig operator that monitors CRDs created in app namespaces to provision user access to the Sysdig cloud service. This component is supported by the Platform Service Team.
3) Sysdig SaaS cloud service provided by the Sysdig vendor that includes tools for building rich dashboards. This service is supported by the Sysdig vendor.

### Eligibility & Prerequisites

This service is offered to BC Government development teams building cloud native applications on the Openshift 4 Platform.

### How to Request  

Access to the Sysdig Service is currently available by default to anyone with namespace access in the Silver Cluster via creating a certain CRD in a namespace. The details steps for creating an app account in Sysdig are documented in DevHub [here](https://developer.gov.bc.ca/OpenShift-User-Guide-to-Creating-and-Using-a-Sysdig-Team-for-Monitoring) 

### Availability

This service is available 24/7 with best effort to restart failed systems. 
More detailed SLAs are being developed and will be added in the near future.

## How do I get help? (help and self service)

### Getting Help

The best source of help is the vibrant community of development teams using Sysdig for their projects. 
You can find this highly talented and knowledgeable group in the `#devops-sysdig` channel on [RocketChat](https://chat.pathfinder.gov.bc.ca/channel/devops-sysdig).

For urgent help beyond this contact one of the Sysdig administrators via the `#devops-sos` channel on [RocketChat](https://chat.pathfinder.gov.bc.ca/channel/devops-sos).

## What Does It Cost?

For you my friend, there is no charge for this service.

## Support Roles, Processes, Communications (platform ops)

The team supporting this service administers the Sysdig agents and the Sysdig operator. Product teams are responsible to building and supporting the app Sysdig dashboards.

[RocketChat](https://chat.pathfinder.gov.bc.ca) is the primary mode of communication. Specifically the `#devops-sysdig` channel should be used for engage the community for best practices, configuration and troubleshooting questions.

For cluster wide service notifications that may impact Sysdig availability, monitor the `#devops-alerts` channels in [RocketChat](https://chat.pathfinder.gov.bc.ca/channel/devops-alerts).

For teams without RocketChat access, escalation, or to talk to a person IRL contact [Olena Mitovska](mailto:olena.mitovska@gov.bc.ca), Product Owner for Platform Services, BCDevExchange, Office of the Chief Information Officer.

## Change Management

Any service change will be communicated via the #devops-sysdig and #devops-alerts RocketChat channels.

## Service Improvements

Sysdig Service improvements include software upgrades for both Sysdig agents and its operator, feature integrations for the operator, bug fixes, etc. Many such operations will not result in any expected disruption for users. All notifications of upcoming changes or outages will be posted in #devops-sysdig and #devops-alerts channels.

## Service Level

TBD

## Security Reviews

Sysdig Service is covered by the existing Openshift PIA and has a STRA complete (contact Nick Corcoran if you need a copy). 





