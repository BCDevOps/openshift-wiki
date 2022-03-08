# Pre-Built Images

## Overview
The Platform Services Team maintains a number of images that are of general interest.  

This document describes those images and how to use them.

If you do not need to maintain your own customized versions of these images, please consider using the images that are made available here.  Advantages of the managed builds include:
* Teams do not have to maintain their own builds
* The cluster as a whole benefits from lower resource consumption
* Builds tagged with "latest" are regularly rebuilt to pick up the latest security enhancements
* Images are available to all clusters by way of Artifactory

Each of the images is available from Artifactory.  You may use the `artifactory-creds` Secret in your namespaces to pull these images.  See below for details.

- [How to Use the Managed Builds](#how-to-use-the-builds)
- [Managed Images](#managed-images)
    - [app-assessment](#app-assessment)
    - [backup-container-mariadb](#backup-container-mariadb)
    - [backup-container-mongo](#backup-container-mongo)
    - [backup-container-mssql](#backup-container-mssql)
    - [backup-container-postgres](#backup-container-postgres)
    - [caddy-s2i](#caddy-s2i)
    - [mongodb-36-ha](#mongodb-36-ha)
    - [patroni-postgres](#patroni-postgres)
- [Legacy Builds](#legacy-builds)


## How to Use the Managed Builds<a name="how-to-use-the-builds"></a>
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

### App Assessment<a name="app-assessment"></a>
The App Assessment application can be used to identify configuration issues in your namespaces.  Use it to improve resource consumption and health checks.

Images: https://artifacts.developer.gov.bc.ca/ui/repos/tree/General/bcgov-docker-local/app-assessment

More info: https://github.com/bcgov/AppAssessment

### Backup Container - MariaDB<a name="backup-container-mariadb"></a>
The community's database backup container supports four types of database.  Use this image to manage backups of your MariaDB instances.

Images: https://artifacts.developer.gov.bc.ca/ui/repos/tree/General/bcgov-docker-local/backup-container-mariadb

More info: https://github.com/BCDevOps/backup-container

### Backup Container - Mongo<a name="backup-container-mongo"></a>
The community's database backup container supports four types of database.  Use this image to manage backups of your Mongo instances.

Images: https://artifacts.developer.gov.bc.ca/ui/repos/tree/General/bcgov-docker-local/backup-container-mongo

More info: https://github.com/BCDevOps/backup-container

### Backup Container - MSSQL<a name="backup-container-mssql"></a>
The community's database backup container supports four types of database.  Use this image to manage backups of your MSSQL instances.

Images: https://artifacts.developer.gov.bc.ca/ui/repos/tree/General/bcgov-docker-local/backup-container-mssql

More info: https://github.com/BCDevOps/backup-container


### Backup Container - Postgres<a name="backup-container-postgres"></a>
The community's database backup container supports four types of database.  Use this image to manage backups of your Postgres instances.

Images: https://artifacts.developer.gov.bc.ca/ui/repos/tree/General/bcgov-docker-local/backup-container-postgres

More info: https://github.com/BCDevOps/backup-container

### Caddy s2i<a name="caddy-s2i"></a>
The Caddy s2i image is used by the <a href="https://github.com/bcgov/pipeline-templates">pipeline templates</a> that have been developed for the community.

Images: https://artifacts.developer.gov.bc.ca/ui/repos/tree/General/bcgov-docker-local/caddy-s2i-builder

More info: https://github.com/bcgov/s2i-caddy-nodejs

### CodeQL<a name="codeql"></a>
The CodeQL image is used by the <a href="https://github.com/bcgov/pipeline-templates">pipeline templates</a> that have been developed for the community.

Images: https://artifacts.developer.gov.bc.ca/ui/repos/tree/General/bcgov-docker-local/codeql

More info: https://github.com/bcgov/pipeline-templates/tree/main/tekton/base/tasks/codeql


### MongoDB 3.6 HA<a name="mongodb-36-ha"></a>
This is an HA-ready MongoDB image, version 3.6.

Images: https://artifacts.developer.gov.bc.ca/ui/repos/tree/General/bcgov-docker-local/mongodb-36-ha

More info: https://github.com/bcgov/mongodb-replicaset-container


### Patroni/Postgres<a name="patroni-postgres"></a>
This image comes in two versions:
- Patroni 1.6 with Postgres 12.4
- Patroni 2.0 with Postgres 12.4

Images: https://artifacts.developer.gov.bc.ca/ui/repos/tree/General/bcgov-docker-local/patroni-postgres

More info: https://github.com/bcgov/patroni-postgres-container.git


## Legacy Builds<a name="legacy-builds"></a>
Previously, some of these builds were made available in the local image registry of each OpenShift cluster, in the `bcgov` namespace.  Those builds will remain there, but future enhancements will be made only to the images stored in Artifactory.  The legacy builds will continue to be rebuilt monthly, as before, to allow them to pick up security or bug fixes in the base image.


