---
title: User access to BC Gov GitHub repositories
description: This document describes the process to grant users access to BC Gov GitHub Repositories.
---

# Introduction

BC Gov maintains a set of "organizations" in GitHub where BC Gov digital product teams store and collaborate on the code and other digital materials they develop.  These organizations are as follows:

[bcgov](http://github.com/bcgov/) - used for the majority of BC Gov open source code and artifacts
[bcgov-c](http://github.com/bcgov-c/) - restricted org used by a small number of BC Gov project for storage of source code and artifacts that will ultimately become open source
[bcdevops](http://github.com/bcdevops/) - organization used for providing access control to DevOps platform, and storage of a set of code and artifacts related to the platform. Not applicable for this document.    

This document describes the process for requesting user access to the `bcgov` and `bcgov-c` organizations.  Access to the DevOps platform (and thereby the `bcdevops`org ) is described elsewhere.  The process for *creating* repositories is also described elsewhere. 

# Pre-requisites

Individuals who will become members of BC Gov organizations or collaborators on BC Gov repos must have:

- a GitHub account (ideally with a complete profile)
- 2-factor authentication enabled on their GitHub account

In order to invite a user to a repository, the repository must exist. If the project has an existing GitHub repository/repositories, the repo admin can add the new user via the "Add Collaborator" function in the repo "Settings" area in the Github web interface; no further requests are necessary.  If no repository exists, please consult the relevant section below for the GitHub organization where the repository should exist. 

# Repository Creation - `bcgov` organization

Currently, members of the `bcgov` GitHub organization have the ability to create new repositories themselves.  The capability to do this directly through GitHub's tooling will likely be replaced with a BC Gov-specific mechanism at some point in the future.  In the meantime, please follow the applicable directions below.  

- If a project's Product Owner or Technical Lead (or other similar gov resource) is already a member of the `bcgov` GitHub organization:
    - they should create a new repository directly through GitHub's web interface. 
    - they should ensure the repository complies with [BC Gov GitHub guidelines](https://developer.gov.bc.ca/Code-Management/Introduction-To-Github-and-Gov). The template repository [here](https://github.com/BCDevOps/opendev-template) provides a reference and starting point.
    - they may add additional users as "collaborators" via the "Collaborators and teams" settings function associated with the repository in the GitHub web interface.  

- If *neither* a project's Product Owner or Technical Lead (or other similar gov resource) is a member of the `bcgov` GitHub organization:
    - they should make a "BCGov GitHub Organization User Access Request" via a post in the #devops-requests channel of the Pathfinder Rocket.Chat. (URL: https://chat.pathfinder.gov.bc.ca).  The Product Owner may make this request for themselves, or for a Technical Lead (or similar)

If new repository needed:
- the product owner need to recommend *one* team member to the repo creator/owner, and make an `Access Request` according to the template below
- the rest of the project team can then be invited by the repo owner as collaborators

If new *private* repository needed temporarily (it's for closed source projects only. These projects will go Open Source once completed):
- the product owner is required to communicate with the Enterprise DevOps branch leadership and explain the necessity of a private repo
- after obtaining an approval from the communication, please follow the `GitHub Repo Request` template below
- for new users, please follow the `Access Request` template below


## Access Request

If the pre-requisites are complete, the product owner should make a request via a post in the #requests channel of the Pathfinder Rocket.Chat. (URL: https://chat.pathfinder.gov.bc.ca).
***New users may not request access for themselves.***

The request should include:

1. Project name
1. GitHub organization
1. New user's full name
1. New user's GitHub ID
1. New user's email address associated with the GitHub account
1. New user's organization (gov ministry plus division,branch,etc.) or company
1. New user's role on the project (e.g. Developer, QA, DevOps specialist, Scrum Master)
1. GitHub repositories if exist
1. Expiry (optional) - it is the team's responsibility to remove users from the repo when they no longer reque 

A sample "good" request is provided below and should be used as a template for submitting requests:

```markdown
GitHub User Access Request:
- Project: Govvapp
- GitHub Org: bcgov
- Full name: Govvie McGovster
- GitHub ID: govviemcgovster
- Email address: Govvie.Mcgovster@gov.bc.ca
- Organization: OCIO, Service BC
- Project role: Full-stack Developer
- Existing GitHub Repo: https://github.com/bcgov/govvie-gov, https://github.com/bcgov/govviest-gov
```

## GitHub Repo Request

Once a private repo request is accepted, the team product owner or technical leader should make a request via a post in the #requests channel of the Pathfinder Rocket.Chat. (URL: https://chat.pathfinder.gov.bc.ca).

The request should include:

1. Project name
1. Project description
1. Approver's name (and @ the person's Rocketchat account)
1. GitHub ID of the repo Owner (following the `Access Request`)

A sample "good" request is provided below and should be used as a template for submitting requests:

```markdown
GitHub Repository Request:
- Project: Govvapp-private
- Project description: the temporary repo for the Govvapp project, for bla
- Approver: @Todd.Wilson
- Repo Owner GitHub ID: govviemcgovster
```

## Access Removal Request

When an individual is no longer working on the project, it is the responsibility of the associated product owner or a GitHub repo admin to remove the user from the repo and notify the DevOps platform team via a post in the #requests channel of the Pathfinder Rocket.Chat. (URL: https://chat.pathfinder.gov.bc.ca).

The request should include:

1. User's full name
1. User's GitHub ID
1. GitHub Repositories

A sample "good" request is provided below and should be used as a template for submitting requests:

```markdown
GitHub User Access Removal Request:
- Full name: Govvie McGovster
- GitHub ID: govviemcgovster
- GitHub Repo: https://github.com/bcgov/govvie-gov, https://github.com/bcgov/govviest-gov
```
