# BC Government Single Sign-On Service Definition

## Service Description

### Summary

The BC Government **Single Sign-On (SSO)** simplifies authentication and authorization by enabling development teams to secure applications.

Development teams will be provisioned a private `realm` hosted on the [OpenShift Container Platform (OCP)](../OCP/ServiceDefinition.md) that can be self-administered and customized to the needs of one or more projects.

Each realm is configured out-of-the-box to support BCeID and IDIR as well as other 3rd-party oAuth 2.0 providers.

### Features & Functions

Users of this service gain access to the following:

#### Private Realm(s)

Each development team is given an SSO instances correlating to each of their environments (dev, test, and prod). These instances, commonly known as a `realm`, come configured out-of-the-box with following authentication providers:

* BC Government **IDIR**
* [BCeID](https://www.bceid.ca)
* [GitHub](https://developer.github.com/apps/building-oauth-apps/authorizing-oauth-apps/)

#### Access

Each realm has an its own web interface that development teams can use for self-serve administration. To integrate with your Web application the following industry standard protocols are available:

 * OpenID Connect
 * OAuth 2.0
 * SAML 2.0

For native mobile apps, the BC Government DevHub produced the following SDKs:

 * [iOS SDK](https://github.com/bcgov/mobile-authentication-ios)
 * [Android SDK](https://github.com/bcgov/mobile-authentication-android)


#### Community

We encourage a vibrant community around SSO that can be found on the `#sso` channel in [RocketChat](https://reggie.pathfinder.gov.bc.ca/?intention=LOGIN#error=login_required). Use your GitHub ID or IDIR to sign-up and join.


### Eligibility & Prerequisites

This service collection is offered to BC Government development teams building cloud native web or mobile application on the [OpenShift Container Platform](../OCP/ServiceDefinition.md).


### How to Request

Once a development team has their dev, test and prod environments setup on the OCP they can request their realm. Send the information noted in the [SSO Realm Request](https://pathfinder-faq-ocio-pathfinder-prod.pathfinder.gov.bc.ca/OCP/RequestSSORealm.html) to the `#devops-requests` channel of [RocketChat](https://reggie.pathfinder.gov.bc.ca/?intention=LOGIN#error=login_required).

If for you need further information, reach out to Todd Wilson, Director of Enterprise DevOps, Office of the Chief Information Officer; he can be located in the corporate directory. Setup a phone call to discuss your project and talk through SSO offering.

### Availability 

The SSO system runs as part of a high-availability cluster of nodes on the OCP. This service is available 24/7 with best effort to restart failed systems and realm provisions requests handled during normal business hours: Monday to Friday 9am to 5pm.


## How do I get help? (help and self service)

### Getting Help

The best source of help is the vibrant community of development teams using SSO for their projects. You can find this highly talented and knowledgeable group in the `#sso` channel on [RocketChat](https://reggie.pathfinder.gov.bc.ca/?intention=LOGIN#error=login_required).

For help beyond this contact one of the SSO administrators via the `#devops-sos` channel on [RocketChat](https://reggie.pathfinder.gov.bc.ca/?intention=LOGIN#error=login_required). 

## What does it Cost?

### Charges

For you my friend, there is no charge for this service. 

## Support Roles, Processes, Communications (platform ops)

The team supporting this service administrates the infrastructure and `master` realm that interfaces with the 3rd-party authentications providers. When your realm is setup they will promote a development team member to be the realm administrator; this person will take care of the day-to-day operation and configuration of the realm.

SSO interfaces with other BC Government services to provide authentication via IDIR or BCeID. These services are managed by different teams. For these services contact support via the standard `7-7000` support channel.

[RocketChat](https://reggie.pathfinder.gov.bc.ca/?intention=LOGIN#error=login_required). is the primary mode of communication. Specifically the `#sso` channel should be used for engage the community for best practices, configuration and troubleshooting questions.

For cluster wide service notifications that may impact SSO monitor the `#labops-alerts` and `#devops-alerts` channels in [RocketChat](https://reggie.pathfinder.gov.bc.ca/?intention=LOGIN#error=login_required).

For teams without RocketChat access, escalation, or to talk to a person IRL contact Todd Wilson, Director of Enterprise DevOps, Office of the Chief Information Officer.

## Service Delivery

This section is not yet completed.

```
* request workflow(s)
* change management
* service improvements
* service level
* security reviews
```

## Postface

If you intend to use BCeID you must contact the team that oversee BCeID prior to a production launch. This is required so that your project can get added to the BCeID catalogue and to understand what BCeID authentication options are available and what ones are deprecated.

---

# How to Contribute

If you would like to contribute, please see our [CONTRIBUTING](CONTRIBUTING.md) guidelines.

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.

# License

[![Creative Commons License](https://i.creativecommons.org/l/by/4.0/88x31.png)](http://creativecommons.org/licenses/by/4.0/)

```
Copyright 2019 Province of British Columbia

This work is licensed under the Creative Commons Attribution 4.0 International License.
To view a copy of this license, visit http://creativecommons.org/licenses/by/4.0/.
```

# Template

This document is based heavily on [Service Definition Questions and Checklist](https://its.ucsc.edu/itsm/checklist.html) from UC Santa Cruz.
