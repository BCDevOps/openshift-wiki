---
description: How to request a new Client in the Pathfinder SSO service.
title: Request SSO Client Creation
tags:
  - keycloak
  - client
  - request
---

***This is being retained for historical purposes only. SSO-related content in this repository has been superseded by the [SSO Pathfinder Knowledge Base](https://github.com/bcgov/sso-keycloak/wiki).***

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
- Use the [Common hosted Single Sign on (CSS) App](https://bcgov.github.io/sso-requests/). If you are looking for integration for IDIR login the process is completely self-serve and takes only minutes. You will need an IDIR to log in and you should be a product owner, product admin, or team lead for a project. Once the automated provisioning is complete, your client details will be available securely through the web app (*)
- (*) Note for BCeID Requests The Pathfinder SSO team will provision your DEV and TEST clients right away. You will be provided the client name and secret for each environment via a secure channel. The PROD client will be provisioned upon approval from the IDIM team


