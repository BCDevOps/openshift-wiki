***Issue:***

Jobs waiting for input. 

**Solution:***
Wrap the input in a timeout.
To permit only specific users to promote set the submitter list (comma separated list of user ids).

Example:
```
stage('deploy-test') {
  timeout(time: 10, unit: 'MINUTES') {
    input message: "Deployment to test?", submitter: 'test-view,test1-view'
  }
}
```

See
https://github.com/BCDevOps/jenkins-pipeline-shared-lib


