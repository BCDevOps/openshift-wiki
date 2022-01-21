# Pre-Built Images

## Overview
The Platform Services Team maintains a number of images that are of general interest.  If you do not need to maintain your own customized versions, please consider using these pre-built images.

Each of the images is available from Artifactory.  You may use the `artifactory-creds` Secret in your namespaces to pull these images.  See the [Credentials section](#credentials) for details.

## Contents
- [Credentials](#credentials)
- [Image URL](#image-url)
- [Managed Images](#managed-images)
    - [app-assessment](#app-assessment)
    - [backup-container](#backup-container)
    - [caddy](#caddy)
    - [codeql](#codeql)
    - [mongodb-36-ha](#mongodb-36-ha)
    - [patroni-postgres](#patroni-postgres)


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

## Image URL
Each image is available in the `bcgov-docker-local` repository in Artifactory.  Use the following URL to reference them in your deployment.

`artifacts.developer.gov.bc.ca/bcgov-docker-local/<image_name>:<image_tag>`

For example:

`artifacts.developer.gov.bc.ca/bcgov-docker-local/mongodb-36-ha:1`

## Managed Images

### app-assessment
[latest image](https://artifacts.developer.gov.bc.ca/artifactory/plat-common-images/app-assessment/latest)

https://github.com/bcgov/AppAssessment

The App Assessment application can be used to identify configuration issues in your namespaces.  Use it to improve resource consumption and health checks.

[README](https://github.com/bcgov/AppAssessment/README.md)


### backup-container
[latest image](https://artifacts.developer.gov.bc.ca/artifactory/plat-common-images/backup-container/latest)

https://github.com/BCDevOps/backup-container

original doc: https://developer.gov.bc.ca/Backup-Container

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



