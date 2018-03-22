
# DevOps Jenkins Shared Library Repository
https://github.com/BCDevOps/jenkins-pipeline-shared-lib.git

# Using the shared Library in your Jenkinsfile

Add the line below to import the shared library
```
library identifier: 'devops-library@master', retriever: modernSCM(
  [$class: 'GitSCMSource',
   remote: 'https://github.com/BCDevOps/jenkins-pipeline-shared-lib.git'])
```

Example:

```
library identifier: 'devops-library@master', retriever: modernSCM(
  [$class: 'GitSCMSource',
   remote: 'https://github.com/BCDevOps/jenkins-pipeline-shared-lib.git'])
   
stage('testing lib') {
    def TIMESTAMP = getTimeStamp();
    echo "${TIMESTAMP}"
}
```

# References:
https://jenkins.io/doc/book/pipeline/shared-libraries/


