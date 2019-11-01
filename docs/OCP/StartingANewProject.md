---
title: How to Request a New OpenShift Project
description: The process for getting a new project set up on the BC Gov OpenShift platform.     
---
## How to Request a New OpenShift Project

The work of different teams within the OpenShift platform is organized into isolated "projects".  Prior to a team beginning work on the platform, they must have a set of projects provisioned for them.  Project provisioning for the OpenShift platform is managed by the OCIO Enterprise DevOps branch. This document describes the pre-requisites as well as the mechanics of the provisioning process. 

## Pre-requisites

Prior to project provisioning, a manual/human step is required that involves a project/product team lead / sponsor communicating with the Enterprise DevOps branch leadership and having their project/app/product reviewed and accepted for deployment on the DevOps platform.

The projects currently deployed on the platform are largely "Continuous Service Improvement Lab"-affiliated, but there is a set of other well-aligned projects on the platform as well.

Criteria for acceptance onto the platform include:

* executive sponsorship and endorsement of the project and the CSI delivery model
* based on open source code, with custom code hosted in the BCGov GitHub organization repositories
* following an agile methodology
* a sustainable team structure with explicit roles such as DevOps specialist, Scrum Master and Product Owner ideally with one or more of these roles filled by dedicated staff
* a commitment to participate and contribute in the BC Government open development community  

***Each project must be reviewed and accepted, including additional projects for a team that already has project(s) on the platform.*** 

# Project Provisioning Request

Once a project is accepted, the team product owner or technical leader should make a request at [DevOps Request Repo](https://github.com/bcgov/devops-request-records).

The request should include:

1. The short team/organization name. Commonly, this is the ministry name plus program area/branch, but may also be just the program area. (e.g. MOTI, OCIO, NR, EAO, DEVEX)
2. Product acronym/short name (e.g. EPIC, TFRS, IOT, etc.)
3. Product full name (e.g. Transportation Fuels Reporting System)
4. One sentence product description
5. The desired "environments". Generally this will be `tools`, `dev`, `test` and `prod`, but other/different environments may be provisioned in certain circumstances, as determined by the DevOps Platform Team Services team.
6. The GitHub ID and email address (and RocketChat account if exists) of one or more BC Gov employee who will be the technical steward(s) of the product. These should be individuals with a hands-on technical skill set - typically a DevOps specialist, developer, or architect.  This(these) individual(s) will be responsible for adding other team members to the project spaces following the process [here](../HowTo/GrantUsersAccessToProject.md).  If this(these) user(users) have not been granted access to the OpenShift platform as described [here](./RequestUserAccess.md), they will be granted platform access as part of the project provisioning process.
7. The full name and email address (and RocketChat account if exists) of the BC Gov employee who will is the Product Owner or business sponsor of the product.
8. If it exists at the time the request is made, the GitHub repo(s) that will contain the product's source code. Note: this must be within repositories within the BCGov GitHub organization.

A sample "good" request is provided below and should be used as a template for submitting requests:

```markdown
New Project Request:
- Short team/organization name: OCIO
- Product short name: DevHub
- Product full name: Developer Hub
- Product description: Resources for digital product teams to learn new skills, discover tools and resources, and connect with the developer community.
- Desired environments: tools, dev, test, prod
- Product Technical Steward: govviemcgovster / Govvie.McGovster@gov.bc.ca / govvieRocketChat
- Product Owner: Paula.Product@gov.bc.ca / paulaRocketChat
- GitHub repo: https://github.com/bcgov/devhub-app-web
```
Once the request is reviewed by a member of the Enterprise DevOps branch's Platform Team Services team, the projects will be created and the requestor will be notified when the provisioning is complete.

NOTE: The names of OpenShift namespaces will be auto-generated at provisioning time, in the form of `<generated alphanumeric string>-<environment>`.
