---
title: How to Request a New OpenShift Project
description: The process for getting a new project set up on the BC Gov OpenShift platform.     
---
## How to Request a New OpenShift Project

The work of different teams within the OpenShift platform is organized into isolated "projects".  

Before you can start working on the platform, you need to submit a **project provisioning request** to have a set of projects provisioned by the **OCIO Enterprise DevOps branch**. 

Each new request must be reviewed and approved, including requests for additional projects from a team that already has one or more projects on the platform.

### Criteria for acceptance onto the platform

Before agreeing to host your project on the OpenShift platform, the OCIO Enterprise DevOps branch wants to be confident that:

* Your executive sponsors and endorses the project and the continuous service improvement delivery model
* Your project is be based on open source code, with custom code hosted in the [BCGov GitHub organization repositories](https://github.com/bcgov)
* Your project will be supported by a team with explicit roles such as DevOps specialist, Scrum Master and Product Owner — ideally with one or more of these roles filled by dedicated staff
* Your team will follow an agile methodology
* Your team must have a commitment to participate in and contribute to the BC Government open development community  

### Submit a project provisioning request

If you meet the above criteria, have your Product Owner or technical lead submit a project provisioning request through the [DevOps Requests Repo](https://github.com/BCDevOps/devops-requests).

A member of the Enterprise DevOps branch will be in touch to schedule a brief alignment meeting to confirm your project's suitability. 

Once your request(s) are approved, the projects will be created and the requestor will be notified when provisioning is complete.

NOTE: The names of OpenShift namespaces will be auto-generated at provisioning time, in the form of `<generated alphanumeric string>-<environment>`.
