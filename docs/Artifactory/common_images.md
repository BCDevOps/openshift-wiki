# Pre-Built Images

## Overview
The Platform Services Team maintains a number of images that are of general interest.  If you do not need to maintain your own customized versions of these images, please consider using the images that are made available here.

Each of the images is available from Artifactory.  You may use the `artifactory-creds` Secret in your namespaces to pull these images.  See below for details.

- [Credentials](#credentials)
- [Managed Images](#managed-images)
    - [app-assessment](#app-assessment)
    - [backup-container](#backup-container)
    - [backup-container-postgres](#backup-container-postgres)
    - [backup-container-mongo](#backup-container-mongo)
    - [backup-container-mariadb](#backup-container-mariadb)
    - [backup-container-mssql](#backup-container-mssql)
    - [caddy](#caddy)
    - [codeql](#codeql)
    - [mongodb-36-ha](#mongodb-36-ha)
    - [patroni-postgres](#patroni-postgres)
- [Legacy Builds](#legacy-builds)


## Credentials
All project sets on the platform are provided with a Secret called `artifactory-creds` that can be used to pull images from the local Artifactory service.  Where you have a Deployment or StatefulSet that uses one of these images, include that Secret in your configuration.

```
spec:
  template:
    spec:
      imagePullSecrets:
        - name: artifactory-creds
      containers:
```


## Managed Images

### app-assessment
[latest image](https://artifacts.developer.gov.bc.ca/artifactory/plat-common-images/app-assessment/latest)

https://github.com/bcgov/AppAssessment

The App Assessment application can be used to identify configuration issues in your namespaces.  Use it to improve resource consumption and health checks.
[README](https://github.com/bcgov/AppAssessment/README.md)


### backup-container
The backup-container repository contains Dockerfiles for four different images, based on database type.  Use the image that matches your own database.

Original doc: https://developer.gov.bc.ca/Backup-Container

### backup-container-postgres
[latest image](https://artifacts.developer.gov.bc.ca/artifactory/plat-common-images/backup-container-postgres/latest)

https://github.com/BCDevOps/backup-container/docker/Dockerfile

### backup-container-mongo
[latest image](https://artifacts.developer.gov.bc.ca/artifactory/plat-common-images/backup-container-mongo/latest)

https://github.com/BCDevOps/backup-container/docker/Dockerfile

### backup-container-mariadb
[latest image](https://artifacts.developer.gov.bc.ca/artifactory/plat-common-images/backup-container-mariadb/latest)

https://github.com/BCDevOps/backup-container/docker/Dockerfile

### backup-container-mssql
[latest image](https://artifacts.developer.gov.bc.ca/artifactory/plat-common-images/backup-container-mssql/latest)

https://github.com/BCDevOps/backup-container/docker/Dockerfile

### caddy
[latest image](https://artifacts.developer.gov.bc.ca/artifactory/plat-common-images/caddy-s2i-builder/latest)

https://github.com/bcgov/s2i-caddy-nodejs.git

### codeql
[latest image](https://artifacts.developer.gov.bc.ca/artifactory/plat-common-images/codeql/latest)

Referenced in the pipeline templates

https://github.com/bcgov/pipeline-templates.git


### mongodb-36-ha
[latest image](https://artifacts.developer.gov.bc.ca/artifactory/plat-common-images/mongodb-36-ha/1)

https://github.com/bcgov/mongodb-replicaset-container.git


### patroni-postgres
[latest image](https://artifacts.developer.gov.bc.ca/artifactory/plat-common-images/patroni-postgres/12.4-latest)

https://github.com/bcgov/patroni-postgres-container.git


## Legacy Builds
Previously, some of these builds were made available in the local image registry of each OpenShift cluster, in the `bcgov` namespace.  Those builds will remain there, but future enhancements will be made only to the images stored in Artifactory.  The legacy builds will continue to be rebuilt monthly, as before, to allow them to pick up security or bug fixes in the base image.


