---
description: The Artifact Repository Service Definition outlines roles and responsibilities for operating the service.
resourceType: Documentation
title: BC Government Artifact Repository Service Definition
tags:
  - artifactory
---

# BC Government Artifact Repository Service Definition

## Service Description

### Summary

### Features & Functions

Users of this service gain access to the following:

#### Remote (Caching) Repos

Artifactory provides cached access to a number of publicly available and secure repositories held by other organizations.
The benefits of using our caching repo include:
* Faster builds (since the package is cached on the cluster instead of having to be pulled over the internet every time)
* No pull limits (avoiding problems associated with pull limits implemented by external organizations including DockerHub)
* Security scans on cached images (coming soon)

Artifactory currently provides access to the following repositories:

```
ARTIFACTORYKEY              SOURCEURL
--------------              ---------
atlassian-maven-remote      https://maven.atlassian.com/repository/public/
boundlessgeo-maven-remote   http://repo.boundlessgeo.com/main/
docker-remote               https://registry-1.docker.io/
geosolutions-maven-remote   http://maven.geo-solutions.it/
jasperreports-maven-remote  http://jasperreports.sourceforge.net/maven2
jaspersoft3p-maven-remote   https://jaspersoft.artifactoryonline.com/jaspersoft/third-party-ce-artifacts/
jaspersoftjr-maven-remote   http://jaspersoft.artifactoryonline.com/jaspersoft/jr-ce-releases/
jaspersoftjrs-maven-remote  http://jaspersoft.artifactoryonline.com/jaspersoft/jrs-ce-releases/
jcenter-maven-remote        http://jcenter.bintray.com
jenkins-remote              https://updates.jenkins.io/download/
jenkinspub-maven-remote     http://repo.jenkins-ci.org/public
jenkinsrel-maven-remote     http://repo.jenkins-ci.org/releases
jfrog-maven-remote          https://jfrog.bintray.com/artifactory/
maven-remote                https://repo1.maven.org/maven2
npm-remote                  https://registry.npmjs.org
nuget-remote                https://nuget.org/
oracle-maven-remote         https://maven.oracle.com
osgeo-maven-remote          http://download.osgeo.org/webdav/geotools/
primefaces-maven-remote     http://repository.primefaces.org
pypi-remote                 https://files.pythonhosted.org/
redhat-docker-remote        https://registry.redhat.io/
vivid-maven-remote          http://mvn.vividsolutions.com/artifactory/repo
windward-maven-remote       http://maven-repository.windward.net/artifactory/libs-release
```

#### Local (Private) Repos

**This feature is not yet fully implemented**

#### Community

### Eligibility & Prerequisites

This service is offered to BC Government development teams building cloud native applications on the Openshift Platform.

### How to Request  

Access to the remote (caching) repositories is currently available by default to anyone on the Silver or Gold Clusters. 
When a project set is provisioned, an Artifactory service account is created at the same time, with a secret in the tools namespace available to use.

**In the future:**

Users with admin access to a namespace will be able to create their own additional service accounts as they wish. 
These service accounts should be created in the tools namespace.

Users with admin or edit access can request an Artifactory Private repository for their team's use through the `devops-requests` repository on Github.

### Availability

Artifactory is deployed in a high-availability configuration within the highly-available BC Government OpenShift cluster. 
This service is available 24/7 with best effort to restart failed systems. 
More detailed SLAs are being developed and will be added in the near future.

Private repository requests will be reviewed and handled during normal business hours.

## How do I get help? (help and self service)

### Getting Help

The best source of help is the vibrant community of development teams using Artifactory for their projects. 
You can find this highly talented and knowledgeable group in the `#devops-artifactory` channel on [RocketChat](https://chat.pathfinder.gov.bc.ca/channel/devops-artifactory).

For help beyond this contact one of the Artifactory administrators via the `#devops-sos` channel on [RocketChat](https://chat.pathfinder.gov.bc.ca/channel/devops-sos).

## What Does It Cost?

For you my friend, there is no charge for this service.

## Support Roles, Processes, Communications (platform ops)

The team supporting this service administers the Artifactory application, its supporting database, as well as the S3 storage system that contains the packages uploaded to Artifactory. 

[RocketChat](https://chat.pathfinder.gov.bc.ca) is the primary mode of communication. Specifically the `#devops-artifactory` channel should be used for engage the community for best practices, configuration and troubleshooting questions.

For cluster wide service notifications that may impact Artifactory, monitor the `#devops-alerts` channels in [RocketChat](https://chat.pathfinder.gov.bc.ca/channel/devops-alerts).

For teams without RocketChat access, escalation, or to talk to a person IRL contact [Olena Mitovska](mailto:olena.mitovska@gov.bc.ca), Product Owner for Platform Services, BCDevExchange, Office of the Chief Information Officer.

## Service Delivery

### Repository Request Workflow

- Start a request here: https://github.com/BCDevOps/devops-requests
- Have an onboarding meeting with the Artifact Ops team to go through the intended use of the Artifactory service and common practices.
- The Ops team will create an `ArtifactoryRepository` object in the appropriate `tools` namespace, which the Artifactory Operator will then action.
- Once the operator has completed its action, there will be a new secret in the same `tools` namespace which contains the repository name as well as the username and password of a new service account which has administrative access over the repository.
- The administrative service account should be used to give work-related access to other service accounts - while it is possible to use the administrative user to push and pull from the new repository, it is not recommended that it be used in this way.

### Service Account Workflow

- An `ArtifactoryServiceAccount` object will be created in the appropriate `tools` namespace, which the Artifactory Operator will then action.
   - One such `ArtifactoryServiceAccount` object is created automatically as part of namespace provisioning, with the name `default`.
   - In the near future, those with edit and admin access on the `tools` namespace will also be able to create additional `ArtifactoryServiceAccount` objects on their own.
- Once the operator has completed its action, there will be a new secret in the `tools` namespace which contains the service account name and password.
   - In the near future, the creator of the service account will be given the option to request the creation of a pull secret in addition to the regular secret.
- (Feature coming soon) If either of the secrets is ever deleted manually, the operator will notice this and act to change the password of the service account. Then it will recreate one or both secrets with the new password. This is an easy method for teams to change their service account passwords.

### Change Management

Any service change will be communicated via the `#devops-artifactory` RocketChat channel.

### Service Improvements

Artifactory service improvements include software upgrades for both Artifactory and its operator, feature integrations for the operator, bug fixes, etc. 
Many such operations will not result in any expected disruption for users. In these cases, the team will provide notification of upcoming changes in `#devops-artifactory`, but it may be with limited notice.
Other such operations will require turning Artifactory to "read-only" mode, which means that pulling from Artifactory will be possible, but pushes will not be.
If such a disruption is expected, advance notice of at least a day will be given in the `#devops-artifactory` channel for the planned read-only window.

### Service Level

TBD

### Security Reviews

Artifactory is covered by the existing Openshift PIA.

A STRA is currently underway.


```

---

# License

[![Creative Commons License](https://i.creativecommons.org/l/by/4.0/88x31.png)](http://creativecommons.org/licenses/by/4.0/)

```
Copyright 2019 Province of British Columbia

This work is licensed under the Creative Commons Attribution 4.0 International License.
To view a copy of this license, visit http://creativecommons.org/licenses/by/4.0/.
```

# Template

This document is based heavily on [Service Definition Questions and Checklist](https://its.ucsc.edu/itsm/checklist.html) from UC Santa Cruz.
