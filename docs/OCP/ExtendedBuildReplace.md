# Extended Builds, which were Technical Preview prior to 3.7 have been dropped.

## What are Extended Builds?

Extended Builds were a feature available in OpenShift up to and including version 3.6.

Extended Builds were a mechanism to "overlay" the output from one build into an existing image, where the build of the initial image *and* instruction for the "overlay" were defined in a single Build Configuration.

The most common use case is where an application's build-time requirements are different than its runtime requirements.    

Extended Builds are no longer supported, but there are alternative ways to achieve the same functionality via "Chained Builds".  This document describes the process of migrating from using Extended Builds to Chained Builds.   

## What are Chained Builds?

For compiled languages (Go, C, C++, Java, etc.), including the dependencies necessary for compilation in the application image might increase the size of the image or introduce vulnerabilities that can be exploited.

To avoid these problems, two builds can be chained together: one that produces the compiled artifact, and a second build that places that artifact in a separate image that runs the artifact.

https://docs.openshift.com/container-platform/3.7/dev_guide/builds/advanced_build_operations.html#dev-guide-chaining-builds

## Advantages of chained builds over extended builds that lead to this decision:

* Supported by both docker and s2i build strategies, as well as combinations of the two, compared with s2i strategy only for extended builds.
* No need to create/manage a new assemble-runtime script
* Easy to layer application components into any thin runtime-specific image

## Converting Extended builds to chained builds.

https://github.com/BCDevOps/openshift-tools/blob/master/patches/README.md

Conversion:


1. Create a new buildconfig building your application

   > This will likely be a S2I build of your applications code (https://github.com/bcgov/xxxx) and nodejs:6 or another base image.
   
   Verify the build runs successfully and the image has been created 

2. Change your current buildonfig


Example:
Extended build:
```
   "spec": {
        ...
        "source": {
            "type": "Git",
            "git": {
                "uri": "https://github.com/bcgov/mem-mmti-public"
            }
        },
        "strategy": {
            "type": "Source",
            "sourceStrategy": {
                "from": {
                    "kind": "ImageStreamTag",
                    "name": "angular-builder:latest"
                },
                "runtimeImage": {
                    "kind": "ImageStreamTag",
                    "name": "nginx-runtime:latest"
                },
                "runtimeArtifacts": [
                    {
                        "sourcePath": "/opt/app-root/src/dist/",
                        "destinationDir": "tmp/app"
                    }
                ]
            }
        },
        "output": {
            "to": {
                "kind": "ImageStreamTag",
                "name": "angular-on-nginx-build:latest"
            }
        },
        ...
```
Replaced with chaind build:
```
  "spec": {
        ...
        "output": {
            "to": {
                "kind": "ImageStreamTag",
                "name": "angular-on-nginx-build:latest"
            }
        },
        "source": {
            "dockerfile": "FROM angular-on-nginx-build-build-angular-app:latest\nCOPY * /tmp/app/dist/\nCMD  /usr/libexec/s2i/run",
            "images": [
                {
                    "from": {
                        "kind": "ImageStreamTag",
                        "name": "angular-on-nginx-build-build-angular-app:latest"
                    },
                    "paths": [
                        {
                            "destinationDir": "tmp",
                            "sourcePath": "/opt/app-root/src/dist/."
                        }
                    ]
                }
            ],
            "type": "Dockerfile"
        },
        "strategy": {
            "dockerStrategy": {
                "from": {
                    "kind": "ImageStreamTag",
                    "name": "nginx-runtime:latest"
                }
            },
            "type": "Docker"
        },
        ...
```


Last step:

Update your Jenkinsfile to include the new build


## References

https://blog.openshift.com/chaining-builds/
https://docs.openshift.com/container-platform/3.7/dev_guide/builds/advanced_build_operations.html#dev-guide-chaining-builds
https://developers.redhat.com/blog/2017/10/12/container-images-openshift-part-2-structuring-images/
https://www.youtube.com/watch?v=V8oYKwnTtl8
