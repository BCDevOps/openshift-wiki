---
description: IDIR Login (via Azure AD) for OpenShift Console
resourceType: Documentation
title: IDIR Login (via Azure AD) for OpenShift Console
tags:
  - security
  - privacy
  - STRA
  - access
  - idir
  - login
---

# IDIR Login (via Azure AD) for OpenShift Console

We are happy to announce that IDIR authentication is now enabled in the Silver cluster of the Openshift Platform thus offering teams a choice to log into the Silver Cluster Openshift Console with a GitHub ID or IDIR.

**Note:  MFA is required to be enabled on an IDIR account to use this access mechanism as it links to Azure Active Directory. You can find instructions fow how to enable MFA for your IDIR account here.**

**Note: Logging with IDIR into the Openshift Console is required BEFORE any role bindings can be associated with the IDIR account.**

This is a screenshot of the new Login options you will see in the Silver Cluster Openshift Console:
![authOptions](https://user-images.githubusercontent.com/53879638/146621070-6d473a3d-289c-400e-86a7-947732441fac.png)



## What does this mean for you?
1. GitHub accounts are NOT going away.  We foresee GitHub accounts being used as the default authentication mechanism for our developers.
2. We intend to update the Platform Projecy Registry (https://registry.developer.gov.bc.ca/) to use IDIR user accounts and BC Gov email identifiers for Product Owners and Technical Leads to achieve the following benefits: 
- This will help ensure namespace admin level controls are tied to an account that we have more assurance and control over i.e. IDIR.
- We do not yet have a target date for this to be completed but will ensure clear communications as we move forward. To prepare for this change, please ensure all the contractors that are listed as Tech Leads for the projects on the Platform have active IDIR accounts.
3. Some teams may choose to have all team members migrated to IDIR account use for OpenShift platform access.  This is not required. 
4. We intend for teams to migrate their role bindings from their GitHub accounts to IDIR on their own, and deprovision the GitHub accounts if necessary.
5. We are investigating IDIR security groups integration, but that is not in place yet.  This requires a synchronization between our data centre active directory and the Azure Active Directory that is not fully in place yet.
6. We do not have an intention to leverage SSO integration for IDIR onto GitHub at this time (i.e., you will still use GitHub accounts to access GitHub content).


**Note: There will be NO automated migration for the namespace access role bingins created for the GitHub ID to the IDIR accounts performed by the Platform Services Team. Any such migrations would have to be done by product teams themselves.**


If you have any questions or concerns about this change, please post your question in #devops-security channel (https://chat.developer.gov.bc.ca/channel/devops-security) in Rocket and tag Nick Corcoran, our Platform Security Architect.


https://developer.gov.bc.ca/BC-Government-OpenShift-DevOps-Security-Considerations
