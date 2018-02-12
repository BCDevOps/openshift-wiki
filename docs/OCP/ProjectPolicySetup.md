
## Configure the access controls to allow the Jenkins instance to tag imagestreams in the environment projects, and to allow the environment projects to pull images from the tools project

```
oc policy add-role-to-user system:image-puller system:serviceaccount:<project>-dev:default -n <project>-tools
oc policy add-role-to-user edit system:serviceaccount:<project>-tools:default -n <project>-dev

oc policy add-role-to-user system:image-puller system:serviceaccount:<project>-test:default -n <project>-tools
oc policy add-role-to-user edit system:serviceaccount:<project>-tools:default -n <project>-test

oc policy add-role-to-user system:image-puller system:serviceaccount:<project>-prod:default -n <project>-tools
oc policy add-role-to-user edit system:serviceaccount:<project>-tools:default -n <project>-prod
```
