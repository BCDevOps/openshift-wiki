---
title: How to request new GitHub user access or repository creation
description: The process for inviting new user to contribute to BC Gov GitHub Repositories.
---

# Introduction

BC Gov project teams have their Open Source project on the GitHub `bcgov` organization repositories....

# Pre-requisites

A new user who will be invited to contribute to the BC Gov GitHub repos must have:
- a GitHub account (ideally with a complete profile)
- 2-factor authentication enabled on their GitHub account

If the project has a GitHub repository/repositories created already:
- the Admin/Owner of the repository can invite new users as `Collaborators`, they do not need to join any organization. To do that, repo admin could refer to the  "Add Collaborator" function in the repo "Settings" area in the Github web interface

If new repository needed:
- the product owner need to make an `GitHub Repo Request` according to the instructions below, and recommend *one* team member to be the repo creator/owner
- the product owner also need to make an `Access Request` for the _repo owner_ github user
- the rest of the project team can then be invited by the repo owner as collaborators

If new *private* repository is needed temporarily (it's for closed source projects only. These projects _will go Open Source once completed_):
- the product owner is required to communicate with the Enterprise DevOps branch leadership and explain the necessity of a private repo
- after obtaining an approval from the communication, please follow the `GitHub Repo Request` instructions below
- for new users, please follow the `Access Request` instructions below

**Note** that the platform services team will be removing GitHub Org access for users that are not active for six months. Once the access has been removed, a new `Access Request` has to be made by the product owner



## GitHub Repo Request

For a new BCGOV GitHub repo or a private repo (with approval), the team product owner or technical leader should make a request at [DevOps Request Repo](https://github.com/bcgov/devops-request-records).

The request should include:

1. Project name
1. Project description
1. Approver's name (and @ the person's GitHub account)
1. GitHub ID of the repo Owner (following the `Access Request`)
1. Rational for develop as close sourced (for private repo only)
1. Date to move to public (for private repo only)

A sample "good" request is provided below and should be used as a template for submitting requests:

```markdown
GitHub Repository Request:
- Project: Govvapp-private
- Project description: the temporary repo for the Govvapp project, for bla
- Approver: @Todd.Wilson
- Repo Owner GitHub ID: govviemcgovster
```


## Access Request

If the pre-requisites are complete, the product owner should make a request at [DevOps Request Repo](https://github.com/bcgov/devops-request-records).
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


## Access Removal Request

When an individual is no longer working on the project, it is the responsibility of the associated product owner or a GitHub repo admin to remove the user from the repo and request for that at [DevOps Request Repo](https://github.com/bcgov/devops-request-records).

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
