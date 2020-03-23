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

The BC Government **Single Sign-On (SSO)** service, based on the Open Source Keycloak (aka Red Hat SSO) product, provides an industry standard (OIDC) and enterprise-policy compliant means of implementing authentication and authorization within applications that is also simple for development teams to provision, utilize and manage.

Development teams are provisioned a set of `realm`s within a multi-tenant instance of Keycloak running in the [OpenShift Container Platform (OCP)](../OCP/ServiceDefinition.md) platform that can be self-administered and customized to the needs of one or more applications.

Each realm will be configured with a set of centrally-managed identity providers (such as BCeID, IDIR, and GitHub) based on the needs of the team. Teams may add integrations with other identity providers within their realms based on their needs.

### Features & Functions

Users of this service gain access to the following:

#### Private Realm(s)

Development teams are provided with a set of `realms` (an isolated configuration/namespace within Keycloak), corresponding to their deployment environments (dev, test, and prod). Realms come configured out-of-the-box with one or more of the following identity providers:

* BC Government **IDIR**
* GitHub
* [BCeID](https://www.bceid.ca)
* [BC Services Card](https://www2.gov.bc.ca/gov/content/governments/government-id/bc-services-card)

_note_: that BCeID and BC Services Card have extra setup steps in production KeyCloak, teams will be informed on details during on-boarding.

#### Access

Each realm has an its own web interface that development teams can use for self-serve administration. To integrate with an application the following industry standard protocols are available:

 * OpenID Connect (OIDC) 
 * SAML 2.0
 
> OIDC is the recommended protocol, and at the time of this writing there are no BC Government teams using the SAML protocol with Keycloak.

For native mobile apps, the BC Government developer community has produced the following SDKs to provide integration with Keycloak for the purposes of authentication:

 * [iOS SDK](https://github.com/bcgov/mobile-authentication-ios)
 * [Android SDK](https://github.com/bcgov/mobile-authentication-android)

#### Community

There is a vibrant community around the SSO service that can be found on the `#sso` channel in the BC Government Pathfinder [RocketChat](https://chat.pathfinder.gov.bc.ca/channel/sso).  This is the forum for asking questions and following developments on the service.

### Eligibility & Prerequisites

This service is offered to BC Government development teams building cloud native web or mobile applications.  Teams wishing to use this service should connect with the Enterprise DevOps Team to discuss their needs and ensure alignment prior to making a request.

### How to Request  

Teams wishing to have realms created should follow the steps outlined at [SSO Realm Request](RequestSSORealm.md).

If for you need further information, reach out to Todd Wilson, Director of Enterprise DevOps, Office of the Chief Information Officer; he can be located in the corporate directory. 

### Availability

The SSO system is deployed in a high-availability configuration within the highly-available BC Government OpenShift cluster. This service is available 24/7 with best effort to restart failed systems.

Realm provisioning requests will be reviewed and handled during normal business hours.

## How do I get help? (help and self service)

### Getting Help

The best source of help is the vibrant community of development teams using SSO for their projects. You can find this highly talented and knowledgeable group in the `#sso` channel on [RocketChat](https://chat.pathfinder.gov.bc.ca/channel/sso).

For help beyond this contact one of the SSO administrators via the `#devops-sos` channel on [RocketChat](https://chat.pathfinder.gov.bc.ca/channel/devops-sos).

## What does it Cost?

### Charges

For you my friend, there is no charge for this service.

## Support Roles, Processes, Communications (platform ops)

The team supporting this service administers the Keycloak application, its supporting database, as well as the `master` realm and global identity providers (IDIR, BCeID, and GitHub). When your realm is set up they will assign a member of the requesting development team to be the realm administrator; this person will take care of the day-to-day operation and configuration of the realm.

SSO interfaces with other BC Government services to provide authentication via IDIR, BCeID or BC Services Card. These services are managed by different teams from the team providing Keycloak. For these services contact support via the standard `7-7000` support channel.

[RocketChat](https://chat.pathfinder.gov.bc.ca) is the primary mode of communication. Specifically the `#sso` channel should be used for engage the community for best practices, configuration and troubleshooting questions.

For cluster wide service notifications that may impact SSO monitor the `#devops-alerts` channels in [RocketChat](https://chat.pathfinder.gov.bc.ca/channel/devops-alerts).

For teams without RocketChat access, escalation, or to talk to a person IRL contact Todd Wilson, Director of Enterprise DevOps, Office of the Chief Information Officer.


## Service Delivery

### request workflow

- Start a request here: https://github.com/BCDevOps/devops-requests
- Have an onboarding meeting with the SSO Ops team to go through KeyCloak service and common practices
- The requester will be given access to [Realm-O-Matic](https://realm-o-matic.pathfinder.gov.bc.ca) and fill in a form with project team details, which will be used to auto generate the KeyCloak resources, i.e.: `realm`, `Admin groups` and etc.
- Once the `realms` are created with the assigned admin user, it's up to the team to further manage them.

### change management

Any service change will be communicated via #sso RocketChat channel. For major service update, the SSO ops team will reach out to product owner for notice.

### service improvements

SSO service improvements including system upgrade, feature integration, issue fixing and etc. The SSO Ops team will be conducting the operation on a scheduled time, with advanced notice in the #sso RocketChat channel. If disruption/downtime is expected during service improvement, the team will discuss on maintenance time in the channel to minimize effects.

### service level

TBD

### security reviews

***Corporate PIA***
The corporate Privacy Impact Assessment is now completed and signed off. This means basic deployments can refer to the corporate PIA avoiding re-work. Teams must still detail in their program PIA how they are using identity providers in their application context.


```

## Postface

If you intend to use BCeID or BC Services Card, you must contact the IDIM team prior to a production launch. This is required so that your project can get added to the BCeID/BC Services Card catalogue and to understand what this identity provider authentication options are available and what ones are deprecated.

---

# License

[![Creative Commons License](https://i.creativecommons.org/l/by/4.0/88x31.png)](http://creativecommons.org/licenses/by/4.0/)

```
Copyright 2019 Province of British Columbia

This work is licensed under the Creative Commons Attribution 4.0 International License.
To view a copy of this license, visit http://creativecommons.org/licenses/by/4.0/.
```

# Template

This document is based heavily on [Service Definition Questions and Checklist](https://its.ucsc.edu/itsm/checklist.html) from UC Santa Cruz.
