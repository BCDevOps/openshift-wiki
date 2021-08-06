---
description: How to request a new Client in the Pathfinder SSO service.
title: Request SSO Client Creation
tags:
  - keycloak
  - client
  - request
---
# Request Pathfinder SSO Client Creation

## Available Standard Realms

_Note: All standard realms include access to a GitHub identity provider in the DEV and TEST instances._

| Standard Realm       | Available Identity Providers                                  |
|----------------------|---------------------------------------------------------------|
| onestopauth          | IDIR                                                          |
| onestopauth-basic    | IDIR, BCeID - Supports Basic Only                             |
| onestopauth-business | IDIR, BCeID - Supports Business Only                          |
| onestopauth-both     | IDIR, BCeID - Supports Basic and Business at time of sign on  |


## Access to Create Client Request

- Read the [Overview for Customers](https://github.com/BCDevOps/devops-requests) and [Onboarding to the Pathfinder SSO Service](https://github.com/bcgov/ocp-sso/wiki/SSO-Onboarding) on the OCP-SSO wiki.
- If you **DO NOT** need authentication to BCeID, visit the [Pathfinder SSO Client Request Web App](https://bcgov.github.io/sso-requests/). If you are looking for integration for IDIR login the process is completely self-serve and takes only minutes.
- If you **DO** need authentication to BCeID, visit [DevOps Request](https://github.com/BCDevOps/devops-requests) and create a new issue of type "Request for an Pathfinder SSO Client in a standard realm"


