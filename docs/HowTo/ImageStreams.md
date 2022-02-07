---
title: Best practices for managing image streams
description: Image Streams are used to store the outputs of builds and if not managed properly can clutter up the cluster.
tags:
  - images
  - image streams
  - best practices
---


Image streams provide a means of creating and updating container images in an on-going way. As improvements are made to an image, tags can be used to assign new version numbers and keep track of changes.

## Component parts

### Image

An individual container image is made of layers. This allows for some layers to be re-used by multiple images and save space in both the image registry, and on the container host running the pods.

### Tag

A tag is a pointer to a specific image. It gives a human readable name to a SHA256 has of an image. In OCP, tags keep a revision history of the SHA256s used under that tag name. When pods are created from other objects like Deployments or StatefulSets, the image tag in the spec is changed into a fully resolved SHA256.

There is a pruning script that runs in the evenings. It will remove all but the most recent 3 revisions of a tag, unless those revisions are less than 96 hours old.

### Image Stream

An image stream contains multiple tags.

## Getting Info

The `oc describe ImageStream` command will provide a lot of info about the images, tags, and streams in your namespace.

```console
$ oc -n openshift describe ImageStream python
Name:                   python
Namespace:              openshift
Created:                12 months ago
Labels:                 samples.operator.openshift.io/managed=true
Annotations:            openshift.io/display-name=Python
                        openshift.io/image.dockerRepositoryCheck=2022-01-27T19:15:38Z
                        samples.operator.openshift.io/version=4.7.32
Image Repository:       image-registry.apps.klab.devops.gov.bc.ca/openshift/python
Image Lookup:           local=false
Unique Images:          18
Tags:                   9

3.8
  tagged from registry.redhat.io/rhscl/python-38-rhel7:latest
    prefer registry pullthrough when referencing this tag

  Build and run Python 3.8 applications on RHEL 7. For more information about using this builder image, including OpenShift considerations, see https://github.com/sclorg/s2i-python-container/blob/master/3.8/README.md.
  Tags: builder, python, hidden
  Supports: python:3.8, python
  Example Repo: https://github.com/sclorg/django-ex.git

  * registry.redhat.io/rhscl/python-38-rhel7@sha256:326d4ea9ba7ce695a246a8e59b2b3319c74c79ea51671022ae53dde023320e47
      4 months ago
    registry.redhat.io/rhscl/python-38-rhel7@sha256:40852acd00c534f5088282ff26aadc1bdeffc218698f0382a723184356ae6892
      5 months ago
    registry.redhat.io/rhscl/python-38-rhel7@sha256:457bef694acf7845cbc9da2701861390535f9d620284270feb5d69ca9b76c57a
      6 months ago

3.8-ubi8 (latest)
  tagged from registry.redhat.io/ubi8/python-38:latest
    prefer registry pullthrough when referencing this tag

  Build and run Python 3.8 applications on UBI 8. For more information about using this builder image, including OpenShift considerations, see https://github.com/sclorg/s2i-python-container/blob/master/3.8/README.md.
  Tags: builder, python
  Supports: python:3.8, python
  Example Repo: https://github.com/sclorg/django-ex.git

  * registry.redhat.io/ubi8/python-38@sha256:43b037584dac3425f845faab4f3575a9058c431219ffbf735f937b263713f2d9
      4 months ago
    registry.redhat.io/ubi8/python-38@sha256:af6f93b81f9313de95966e8cd681edb9dbcb5fdbddc5a4cc365af8e4534096ef
      5 months ago
    registry.redhat.io/ubi8/python-38@sha256:03b13281227416eca2d003e532d8d444fdce468270a3fe675f97e05a1bf917b8
      6 months ago
.....
```

Here we can see the `python` image stream has several tags. In the `3.8` tag, there are a couple revisions of the image.

## Make use of Tags

