---
title: How to Request a New OpenShift Project
description: The process for getting a new project set up on the BC Gov OpenShift platform.     
---
## How to Request a New OpenShift Project

The work of different teams within the OpenShift platform is organized into isolated "projects".  Prior to a team beginning work on the platform, they must have a set of projects provisioned for them by the OCIO Enterprise DevOps branch. This document describes the pre-requisites and mechanics of the provisioning process. 

***Each project must be reviewed and accepted, including additional projects for a team that already has project(s) on the platform.*** 

## Pre-requisites

Prior to project provisioning, your team lead/sponsor will need to meet with the Enterprise DevOps branch leadership to have your project/app/product reviewed and accepted for deployment on the DevOps platform.

**To request a meeting, please contact [Todd Wilson](mailto:Todd.Wilson@gov.bc.ca)**

### Criteria for acceptance onto the platform:

* Your executive must sponsor and endorse the project and the continuous service improvement delivery model
* Your project must be based on open source code, with custom code hosted in the [BCGov GitHub organization repositories](https://github.com/bcgov)
* Your project must be supported by a team with explicit roles such as DevOps specialist, Scrum Master and Product Owner— ideally with one or more of these roles filled by dedicated staff
* Your team must be following an agile methodology
* Your team must have a commitment to participate in and contribute to the BC Government open development community  

# Project Provisioning Request

Once your project is accepted, your product owner or technical lead can request the resources you need through the [DevOps Requests Repo](https://github.com/BCDevOps/devops-requests).

Once your request(s) are reviewed by a member of the Enterprise DevOps branch's Platform Services team, the projects will be created and the requestor will be notified when the provisioning is complete.

NOTE: The names of OpenShift namespaces will be auto-generated at provisioning time, in the form of `<generated alphanumeric string>-<environment>`.
