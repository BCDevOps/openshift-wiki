---
description: The Single Sign-On (SSO) Service Definition outlines roles and responsibilities for operating the service.
resourceType: Documentation
title: BC Government SSO Service Definition
tags:
  - keycloak
  - realm
  - client
  - authentication
  - idir
  - bceid
---

# BC Government SSO Service Definition

## Service Description

### Summary

The BC Government **Single Sign-On (SSO)** service, based on the Open Source Keycloak (aka Red Hat SSO) product, provides an industry standard (OIDC) and enterprise-policy compliant means of implementing authentication and authorization within applications that are also simple for development teams to provision, utilize and manage.

Development teams are provisioned a set of realms within a multi-tenant instance of Keycloak running in the [OpenShift Container Platform (OCP)](../OCP/ServiceDefinition.md) platform that can be self-administered and customized to the needs of one or more applications.

Each realm will be configured with a set of centrally-managed identity providers (such as BCeID, IDIR, and GitHub) based on the needs of the team. Teams may add integrations with other identity providers within their realms based on their needs (e.g. BC Services Card).

### Features & Functions

Users of this service gain access to the following:

#### Private Realm(s)

Development teams are provided with a set of realms (an isolated configuration/namespace within Keycloak), corresponding to their deployment environments (dev, test, and prod). Realms come configured out-of-the-box with one or more of the following identity providers:

* BC Government **IDIR**
* GitHub
* [BCeID](https://www.bceid.ca) (Business and Basic, Basic, Business)
* [BC Services Card](https://www2.gov.bc.ca/gov/content/governments/government-id/bc-services-card)

Note: Both the BCeID and BC Services Card identity providers both require additional steps for SSO implementation. Details will be provided during onboarding.

#### Access

Each realm has its own web interface that development teams can use for self-serve administration. To integrate with an application the following industry standard protocols are available:

 * OpenID Connect (OIDC) - _Recommended_
 * SAML 2.0
 
For native mobile apps, the BC Government developer community has produced the following Software Development Kits (SDK) to provide integration with the SSO solution for the purposes of authentication:

 * [iOS SDK](https://github.com/bcgov/mobile-authentication-ios)
 * [Android SDK](https://github.com/bcgov/mobile-authentication-android)

#### SSO Community

There is an online chat community around the SSO service that can be found on the #sso channel within the BC Government’s Pathfinder [RocketChat](https://chat.developer.gov.bc.ca/home). This online forum is used for asking questions, resolving possible issues and following developments on the service.

### Eligibility & Prerequisites

This Single Sign-On (SSO) service is offered to BC Government teams who are building cloud native web or mobile applications. Teams wishing to use this service should initially connect with the [Enterprise DevOps Team](mailto:BCDevExchange@gov.bc.ca) to discuss their needs and ensure alignment prior to making an SSO implementation request.

Note: This SSO service is undergoing upgrades in 2021 and is currently not recommended for critical applications. Support is currently available only during business hours and only on a best efforts basis. If your application is critical, please contact Web Access Management (WAM) and/or Provincial Identity Information Management Program (IDIM).

### How to Request  

Teams wishing to have realms created should follow the steps outlined on the [SSO Realm Request](RequestSSORealm.md) webpage. If for you need further information, connect with the [Enterprise DevOps Team](mailto:BCDevExchange@gov.bc.ca).

### Availability

The SSO solution is deployed in a high-availability configuration within the highly-available BC Government OpenShift cluster.  Support is currently available only during business hours and only on a best efforts basis. If your application is critical, please contact Web Access Management (WAM) and/or Provincial Identity Information Management Program (IDIM).

Realm provisioning requests will be reviewed and handled during normal business hours.

### Getting Help

SSO support is currently available through the previously mentioned [RocketChat](https://chat.developer.gov.bc.ca/home).

## What Does it Cost?

This SSO solution is an open-source solution with no associated costs.

## Support Roles, Processes, Communications (platform ops)

The team supporting this service, administer the SSO application, its supporting database, the ‘master’ realm and global identity providers (i.e. IDIR, BCeID, and GitHub). When your realm is set up they will assign a member of the requesting development team to be the realm administrator; this person will take care of the day-to-day operation and configuration of the realm.

SSO only interfaces with other BC Government services to provide authentication via IDIR, BCeID or BC Services Card. These services are separately managed by dedicated identity provider (IDP) teams. For these services contact support via the standard BC Government 7-7000 support channel.

[RocketChat](https://chat.developer.gov.bc.ca/home) (#sso channel) is the primary mode of communication as related to the SSO solution. Use this channel to engage the community for best practices, configuration and troubleshooting questions.

For cluster wide service notifications that may impact SSO monitor the **#devops-alerts** channels in [RocketChat](https://chat.developer.gov.bc.ca/channel/devops-alerts).

For teams without RocketChat access please send us an email to: [BCDevExchange](mailto:BCDevExchange@gov.bc.ca).

## Service Delivery

### SSO Access Workflow

1. Initiate a Request [here](RequestSSORealm.md).
2. Onboarding meeting with the SSO Operations representative to review the SSO service and common practices.
3. Upon approval, the requester will be given access to [Realm-O-Matic](https://realm-o-matic.developer.gov.bc.ca) which will be used to enter requested. 
4. Once the realms are created with the assigned admin user, it's up to the team to further manage them.

### Change Management

Any service change will be communicated via the #sso [RocketChat](https://chat.developer.gov.bc.ca/channel/sso) channel. For major service updates, the SSO operations team will reach out to primary contacts for all implemented SSO organizations.

### Service Improvements

SSO service improvements can include system upgrades, feature integrations, issue resolution and more. The SSO Operations team would carry out the operation at a scheduled time with advanced notice communicated through the #sso [RocketChat](https://chat.developer.gov.bc.ca/channel/sso) channel. If disruptions or downtimes are expected during service improvement implementation, a change window with minimal impacts will be selected.

### Service Level

This service is available 24/7 with best efforts support, during business hours only, to restart failed systems and address open issues. 

### Security Reviews

***Corporate PIA***
The Corporate Privacy Impact Assessment (PIA) is completed and signed off. This means basic deployments can refer to the corporate PIA avoiding re-work. Teams must still detail in their program PIA how they are using identity providers in their application context.

### Additional Information

If you intend to use BCeID or BC Services Card, you must contact the Identity Information Management (IDIM) team prior to a production launch. This is required so that your project can get added to the BCeID/BC Services Card catalogue and to understand available identity provider authentication options.

Copyright 2019 Province of British Columbia

This work is licensed under the Creative Commons Attribution 4.0 International License.
To view a copy of this license, visit http://creativecommons.org/licenses/by/4.0/.



