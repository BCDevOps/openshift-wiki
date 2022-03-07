---
description: Security considerations for DevOps teams and Ministry information security teams
resourceType: Documentation
title: BC Government OpenShift DevOps Security Considerations
tags:
  - security
  - privacy
  - secrets
  - tls
  - ssl
  - pipeline
  - templates
  - container scanning
  - STRA
  - network policies
  - vault
---

# BC Government OpenShift DevOps Security Considerations

## DevOps Security Tools and Capabilities

### Summary

There are a number of tools available to developers working on the OpenShift platform to help ensure the confidentiality, integrity and availability of data within those systems.  This is an overview of those tools, with links to specifics on each of the resources.

- [OpenShift Platforrm Security](#openshift-platform-security)
- [Privacy](#privacy)
- [Access Management](#access-management)
- [Kubernetes Network Policies](#kubernetes-network-policies)
- [Pipeline Templates (includes static and dynamic analysis)](#pipeline-templates)
- [Container image scanning (Aqua, Xray)](#container-image-scanning)
- [Container runtime security](#container-runtime-security)
- [TLS Certificates](#tls-certificates)
- [Secrets Management](#secrets-management)
- [GitOps/Cluster Configuration Management](#gitops-cluster-configuration-management)
- [API Management](#api-management)
- [Application Resource Tuning Advisor and App Assessment Tool](#application-resource-tuning)
- [Logging/Monitoring (EKS, Kibana, Graphana, Sysdig Monitor, SIEM)](#logging-monitoring)
- [Backups](#backups)
- [Change Management](#change-management)
- [GitHub](#github)
- [Other considerations](#other-considerations)

## Tools & Capabilities
### <a name="openshift-platform-security"></a>OpenShift Platform Security

Service definition - Silver/Gold - https://developer.gov.bc.ca/Getting-Started-on-the-DevOps-Platform/BC-Gov-PaaS-OpenShift-Platform-Service-Definition

Our **_Silver Service_** is our standard DevOps platform offering, with on-cluster resiliencey based on application design.

Our **_Gold Service_** is our enhanced DevOps platform offering, with replication to a secondary cluster for disaster fail-over purposes.  

Please take note of the **_Shared Responsibility Model_**.  While the Platform Services Team manages infrastructure, OpenShift Container Platform and the Platform critical services as part of the Private Cloud PaaS, the Product Team bears the responsibility for the functionality and operations of their application(s) hosted on the Platform.  

Specific details on OpenShift specific secuirty controls can be found here:

https://www.redhat.com/rhdc/managed-files/cl-openshift-security-guide-ebook-us287757-202103.pdf

- these are highlighted as part of the OpenShift STRA.

**_Penetration Tests_**
The platform services team outsources for a penetration test annually to ensure the services we provide are configured to protect confidentiality, integrity and availability.  Peneteration tests are procured through the pre-qualified list of vendors (https://www2.gov.bc.ca/gov/content/governments/services-for-government/bc-bid-resources/goods-and-services-catalogue/im-it-security-services).

------
### <a name="privacy"></a>Privacy
A Privacy Impact Assessment has been completed for the OpenShift Container Platform service.

Personal Information upto and including Protected B Information Security Classification may be stored on OpenShift.   
- https://www2.gov.bc.ca/gov/content/governments/services-for-government/information-management-technology/information-security/information-security-classification

------
### <a name="critical-systems-standard"></a>Critical Systems Standard

We are very close to obtaining critical systems standard compliance.  
Documentation is in final stages of review for submission.

------
### <a name="platform-security-assessments"></a>Platform Tools Security Assessments

Many of the platform tools have ***completed*** security assessments.  These include:
- OpenShift v4.x and GitHub (Public)
- KeyCloak
- Aqua
- Artifactory
- Sysdig Monitor
- Just Ask!
- Rocket Chat
- Vault

The following security assessments are ***underway***:
- Mautic
- OCP Application Resource Tuning Advisor (in sign-off)
- GitHub Enterprise (Cloud security schedule review underway)
- 1Password (SoAR complete, Cloud security schedule review underway)
- Platform Registry

The following security assessments are ***planned***:
- Stack Overflow
- Cert Manager for OpenShift
- GitGuardian
- KeyCloak Realm Registry
- OCP App Assessment Tool
- Platform Security Dashboard

For specifics, please contact the platform security architect, nick.corcoran@gov.bc.ca.

------
### <a name="platform-registry"></a>Platform Project Registry

Here, we maintain a listing of all projects with deployments on each OpenShift cluster. 
![platformregistryexample](https://user-images.githubusercontent.com/53879638/144318853-104588bc-0db8-4cd7-8616-13c1c137f199.JPG)

https://registry.developer.gov.bc.ca/public-landing?redirect=/dashboard

While access to the registry is currently limited to the OpenShift Platform Services team (full view) and Product Owners/Technical Leads (limited view), we are working on creating roles for Ministry security staff to consume as well.  Until then, you can contact nick.corcoran@gov.bc.ca for details.

------
### <a name="communications"></a>Communications

Community sharing, alerts and discussions take place on Rocket Chat, which we host as an app on OpenShift.  Authentication via IDIR or GitHub (in BCGov org or invited by an existing member).
- https://developer.gov.bc.ca/Steps-to-join-Rocket.Chat
- https://reggie.developer.gov.bc.ca/rocketChat
- https://developer.gov.bc.ca/Leveraging-Rocket.Chat

#### Mautic

Mautic has been implemented to allow for subscription based communications for the DevOps community. 
- https://github.com/bcgov/Mautic-Openshift
- https://github.com/bcgov/Mautic-Subscription-App
- https://subscribe.developer.gov.bc.ca/

------
### <a name="access-management"></a>Access Management

Access to OpenShift is brokered through our OpenShift SSO Service (currently leveraging KeyCloak).

- https://developer.gov.bc.ca/Request-SSO-Client-Creation
- https://developer.gov.bc.ca/How-to-Request-New-User-Access-to-OpenShift

GitHub has been the primary authentication to date on OpenShift, however we are in the process of introducing IDIR (via Azure AD).  Both of these options require an account with 2FA/MFA enabled.  
GitHub - All clusters  
IDIR - KLAB, Silver (Gold, GoldDR to come in early 2022)

- GitHub 2FA - https://docs.github.com/en/authentication/securing-your-account-with-two-factor-authentication-2fa/configuring-two-factor-authentication
- IDIR MFA - https://www2.gov.bc.ca/gov/content/governments/services-for-government/information-management-technology/information-security-mfa

Cluster roles are managed either in private GitHub repositories (in the bcgov-c org) or through direct role bindings within a namespace.
We are investigating third party tools to help improve the user management experience.

Platform Services Roles and Responsibilities can be found here:
- https://docs.developer.gov.bc.ca/s/bk07fg8i4dscrcq7posg/devops-platform-services/d/bslf7h8755crgmr8i9rg/platform-services-roles-and-responsibilities

The Platform Services team maintains an Access Control Policy for all platform tools.  
- https://docs.developer.gov.bc.ca/s/bk07fg8i4dscrcq7posg/devops-platform-services/d/c1ma8i4adqrdud0ff650/access-control-policy-openshift-and-platform-tools-public

------
### <a name="kubernetes-network-policies"></a>Kubernetes Network Policies (KNPs)

Network policies help the platform and project teams to better control communications between components.  While KNPs only apply as INGRESS rules (not egress), they help to improve our overall security posture.  KNPs only apply to on-cluster communications (i.e. between pods in a namespace, or between namespaces).  For off-cluster communications, hosting is investigating a VMWare tool called NSX-T.

Find our more about using KNPs to control network security for an application hosted on the Private Cloud Openshift Platform in [this document](https://github.com/bcgov/how-to-workshops/blob/65ac9469db92eac86d8e396d9366515cddc15a4b/labs/netpol-quickstart/README.md). 

More details on KNPs can be found here: https://kubernetes.io/docs/concepts/services-networking/network-policies/

------
### <a name="pipeline-templates"></a>Pipeline Templates (includes static and dynamic analysis)

In order to reduce effort in implementing secure tools into a build pipeline, we have developed pipeline templates that include components for build, aas well as static and dynamic vulnerability scanning.  
- https://github.com/bcgov/Security-pipeline-templates/

Here is a representation of what an application build pipeline should look like:
![PlatformSec drawio](https://user-images.githubusercontent.com/53879638/144318963-fdb5b877-88b8-451d-accf-2d24918c0d62.png)

The pipeline templates above make it easier to include the tools described below:
  - https://developer.gov.bc.ca/SonarQube-on-OpenShift
  - https://developer.gov.bc.ca/OWASP-ZAP-Security-Vulnerability-Scanning

**What do each of these types of scanning tools do for me?**
Static Anaysis (i.e. SonarX, CodeQL) 
     - identifies coding issues that could lead to compromise, back doors, secrets, etc
Dynamic Anaysis (i.e. OWASP ZAP) 
     - testing against a live version of app for injection, Cross-site scripting (XSS), and other common web attacks (https://owasp.org/www-project-top-ten/)
Image Analysis 
     - ensures image components are up-to-date and not vulnerable to known exploits (https://cve.mitre.org/, https://nvd.nist.gov/).

------
### <a name="container-image-scanning"></a>Container image scanning (Aqua, Xray)

Image scanning/analysis comes in 2 forms - 1 active (Aqua), 1 passive (XRay).

**Aqua:**

This tool allows us to scan image registries and running containers for image vulnerabilities.  It also allows us to create policies at build, deploy, and runtime.
- https://developer.gov.bc.ca/BC-Government-Aqua-Cloud-Service-Definition

We are also workign with teams on integrating Aqua container image scanning into pipelines.
Alternatively, Aqua image scans may be requrested by contacting Nick Corcoran via email (nick.corcoran@gov.bc.ca) or on Rocket Chat.  Nick can walk through results with the team if desired.

**XRay:**

An addon capability to Artifactory, XRay scans images and other artifacts for component vulnerabilities.  Anyone with access to an image or artifact within Artifactory can see the XRay tab as part of the image/artifact details, and see what vulnerable components lie within, and what version will correct that deficiency.
- https://artifacts.developer.gov.bc.ca/ui/login/

------
### <a name="container-runtime-security"></a>Container runtime security

We currently have runtime policies in place for the following using Aqua:
![aqua_enforce](https://user-images.githubusercontent.com/53879638/144319023-46c9d915-405f-421f-8ec0-13280b76586b.JPG)

Additionally, OpenShift uses CoreOS and the CRI-O container engine.
- https://docs.openshift.com/container-platform/4.7/architecture/architecture-rhcos.html

------
### <a name="tls-certificates"></a>TLS Certificates

OpenShift uses a wildcard certificate for the majority of cluster communications security.  This should be sufficient for dev and test workloads, but for production workloads, each team is required to obtain a dedicated TLS certificate from the Access & Directory Management Services (ADMS) team.  
***Note:*** by default, the wildcard will be used to protect project workloads.  The Platform Services team worked through the wildcard issuance requriements for use on the OpenShift clusters.  Obtaining a dedicated TLS cert is currently a manual process.  
Details on these processes can be found here: https://ssbc-client.gov.bc.ca/services/SSLCert/documents.htm

**Pre-requisites:**
Generate a .csr for each site:
- https://github.com/BCDevOps/openshift-wiki/blob/master/docs/SSLCerts/GenerateCertificateSigningRequest.md

**Ordering Process:**
-  Business area creates/submits order
-  Ministry Service Desk reviews order, creates iStore Number, sends to EA for Approval
-  EA Approves
-  Order is sent to DXC for fulfillment
-  Once order is fulfilled/shipped by DXC, Ministry Service Desk sends 'Completed Order' notification to business area

![TLS_Order](https://user-images.githubusercontent.com/53879638/144319065-af4ae9f9-3d61-41b3-977b-36a600e51b0a.png)

------
### <a name="secrets-management"></a>Secrets Management
**OpenShift Secrets:**

This 'secrets' store should actually only be used for configurations.  Values are encoded as base64 and NOT encrypted.  However, these 'secrets' can only be accessed with a role to a given namespace with permission to access them.  Additionally, the physical etcd volume, where OpenShift secrets are stored, is encrypted.

**Vault:**

The preferred secrets management tool, Vault was recently launched for team use on OpenShift.
- https://developer.gov.bc.ca/BC-Government-Vault-Secrets-Management

------
### <a name="gitops-cluster-configuration-management"></a>GitOps/Cluster Configuration Management

Argo CD provides a GitOps capability for sync'ing a Git repository with an OpenShift configuration (platform or application).
- https://developer.gov.bc.ca/Argo-CD-Usage-on-the-DevExchange-OpenShift-Platform

------
### <a name="api-management"></a>Application Programmable Interface (API) Management

The Data BC team hosts an API Gateway for use by other government clients.  Details can be found here:
- https://developer.gov.bc.ca/API-Gateway-(powered-by-Kong-CE)
- https://developer.gov.bc.ca/BC-Government-API-Guidelines
- https://developer.gov.bc.ca/BC-Government-OpenAPI-Specifications

------
### <a name="application-resource-tuning"></a>Application Resource Tuning Advisor and App Assessment Tool
**Resource Tuning Advisor**
- https://github.com/BCDevOps/resource-tuning-advisor-app 

**App Assessment Tool**
- https://github.com/bcgov/AppAssessment

------
### <a name="logging-monitoring"></a>Logging/Monitoring (EKS, Kibana, Graphana, Sysdig Monitor, SIEM, Uptime, Status)

The Platform Services team provides a number of tools to help ensure our platform and applications are behaving as expected, while allowing us to investigate anomolies.

**OpenShift UI:**
Within the OpenShift interface, project teams can view logs associated with a given pod through the Logs tab.  
![logging_ui](https://user-images.githubusercontent.com/53879638/144319141-d387a02c-6b9e-4330-ab5b-6e2711e39565.JPG)

**Kibana:**

This tool provides a more wholistic view of logs for an application or at the platform level, as well as providing visualization and alerting capability.
- https://kibana-openshift-logging.apps.silver.devops.gov.bc.ca/

**Sysdig Monitor:**

This tool allows our platform admins and platfrom teams to build monitoring dashboards.
- https://developer.gov.bc.ca/BC-Government-Sysdig-Monitoring-Service-Definition
- https://developer.gov.bc.ca/OpenShift-User-Guide-to-Creating-and-Using-a-Sysdig-Team-for-Monitoring
- https://app.sysdigcloud.com/#/login

**Security Information and Event Monitoring (SIEM):**

All cluster logs (system, audit, container) are regularly sent to the Security Operations SIEM environment.  
Retention is set as follows:
- System, Container logs - 2 months
- Audit logs - 13 months

We are currently working on Azure AD integration (via KeyCloak) and user role mapping based on OpenShift namespace access.

**Uptime Robot** (currently being replaced with Uptime.com for improved SLAs).

This tools help us to observe platform service availability:
- https://developer.gov.bc.ca/Openshift-4-Platform-Services-Reliability-Dashboard-with-Uptime-Robot
- https://stats.uptimerobot.com/w28pPSLlZE

------
### <a name="backups"></a>Backups
**OpenShift:**
- https://developer.gov.bc.ca/OCP4-Backup-and-Restore
- https://developer.gov.bc.ca/Backup-Container

**GitHub:**
- https://github.com/bcgov-c/platform-services-docs/blob/main/github-backups.md

------
### <a name="change-management"></a>Change Management

Planning for platform and service changes is documented on the Platform Services ZenHub board.  
- https://app.zenhub.com/workspaces/platform-experience-5bb7c5ab4b5806bc2beb9d15/board?repos=220104031  
Any service change will be communicated via the #devops-alerts RocketChat channel.

Strategic level changes are communicated to the DevOps community at regular Community Meetups, as well as to executive groups across government.

------
### <a name="github"></a>GitHub

GitHub is the primary git repository for platform application code.  There are some exceptions that use privately hosted GitLab or other source code repositories.  

Here is a summary of the GitHub organizations we own and their purposes:
- bcgov - main developer git repository for platform application code and/or public sharing.
- bcgov-c - main private git repository used for cluster configuration management and non-public projects.
- bcdevops - alternate git repository for platform application code.  Membership required for access to OpenShift.
- bcgov-platform-services - git repository for platform services team

These resources are available on the developer hub:
- https://developer.gov.bc.ca/Introduction-To-Github-and-Gov
- https://developer.gov.bc.ca/Github-Practices-in-Gov
- https://developer.gov.bc.ca/User-access-into-Github-or-Openshift
- https://developer.gov.bc.ca/Git-Workflows-For-Your-Team-or-Project

**GitHub Apps**

Teams may request GitHub apps to be associated with their own or all projects in a GitHub organization.  These requests are reviewed by a platform administrator for validity and scope.  These are also shared with Ministry security staff to ensure they are acceptable for connection.

**GitHub Enterprise**

We are currently piloting the use of GitHub Enterprise.  
- https://developer.gov.bc.ca/Use-of-GitHub-Enterprise-User-Licenses-in-BC-Gov

------
### <a name="other-considerations"></a><u>Other considerations</u>
**Payment Card Industry Compliance (PCI-DSS)**

Our OpenShift implementation is **NOT** PCI-DSS compliant.  If you wish to host an application on OpenShift that needs to perform financial transactions, please refer to the following:  https://developer.gov.bc.ca/Payment-Card-Processing-for-OpenShift-Applications
Some teams have decided to host PCI-scoped applications on-prem (non-OpenShift) or on a cloud based service (AWS, Azure, etc) to avoid linkages with government systems not under their control.

**Training/Support**

The platform services team provides training to onboarding teams, as well as support for issues experienced.  Ministry staff that work with devops teams are also encouraged to attend training.

***Training:***
- https://developer.gov.bc.ca/ExchangeLab-Course:-Openshift-101
- https://developer.gov.bc.ca/ExchangeLab-Course:-Openshift-201
- https://github.com/bcdevops/devops-platform-workshops

***Support:***
- https://developer.gov.bc.ca/DevOps-Requests
- https://developer.gov.bc.ca/Getting-human-support-for-issues-not-covered-by-devops-requests
- Various Rocket Chat channels

**App security self assessment:**
- https://developer.gov.bc.ca/Application-Security-Self-Assessment

**Best practices for building apps on OpenShift:**
- https://developer.gov.bc.ca/Best-Practices-for-Building-Apps-on-Openshift

**Contact**
For all other matters concerning security on the OpenShift Container Platform, please contact nick.corcoran@gov.bc.ca.
