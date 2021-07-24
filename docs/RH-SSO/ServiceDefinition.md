---
description: Pathfinder SSO Service Definition outlines roles and responsibilities for operating the service.
resourceType: Documentation
title: Pathfinder SSO Service Definition
tags:
  - keycloak
  - client
  - authentication
  - idir
  - bceid
---

# Pathfinder SSO Service Definition

## Service Description

### Summary

The BC Government **Pathfinder SSO** service, based on the Open Source Keycloak (aka Red Hat SSO) product, provides an industry standard (OIDC) and enterprise-policy compliant means of implementing authentication within applications that are also simple for development teams to provision and utilize.

Development teams are provisioned a set of clients within a multi-tenant instance of Keycloak running in the [OpenShift Container Platform (OCP)](../OCP/ServiceDefinition.md) platform that provide a simple authentication mechanism suitable for web and mobile applications. 

Each client exists in one of the "standard" realms based on the needs of the team. Each "standard" realm is configured with a set of centrally-managed identity providers (such as BCeID and IDIR).

### Features & Functions

Users of this service gain access to the following:

#### Dedicated OIDC Client Configuration

Development teams are provided with a set of clients (an isolated configuration within Keycloak), corresponding to their deployment environments (dev, test, and prod). Clients come configured out-of-the-box with an appropriate combination of the following identity providers:

* BC Government **IDIR**
* [BCeID](https://www.bceid.ca) Business and/or Basic (Personal BCeID is no longer supported)
* GitHub (in the DEV and TEST environments for rapid prototype testing)

Note: BCeID requires additional steps for SSO implementation. Details will be provided during onboarding.
Note: BC Services Card integration is not available through OCP-SSO through the "standard" realms. See [BC Services Card Integration](https://github.com/bcgov/ocp-sso/wiki/BC-Service-Card-Integration) for explanation and tips.

#### SSO Community

There is an online chat community around the SSO service that can be found on the #sso channel within the BC Government’s Pathfinder [RocketChat](https://chat.developer.gov.bc.ca/home). This online forum is used for asking questions, resolving possible issues and following developments on the service.

### Eligibility & Prerequisites

The Pathfinder SSO service is offered to BC Government teams who are building cloud native web or mobile applications. Teams wishing to use this service should initially connect with the [SSO Product Owner](mailto:BCGov.SSO@gov.bc.ca) to discuss their needs and ensure alignment prior to making an SSO implementation request.

Note: The Pathfinder SSO service is undergoing upgrades in 2021 and is currently not recommended for critical applications. Support is currently available only during business hours and only on a best efforts basis. If your application is critical, please contact Web Access Management (WAM) and/or Provincial Identity Information Management Program (IDIM).

### How to Request  

Teams wishing to have realms created should follow the steps outlined on the [SSO Client Request](RequestSSOClient.md) wiki page. If for you need further information, connect with the [SSO Product Owner](mailto:BCGov.SSO@gov.bc.ca).

### Availability

The SSO solution is deployed in a high-availability configuration within the highly-available BC Government OpenShift cluster.  Support is currently available only during business hours and only on a best efforts basis. If your application is critical, please contact Web Access Management (WAM) and/or Provincial Identity Information Management Program (IDIM).

Client provisioning requests will be reviewed and handled during normal business hours.

### Getting Help

SSO support is currently available through the previously mentioned [RocketChat](https://chat.developer.gov.bc.ca/home) on the channel called "#sso".

## What Does it Cost?

This SSO solution is an open-source solution with no associated costs.

## Support Roles, Processes, Communications (platform ops)

SSO only interfaces with other BC Government services to provide authentication via IDIR, BCeID or (potentially) other IDPs. These services are separately managed by dedicated identity provider (IDP) teams. For these services contact support via the standard BC Government 7-7000 support channel.

[RocketChat](https://chat.developer.gov.bc.ca/home) (#sso channel) is the primary mode of communication as related to the SSO solution. Use this channel to engage the community for best practices, configuration and troubleshooting questions.

For cluster-wide service notifications that may impact SSO monitor the **#devops-alerts** channels in [RocketChat](https://chat.developer.gov.bc.ca/channel/devops-alerts).

For teams without RocketChat access please send us an email to the [SSO Product Owner](mailto:BCGov.SSO@gov.bc.ca).

## Service Delivery

### SSO Access Onboarding

Please refer to [SSO Onboarding](https://github.com/bcgov/ocp-sso/wiki/SSO-Onboarding) on the wiki.

### Change Management

Any service change will be communicated via the #sso [RocketChat](https://chat.developer.gov.bc.ca/channel/sso) channel. For major service updates, the SSO operations team will reach out to primary contacts for all implemented SSO organizations.

### Service Improvements

SSO service improvements can include system upgrades, feature integrations, issue resolution and more. The SSO Operations team carry out change operations at a scheduled time with advanced notice communicated through the #sso [RocketChat](https://chat.developer.gov.bc.ca/channel/sso) channel. If disruptions or downtimes are expected during service improvement implementation, one of the following standard change windows will be selected. Monday or Wednesday - 7:00 PM PST to 9:00 PM PST

Further, if the change is more significant a Technical Information Bulletins (TIBs) will be posted in the BC Gov My Service Center located at [Service Now](https://ociomysc.service-now.com/sp?id=ocio_tibs&kb_id=e925c3d71b499490776c8734ec4bcbb9&kb_category=e9850dfb1b0d1490a43c3333cc4bcbb3). 

### Service Level

This service is available 24/7 with best efforts support, during business hours only, to restart failed systems and address open issues. 

### Security Reviews

***Corporate PIA***
The Corporate Privacy Impact Assessment (PIA) is completed and signed off. This means basic deployments can refer to the corporate PIA avoiding re-work. Teams must still detail in their program PIA how they are using identity providers in their application context.

### Additional Information

If you intend to use BCeID, you must contact the Identity Information Management (IDIM) team prior to a production launch. This is required so that your project can get added to the BCeID catalogue and to understand available identity provider authentication options.

Copyright 2019 Province of British Columbia

This work is licensed under the Creative Commons Attribution 4.0 International License.
To view a copy of this license, visit http://creativecommons.org/licenses/by/4.0/.