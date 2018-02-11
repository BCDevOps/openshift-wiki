
**Issue:**

Setup Jenkins image with OAUTH

**Solution:**

Step 1:

Deleted ALL the jenkins objects from the config 
- Route
- service
- endpoint
- replication controllers
- pvc
- role binding
- service account
(Note: Leave the secrets as is)

Via commandline (oc) you can delete most of the objects:

` oc describe dc jenkins-pipeline-svc|more      (look for the label with template=)`

`oc get all -l template=<label-id-for-jenkins> -n <namespace>`

`oc delete all -l template=<label-id-for-jenkins> -n <namespace>`

Go to UI and verify all jenkins objects are gone. Remove whats left behind.

Step 2:

Add to project
Select Continuous Integration & Deployment
Select BC Gov Pathfinder Jenkins (Persistent)

Step 3:

Configure Jenkins 
* Add env variable JAVA_OPTS value -XX:MaxMetaspaceSize=512m  to jenkins config
* In jenkins
    * Maven Kubernet node (cpu, memory, namespace)
       * Environment Vars (EnvVars) : OPENSHIFT_JENKINS_JVM_ARCH = x86_64
       * Requested Mem 1Gi; Limited Mem 4Gi
       * Request CPU: 300m; Limit CPU: 500m
    * Configure timeouts
      Build Verification 180 (was 60)
    * Re-apply other changes you might have done (like extra env vars, etc)

NOTE:

https://github.com/BCDevOps/openshift-tools/tree/master/provisioning


