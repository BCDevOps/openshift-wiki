---
description: The Aqua Cloud Service Definition outlines roles and responsibilities for operating the service.
resourceType: Documentation
title: BC Government Aqua Cloud Service Definition
tags:
  - security
  - container scanning
---

# BC Government Aqua Service Definition

## Service Description

### Summary

The Aqua Cloud service is a security tool that helps secure images and containers by scanning them for vulnerabilities. It also is able to audit and enforce security policies. Read more about Aqua [here](https://www.aquasec.com/aqua-cloud-native-security-platform/).

### Features & Functions

The first iteration of Aqua Vulnerability Scanning Service in Openshift 4 Platform includes [container scanning](https://www.aquasec.com/products/container-security/) only. At this moment the access to scanning UI is limited to the Platform Services Team only (contact our Security Architect Nick Corcoran at Nick.Corcoran@gov.bc.ca to scan your namespaces). Aqua Service on the Platform is currently running in the `audit` mode producing vulnerability scan results for manual remediation by the product team,  the `enforcement` mode is __not enabled__ at this time. 

We are working on opening developer access to the Aqua CLI that will allow the product teams integrate Aqua scanning in app's CI/CD pipeline (coming in summer 2021). Developer Access to the Aqua UI will be rolled out in fall 2021.

The Aqua architecture comprises of several components:
1) Aqua Enforcers installed on each node of the Silver Openshift 4 cluster
2) A front end service that allows interacting with the Aqua API as well as the console
3) Scanners to offload image scanning from the front end service

### Eligibility & Prerequisites

This service is offered to BC Government development teams building cloud native applications on the Openshift 4 Platform.

### Availability

This service is available 24/7 with best effort to restart failed systems. We address incidents, issues and requests between 5pm and 9am on Monday to Friday excluding statutory holidays. 

The service is not highly available yet.

More detailed SLAs are being developed and will be added in the near future.

## How do I get help? (help and self service)

### Getting Help

The best source of help is the vibrant community of development teams using AQUA for their projects.  Contact @NickCorcoran to run a vulnerability scan for your namespaces and also to learn how to address found vulnerabilities.

You can find this highly talented and knowledgeable group in the `#devops-aqua` channel on [RocketChat](https://chat.developer.gov.bc.ca/channel/devops-aqua).

For urgent help beyond this contact one of the Aqua administrators via the `#devops-sos` channel on [RocketChat](https://chat.developer.gov.bc.ca/channel/devops-sos).

## What Does It Cost?

For you my friend, there is no charge for this service.

## Support Roles, Processes, Communications (platform ops)


[RocketChat](https://chat.developer.gov.bc.ca) is the primary mode of communication. Specifically the `#devops-aqua` channel should be used for discussions pertaining to this service.

For cluster wide service notifications that may impact Aqua availability, monitor the `#devops-alerts` channels in [RocketChat](https://chat.developer.gov.bc.ca/channel/devops-alerts).

For teams without RocketChat access, please refer to [RC Registration Process](https://developer.gov.bc.ca/Steps-to-join-Rocket.Chat), or to talk to a person IRL contact [Olena Mitovska](mailto:olena.mitovska@gov.bc.ca), Product Owner for Platform Services, BCDevExchange, Office of the Chief Information Officer.

## Change Management

Any service change will be communicated via the #devops-aqua and #devops-alerts RocketChat channels.

## Service Improvements

The Aqua Service is in a period of rapid development. Some of our roadmap items include:

- developer access to the Aqua UI for better UX with accessing scan results 
- developer access to the AQUA CLI to enable CI/CD pipeline integration
- deploy Aqua in active-active (HA) mode
- create training materials to be delivered in future OCP 20x workshops

## Service Level

TBD

## Security Reviews

Aqua Service is covered by the existing Openshift PIA and has a STRA complete (contact Nick Corcoran if you need a copy).