The tag `latest` is commonly used for the most recent build of an image, and likely changes frequently. For production workloads you should rarely use the `latest` tag of an imagestream as it has a high chance of changing unexpectedly and breaking production. Instead, build and push to `latest` then tag that revision to something like `test` for testing and `prod` for production. This lets you test and promote an image in a controlled way.

On the opposite end, be sure to not make too many tags. Some teams create a new tag for each pull request in their continuous integration process. But this can leave a lot of unneeded images in the registry. Be sure to clean up any unused tags after.

## Smaller is better

Since images need to be copied to the host to run the pod and cached there, having smaller images will improve the startup time of the pods.

One way to achieve this is with [chained builds](https://docs.openshift.com/container-platform/4.8/cicd/builds/advanced-build-operations.html#builds-chaining-builds_advanced-build-operations). This ensures that the dependencies needed to build code is not included in the final running image.

You can describe a image tag to see the size of the image.

```console
$ oc -n openshift describe ImageStreamTag python:3.8
Image Name:     sha256:326d4ea9ba7ce695a246a8e59b2b3319c74c79ea51671022ae53dde023320e47
Docker Image:   image-registry.openshift-image-registry.svc:5000/openshift/python@sha256:326d4ea9ba7ce695a246a8e59b2b3319c74c79ea51671022ae53dde023320e47
Name:           sha256:326d4ea9ba7ce695a246a8e59b2b3319c74c79ea51671022ae53dde023320e47
Created:        4 months ago
Description:    Build and run Python 3.8 applications on RHEL 7. For more information about using this builder image, including OpenShift considerations, see https://github.com/sclorg/s2i-python-container/blob/master/3.8/README.md.
Annotations:    iconClass=icon-python
                image.openshift.io/dockerLayersOrder=ascending
                openshift.io/display-name=Python 3.8
                openshift.io/provider-display-name=Red Hat, Inc.
                sampleRepo=https://github.com/sclorg/django-ex.git
                supports=python:3.8,python
                tags=builder,python,hidden
                version=3.8
Image Size:     226.6MB in 5 layers
Layers:         76.43MB sha256:ad62d8acaeb8e10bb459e0fb98054b6cd0769fe4d0485daf504967c8ffccd2df
                1.814kB sha256:8a4cee2d3973a8b9ccb73fc982adbfef274e95cb2548098e755b1df847aca0de
                7.222MB sha256:edfb7d09283d32130db5865c0ee1e7571c1b4e464b87fc7bba083c43f80e5bcc
                90.81MB sha256:90667cb683877d380453853a1128831ad0f713cfab27841ee445df94aaf85d93
                52.11MB sha256:3e1f2b9ac448827f0e2ec5de5dd864895c69de23b0ed9a624d7fb7a1bfad7e75
Image Created:  4 months ago
Author:         <none>
Arch:           amd64
Entrypoint:     container-entrypoint
Command:        /bin/sh -c $STI_SCRIPTS_PATH/usage
Working Dir:    /opt/app-root/src
User:           1001
Exposes Ports:  8080/tcp
...
```

## Usage Notifications

The platform will now be sending a weekly email to teams that are using too much space on the registry. The image registry is a shared service and overuse of it can lead to other teams being unable to push their builds, or to the platform team having to buy more storage space.

The emails will list all the image streams, their tags, and revisions. It will show the size used by each of these ensuring to not double-count layers that are reused. This should help provide info on where to focus efforts to reduce image registry usage.

You can delete a whole image stream with `oc delete imagestream <is_name>` or just a tag with `oc tag -d <imagestream>:<tag>` . See [Managing Image Streams](https://docs.openshift.com/container-platform/4.8/openshift_images/image-streams-manage.html#images-imagestream-remove-tag_image-streams-managing) for more.

If you have any questions please reach out on [#devops-operations](https://chat.developer.gov.bc.ca/channel/devops-operations) and someone will be happy to help you clean up your projects image streams.
