---
title: Verify Your Deployment in Jenkins Pipeline
description: Verify deployment completes before running functional tests. 
---
**Issue:**

Need to verify if deployment completed before running functional test


**Solution:**

Add line to Jenkinsfile:
```
openshiftVerifyDeployment depCfg: '[dev-deploy-config]', namespace: '[dev-namespace]', replicaCount: 1, verbose: 'false', verifyReplicaCount: 'false'
```
Example:
```
openshiftVerifyDeployment depCfg: 'platform-dev', namespace: 'devex-platform-dev', replicaCount: 1, verbose: 'false', verifyReplicaCount: 'false'
```

Grant access for Jenkins to dev env:
```
oc policy add-role-to-user view -z system:serviceaccount:[tools-namespace]:jenkins -n [dev-namespace]
```
Example:
```
oc policy add-role-to-user view -z system:serviceaccount:devex-platform-tools:jenkins -n devex-platform-dev 
```

Note:  

openshiftVerifyDeployment needs the deploy to have started, otherwise with the Rolling deployment strategy when verifying` the replica count verifyDeploy returns too early. This can be archived by adding a sleep 5 before the verifyDeploy step.

See
https://github.com/BCDevOps/jenkins-pipeline-shared-lib


