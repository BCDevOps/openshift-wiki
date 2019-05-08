---
title: How to request new user access to OpenShift 
description: The process for granting a new user access to the BC Gov OpenShift platform.
---

# Introduction

The OpenShift platform provides platform and project-level access control. Access to the the OpenShift platform is managed by the OCIO Enterprise DevOps branch.  This document describes the pre-requisites and mechanism for granting *platform* access.  Project-level access is described [here](../HowTo/GrantUsersAccessToProject.md).

Keep in mind that every team member *may not* need access to OpenShift and the security principle of least privilege should be considered prior to requesting platform access, and when granting project-level access. 

# Pre-requisites

A new user who will be granted access to OpenShift must have:

- a GitHub account (ideally with a complete profile)
- 2-factor authentication enabled on their GitHub account

Additionally, the project to which the user will be added:
- must already have been provisioned via the process described [here](StartingANewProject.md)
- must have one or more administrative users 

## Access Request

If the pre-requisites are complete, the product owner or a project admin associated with the project provisioining should make a request via a post in the #devops-requests channel of the Pathfinder Rocket.Chat. (URL: https://chat.pathfinder.gov.bc.ca).
***New users may not request access for themselves.***

The request should include:

1. New user's full name
1. New user's GitHub ID
1. New user's email address
1. New user's organization (gov ministry plus division,branch,etc.) or company
1. New user's role on the project (e.g. Developer, QA, DevOps specialist, Scrum Master)
1. OpenShift project name(s) that the user will be granted access to. (project level access must still be granted by the project admin)
1. Expiry (optional) - it is the team's responsibility to remove users from projects when they no longer reque 

A sample "good" request is provided below and should be used as a template for submitting requests:

```markdown
OpenShift User Access Request:
- Full name: Govvie McGovster
- GitHub ID: govviemcgovster
- Email address: Govvie.Mcgovster@gov.bc.ca
- Organization: OCIO, Service BC
- Project role: Full-stack Developer
- OpenShift projects: xyz123-tools, xyz123-test, xyz123-test, xyz123-prod  
```

## Access Removal Request

When an individual no longer requires access to a project on the OpenShift platform, it is the responsibility of the associated product owner or a project admin to remove the user from the project and notify the DevOps platform team via a post in the #devops-requests channel of the Pathfinder Rocket.Chat. (URL: https://chat.pathfinder.gov.bc.ca).

The request should include:

1. User's full name
1. User's GitHub ID
1. User's email address
1. User's organization (gov ministry plus division,branch,etc.) or company
1. User's role on the project (e.g. Developer, QA, DevOps specialist, Scrum Master)
1. OpenShift project name(s) that the user had been granted access to. (project level access should still be removed by the project admin) 

A sample "good" request is provided below and should be used as a template for submitting requests:

```markdown
OpenShift User Access Removal Request:
- Full name: Govvie McGovster
- GitHub ID: govviemcgovster
- Email address: Govvie.Mcgovster@gov.bc.ca
- Organization: OCIO, Service BC
- Project role: Full-stack Developer
- OpenShift projects: xyz123-tools, xyz123-test, xyz123-test, xyz123-prod  
```
