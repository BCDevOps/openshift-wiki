# Images in OpenShift

References:
* https://docs.openshift.com/container-platform/3.7/architecture/core_concepts/builds_and_image_streams.html#image-streams

Definitions:

* Image stream: An OpenShift Container Platform object that contains pointers to any number of Docker-formatted container images identified by tags. You can think of an image stream as equivalent to a Docker repository.

* Image stream tag: A named pointer to an image in an image stream. An image stream tag is similar to a Docker image tag. See Image Stream Tag below.

ImageStreams and ImageStreamTags are pointers to the image stored in the image registry.

CLI Commands:
* oc get is
* oc describe is/{image-stream-name}
* oc get istag

