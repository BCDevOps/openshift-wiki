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
- the Admin/Owner of the repository can invite new users, they do not need to join any organization

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
