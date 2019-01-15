---

title: OpenShift Container Platform Service Definition
description: This resource is a Service Definition of the BC Government OpenShift Container Platform Service and concisely describes the key elements of the service for current and prospective users of the service.
author: sheaphillips
image: https://cdn2.hubspot.net/hubfs/4305976/images/openshift-legacy/logos/openshift/Logotype_RH_OpenShift_wLogo_RGB_Gray.png
---


# BC Government OpenShift Container Platform Service Definition

## Service Description

### Summary

The BC Gov OpenShift Container Platform Service is a multi-tenant container platform that government application development teams may use to develop and deploy modern, cloud native software applications. The service provides development teams with a set of isolated project spaces (namespaces) with associated resource quotas in which they can develop and deploy their applications and tools supporting their development lifecycle - from day-to-day development through to production.  

### Features & Functions

The core of the service is an instance of Red Hat's OpenShift Container Platform (OCP) running in the government data centre in Kamloops.  Details of the configuration of the BC Gov OCP instance are as follows:

* multi-tenant deplyoment, with RBAC and software defined network providing isolation between teams' environments
* highly-available OCP deployment with ability to perform maintenance with no/minimal impact to applications running on it
* 2 factor authentication and authorization provided via GitHub OAuth integration
* standard set of project spaces provided to teams is `tools` (for development lifecycle support tools such as CI, automated testing, and code quality tools), `dev`, `test`, and `prod` - each corresponding to a deployment stage.
* dyamically provisioned persistent storage backed by containerized Gluster (aka CNS and OCS)
* resource quotas associated with each project space; these quotas have been set at levels adequate to support the development activities and production deployment workloads for many typical government applications 
* a catalog of pre-defined technology stacks/tools to provide "application quick starts" or fully functional services to applications

### Eligibility & Prerequisites

The service is offered to BC government development teams who are engaged in building modern, custom, open source software for internal or citizen-facing applications using modern technology architecture, stacks and development approaches such as cloud native/12 factor, DevOps and continuous delivery.

In order to use the service, teams must:

* ensure their proposed application is architecturally suitable to run within a containerized environment
* commit to building their applications "in the open" meaning the underlying code is stored within the public 'bcgov' GitHub organization's repositories
* commit a named individual for the lifetime of the application who is responsible, and qualified to keep the application's code, libraries, and supporting tools (CI pipeline, etc.) functional, current and, secure. 
* able to operate in an environment of continuous improvement and change.  The former implies that teams will continue to enhance their applications after it is in production and the latter implies that the teams will set themselves up to be responsive to changes in the service, related technology/tools, or other factors such as security vulnerabilities.

### How to Request

For teams that do not have applications already on the platform and for teams with existing applications and wishing to add additional ones, the first step is to arrange a discussion with the DevOps Platform Services team.  This can be arranged by contacting [Todd Wilson](mailto:todd.wilson@gov.bc.ca), Director of Enterprise DevOps, Office of the Chief Information Officer.  This will serve to confirm prerequisites are met and to determine overall suitability of the propsepective application and team for the Service.  

The request process is subject to change, but currently, once suitability is determined through the session above, a request can be made via the #request channel in the DevOps Platofrm group messaging platform including the following information:

* the short team/organization name. Commonly, this is the ministry name plus program area/branch, but may also be just the program area. (e.g. MOTI, OCIO, NR, EAO, DEVEX)
product acronym/short name (e.g. EPIC, TFRS, IOT, etc.)
* product full name (e.g. Transporation Fuels Reporting System)
* One sentence product description
* the desired environments (e.g. tools, dev, test, prod)
* the GitHub ID and email address of the BC Gov employee who will be the owner/steward of the product. This should be someone with a hands-on technical skillset and is typically a developer or architect. 
* if it exists, the GitHub repo that contains the app's code. Note this must be within the BCGov GitHub organization.

### Availability 

The Service is designed to be highly available such that maintenance activities can be completed while remaining operational.  As such, there are no scheduled change windows.  Planned and standard maintenance such as upgrades is generally performed *during business hours* with advance notice given to teams using the platform.  

The Service also provides capabilities for applications hosted on it to be highly available.  It is the responsibility of the development teams using the platform to ensure their applications leverage these capabilities appropriately and otherwise design their applications in a manner to be resilient to maintenance of the Service, and to provide the level of availability required for the lines of business they serve.

## How do I get help?

### General Assistance

Assistance with *using* the Service (getting started, developing applications, etc.) is provided via the self-service links below. Peer/community assistance is also provided via a vibrant community on the DevOps Platform group messaging service's `#general` and `#help-me` channels.

### Training

Periodic internally-delivered training is provided by the DevOps Platform Services team. Commercial OpenShift training is also available from Red Hat.  For details on either type of training and internal training schedule, contact [Todd Wilson](mailto:todd.wilson@gov.bc.ca), Director of Enterprise DevOps, Office of the Chief Information Officer. 

### Support

During business hours, support for production issues with the *Service itself* are handled through the group messaging service's `#help-me` and `#operations` channels, which are monitored by the OCIO DevOps Plaform Services team, and the Platform Technical Operations team, made up of DXC staff and their contracted platform operations experts.  Outside of business hours, support requests can be submitted via the SSBC Help Desk (aka "77000").

Business hour support for issues with applications, components and services deployed by teams using the service will be provided by the DevOps Platform Services Team on a best effort, based on availability and priority.  In general, teams should develop sufficient knowledge of the tools they deploy on the Service to be self-sufficient.


## Self-service support

Below is a set of recommended resources that provide background materials related to developing and deploying applications on the OpenShift platform, which is the foundation of the Service.

* [DevOps with OpenShift](https://www.openshift.com/promotions/devops-with-openshift.html)
* [Deploying to OpenShift](https://assets.openshift.com/hubfs/pdfs/Deploying_to_OpenShift.pdf)
* [Get Started with the OpenShift Command Line](https://docs.openshift.com/container-platform/3.10/cli_reference/get_started_cli.html)
* [OpenShift Developer Guide](https://docs.openshift.com/container-platform/3.9/dev_guide/index.html)

## What does it Cost?

There is currently no cost for use of the Service.

## Support Roles, Processes, Communications (platform ops)

* roles
* resources for support - documentation, training, tools, monitoring
* escalation
* what communication channels are used
* what types of messages/notices are distributed?

## Service Delivery

* request workflow(s)
* change management
* service improvements
* service level
* security reviews


