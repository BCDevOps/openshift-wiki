# What is OpenShift?

OpenShift is a platform to help you develop and deploy applications to one or more hosts. These can be public facing web applications, or backend applications, including micro services or databases. Applications can be implemented in any programming language you choose. The only requirement is that the application can run within a container.

In terms of cloud service computing models, OpenShift implements the functionality of both a Platform as a Service (PaaS) and a Container as a Service (CaaS).

Using OpenShift as a CaaS, you can bring a pre-existing container image built to the [OpenShift Container Initiative](https://www.opencontainers.org/) (OCI) Image Specification ([image-spec](https://github.com/opencontainers/image-spec)) and deploy it.

The PaaS capabilities of OpenShift build on top of the ability to deploy a container image, by providing a way for you to build in OpenShift your own container image direct from your application source code and have it deployed.

The application source code can include a ``Dockerfile`` with instructions to build a container image. Or, you can use a Source-to-Image (S2I) builder, which takes your application source code and converts it into a container image for you, without you needing to know how to write instructions for building a container image.

# OpenShift vs Kubernetes

[Kubernetes](https://kubernetes.io/) implements a system for automating deployment, scaling and management of containerized applications. It is often referred to as being a Container as a Service (CaaS).

Kubernetes alone does not provide any support for building the container image it runs. You need to run a build tool to create your application image on a separate system and push that to an image registry from which it can be deployed. This is because CaaS focuses on just running containers.

OpenShift builds on top of Kubernetes to implement a Platform as Service (PaaS) environment which is more friendly to developers, as well as provide the additional tools and services needed by operations to implement a comprehensive container application platform.
