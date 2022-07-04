# Argo CD Usage on the DevExchange OpenShift Platform

Argo CD is a declarative, GitOps continuous delivery tool for Kubernetes (the foundation of OpenShift).  It is efficient, well supported, and well documented. 

This document describes how to use Argo CD with your OpenShift project.

It is available to any team on the B.C. government's OpenShift platform and can help teams:
* Implement a GitOps-style deployment service
* Reduce the maintenance overhead of their pipelines
* Reduce resource consumption by using a shared service

## Table of Contents
1. [Why Argo CD is Good for You](#why-use-argocd)
2. [Enable Argo CD for Your Project Set](#enable-argocd)
    1. [Set access for the GitHub repo](#set-access-github)
    2. [What style of deployment is used?](#style-of-deployment)
        1. [Helm](#helm)
        2. [Kustomize](#kustomize)
    3. [Control the deployment sequence](#control-the-deployment-sequence)
3. [Create Applications in Argo CD](#create-applications)
    1. [Create the application](#create-the-application)
    2. [Synchronize the application](#synchronize-the-application)
4. [Configure Your Project](#configure-your-project)
    1. [Project access control](#project-access-control)
5. [Additional Information](#additional-information)

## Why Argo CD is Good for You<a name="why-use-argocd"></a>
There are a number of reasons for using Argo CD over other tools, such as Jenkins.  Argo CD is designed specifically for Kubernetes and is efficient, well supported, and well documented.  The YAML manifests that define all Kubernetes resources can be managed in a Git repository.  Argo CD can monitor that repo and maintain application state on the cluster consistent with the desired state as defined by the manifests.  Updates to applications involve updates to the manifest files.  As a result of this architecture:
* All application changes are recorded as Git commits, providing a detailed change history.
* Rollbacks can be achieved by reverting to a previous commit.
* The configuration is portable, in the event the application is moved to another host.
* Argo CD can be easily integrated with CICD pipelines.
* Kustomize and Helm support satisfy the needs of most teams.
* When combined with pipeline tools such as GitHub Actions or OpenShift Pipelines, teams no longer need to maintain their own pipeline infrastructure.

## Enable Argo CD for Your Project Set <a name="enable-argocd"></a>
A self-serve system is in place for the setup of Argo CD for your project set.  To get started, follow these instructions.  (If your project requires a ministry-wide grouping of projects within Argo CD, please contact the Platform Services Team.)
- Prepare a `GitOpsTeam` CustomResource
    - Use this template: <a href="gitopsteam_template.yaml">GitOpsTeam Template</a>
    - Use the inline comments to populate this file
- Ensure that all users in the 'projectMembers' group have a Keycloak ID in the realm used by Argo CD.  They can do this by attempting to access the Argo CD UI for the given cluster:
    - Silver
        - https://argocd-shared.apps.silver.devops.gov.bc.ca
    - Gold & Gold DR
        - https://argocd-shared.apps.gold.devops.gov.bc.ca
        - https://argocd-shared.apps.golddr.devops.gov.bc.ca
- Create the GitOpsTeam CustomResource in your **tools** namespace
    - `oc -n myproject-tools create -f gitopsteam.yaml`

After creation of the GitOpsTeam resource, an OpenShift operator will:
- Create a "gitops" repo for your project
    - This is the repository that Argo CD will read for your Application manifests.
    - **Note:** This repo is in the `bcgov-c` GitHub Organization, which has a limited number of seats and requires that users reply to an invitation from GitHub to join the organization.  Please limit access to this repo to just those team members that require access for manual updates.  Most updates will be made by your **pipeline**.
    - Your gitops repo will be called `bcgov-c/tenant-gitops-licenseplate`
- Create Keycloak groups used for controlling access to your Project in the ArgoCD UI
- Create the Argo CD Project

### Set access for the GitHub repo <a name="set-access-github"></a>
Once your GitHub repo has been created, you need to allow your pipeline to read from and write to it.  Do this by creating an SSH key pair and adding it as a Deploy Key in the repo.

Create an SSH key - the following can be done on a Linux or Mac system.  Use a descriptive name for the key.

`ssh-keygen -f tenant-gitops-mylicenseplate`

In your "tenant-gitops-" repo, add the key as a Deploy Key:
* Click `Settings` --> `Deploy keys` --> `Add deploy key`
* Enter a descriptive name for the key, such as "read-write"
* Copy the contents of the PUBLIC key (the file with the .pub extension) into the key field, **but remove the 'user@host' bit at the very end of the line.**
* Check the checkbox for "allow write access"
* Save the deploy key

Add the private key as a Secret for your pipeline.  If using GitHub Actions, add the Secret in the repository where the Action runs; if using OpenShift Pipelines (Tekton), add the Secret in your tools namespace.

Give the Secret a meaningful name, such as MANIFEST_REPO_DEPLOY_KEY, and copy the entire contents of the PRIVATE key file (having no file extension), **incuding the BEGIN and END lines**, into the value of the secret.

## Migration and Setup <a name="migration-and-setup"></a>
As Argo CD reads manifest files from a Git repository, this repo must be prepared before the application is configured in Argo CD.  Depending on the application's current deployment strategy, the repo setup will vary.

Although no particular structure is required in the manifest repo, we suggest creating a directory for each application.  In addition to setting a repo path for each application in Argo CD, you can also specify a branch or tag.

### What style of deployment is used? <a name="style-of-deployment"></a>
Argo CD supports several deployment strategies, including:
* Helm
* Kustomize
* Ksonnet (being deprecated)
* Jsonnet

This document focuses on Helm and Kustomize.

#### Helm <a name="helm"></a>
[https://argo-cd.readthedocs.io/en/release-2.0/user-guide/helm/](https://argo-cd.readthedocs.io/en/release-2.0/user-guide/helm/)

Helm users will already have a set of files prepared and these are easily migrated to the manifest repo.  Create a top-level directory for your application.  Place all Helm files in this directory.  Also put your values files in the same directory, named according to environment.  When configuring the app in the Argo CD UI, you will specify the path to the values file.

#### Kustomize <a name="kustomize"></a>
[https://argo-cd.readthedocs.io/en/release-2.0/user-guide/kustomize/](https://argo-cd.readthedocs.io/en/release-2.0/user-guide/kustomize/)

Kustomize is a more generic system, which allows you to declare a default set of resources and then configure just the differences from default for each environment.

If your application is already set up for Kustomize, then you just need to move your Kustomize files into the manifest repo.

If moving an existing application to Kustomize and Argo CD for the first time, some effort will have to be made to generate the manifest files.  The live manifests can be fetched from OpenShift using the command line.  Certain fields will have to be removed, however, as OpenShift adds a number of fields for internal resource management.  A shell script has been prepared to help with the manifest creation.

[https://github.com/BCDevOps/openshift-wiki/blob/master/docs/ArgoCD/get_ns_resources.sh](https://github.com/BCDevOps/openshift-wiki/blob/master/docs/ArgoCD/get_ns_resources.sh)

Once the manifest files have been generated, the repo structure is prepared.  Within the manifest repo, in the top-level directory for the given application, create the following directories:
* base
* overlays
* overlays/dev
* overlays/test
* overlays/prod

Copy the manifest files to the `base` directory.  If you use custom SSL certificates for your routes, they will have to be removed from the manifest file and replaced with a reference to a Secret, from which they will be populated at deployment time.  Do not include certificate info in your manifest repository. 

Create a file `base/kustomization.yaml` containing a list of all manifest files.  For example:
```
resources:
- configmap.my-app.yaml
- deployment.my-app.yaml
- route.my-app.yaml
- service.my-app.yaml
```

In the `overlays/dev` directory, you'll need to:
* create any "patch" files that define differences from the default
* create kustomization.yaml

**Patch Files**

These files should contain individual modifications to a resource.  For a larger resource, such as a Deployment, it is recommended to create multiple patch files, one for each change.

Each patch file starts with the apiVersion, kind, and metadata name of the resource, followed by the change.  For example, to set the replica count for a Deployment:
```
apiVersion: apps.openshift.io/v1
kind: Deployment
metadata:
  name: my-app1
spec:
  replicas: 2
```

**kustomization.yaml**

The kustomization.yaml file will likely contain several sections.  Firstly, it specifies the apiVersion and kind, similar to a patch file, and includes a list of resources, starting with the base directory.
```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
- ../../base
```

Patch files are included in a list under the heading patchesStrategicMerge, such as:
```
patchesStrategicMerge:
- deployment.my-app1.replicas.yaml
- route.my-app1.yaml
```

Images are also managed in kustomization.yaml.  In an 'images' section, create an entry for each image that is likely to be updated by your pipeline.  Each image listing has three parts:
* name - the placeholder name of the image that you use in your base file
* newName - the base URL of the image
* digest - the unique ID of the image
In this way, your pipeline build will be able to update the image ID for a given environment.

A kustomization.yaml example with all three sections:
```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
- ../../base
patchesStrategicMerge:
- deployment.my-app1.replicas.yaml
- route.my-app1.yaml
images:
- name: my-app1-image
  newName: image-registry.openshift-image-registry.svc:5000/mylicenseplate-tools/myapp1buildconfigname
  digest: sha256:7da096fa377221d82a28f9b7888130b89382f61ea54018f1b8d26218173ec4eb
```

Consult the Kustomize documentation for more information, as this doc is meant to just get you started.

[https://kubectl.docs.kubernetes.io/guides/](https://kubectl.docs.kubernetes.io/guides/)

[https://kustomize.io/tutorial](https://kustomize.io/tutorial)


### Control the deployment sequence <a name="control-the-deployment-sequence"></a>
If you have some resources that should be processed before others, you can use the Argo CD notion of 'sync-waves'.  Resources having sync waves with lower numbers are processed before those having sync waves with higher numbers.  To utilize this, add a sync-wave setting to metadata.annotations.  For example:
```
metadata:
  annotations:
    argocd.argoproj.io/sync-wave: "2"
```


## Create Applications in Argo CD <a name="create-applications"></a>
Once the manifest repo has a deploy key configured and the manifests themselves have been added, you are almost ready to add the application in Argo CD.  **Before you do, make sure that the target namespace can tolerate a disruption.**  Once you create the application in Argo CD and synchronize it, Argo CD will begin updating resources, so if there is a problem with your manifests, existing resources could be affected.

### Create the application <a name="create-the-application"></a>
In the Argo CD UI, click the Applications link at the top of the left-side navigation.  Click 'New App'.
* Application Name - Application names must be unique across all projects.  Give your app a meaningful name that includes the target environment.  A good naming convention would be to put the license plate or project name at the beginning, followed by the app name, followed by the environment, such as `abc123-myapp1-dev`.
* Project - Select your project from the dropdown menu.
* Sync Policy and Sync Options can be left alone until you know what you need.
* Source repository URL - Use the SSH style URL for your manifest repo, such as `git@github.com:bcgov-c/tenant-gitops-abc123.git`
* Source Revision - Leave this as "HEAD" if you are using the master branch, otherwise enter the branch name.  You can also set the dropdown to TAG and enter a tag name.
* Source Path - Enter the path within the manifest repo, for example `my-app1/overlays/dev`
* Destination Cluster URL - Select the local cluster URL from the dropdown.  This is the only option.
* Destination Namespace - Enter the target namespace, such as `abc123-dev`
* Click 'Create'

If you get an error message when trying to create the application, read the error carefully and try to fix it, then recreate the app.

### Synchronize the application <a name="synchronize-the-application"></a>
Once the application has been successfully created, and assuming you have not yet enabled automatic synchronization, click on the app on the application list page.  Argo CD will have already scanned the files in the manifest repo at the path and branch/tag specified and will show 'out of sync'.  To begin synchronizing the app, and thus (potentially) altering the resources in your OpenShift namespace, click the 'Sync' button, and then 'Synchronize'.  It will take a little bit of time, depending on how many resources are defined for this app.

If the sync result shows 'failed', click the 'failed' message to view messages explaining why it failed.  There could be a problem with your manifest files or repo configuration, for example.

If the sync has succeeded, but still shows as "progressing", or if there is an individual resource that is still not showing as successfully synced, click the resource that is not showing as healthy and click the 'Events' tab to see what the problem is.

Once you are satisfied with the setup, feel free to enable automatic synchronization.


## Configure Your Project<a name="configure-your-project"></a>
It should be noted that there are some constraints placed on Projects and Applications in this shared Argo CD instance.

**Source Repository**

This is the repository that can be used as the source repo for an application and is limited to the new GitHub repo (tenant-gitops-licenseplate) that was created for you.  You can use only this repo as the source for applications for this project.  This limitation exists partly to prevent applications from being created from third-party sources that may not be safe, and partly to simplify automation associated with this service.

**Destination**

Each Argo CD Project is associated with an OpenShift project set (license plate).  The destination of an Application is its namespace.  A Project can deploy applications only to namespaces within its project set (tools, dev, test, prod).

**Namespace Resources**

There are a few namespace-scoped resources that you will not be able to modify.  Mostly this is to avoid circumvention of quotas, and to also prevent the possible accidental deletion of an entire namespace.
* ClusterRole
* LimitRange
* Namespace
* Node
* ResourceQuota

### Project access control <a name="project-access-control"></a>
Access to the gitops repository and the Argo CD UI is controlled by way of the GitOpsTeam resource in your `-tools` namespace.  After editing this resource, the operator will make any updates shortly after (typically less than a minute).

Access to the Git repository includes five sets of permissions.

Access to the Argo CD UI includes two sets of permissions: read/write and read-only

See the <a href="gitopsteam_template.yaml">GitOpsTeam template</a> for more details.


## Additional Information <a name="additional-information"></a>

Current version, as of July 2022: v2.2.10

Argo CD: [https://argo-cd.readthedocs.io/en/release-2.0/](https://argo-cd.readthedocs.io/en/release-2.2/)

Kustomize: [https://kustomize.io/](https://kustomize.io)

Helm: [https://helm.sh/](https://helm.sh/)






