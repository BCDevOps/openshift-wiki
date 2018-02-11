**Issue:**

What the best practice when creating jenkins pipelines

**Solution:**

- Pipeline as code (.i.e. Jenkinsfile in repo)

- Work within stages, all non-setup work should be done in stages
```
stage 'build'
//build
stage 'test'
//test
```
- Do material work within a node

By default, the Jenkinsfile script itself runs on the Jenkins master, using a lightweight executor node is expected to use very few resources. Any material work, like cloning code from a Git server or compiling a Java application, should leverage Jenkins distributed builds capability and run an agent node.
```
stage 'build'
node{
    checkout scm
    sh 'mvn clean install'
}
```
- Aquire node within parallel steps
```
parallel 'integration-tests':{
    node('maven'){ ... }
}, 'functional-tests':{
    node('sonar'){ ... }
}
```
- DO NOT Use input within a node block
```
stage 'deployment'
input 'Do you approve deployment?'
node{
    //deploy the things
}
```
- Define timeouts for inputs
```
timeout(time:5, unit:'DAYS') {
    input message:'Approve deployment?', submitter: 'it-ops'
}
```
- Set environment variables locally not globally
```
withEnv(["PATH+MAVEN=${tool 'm3'}/bin"]) {
    sh "mvn clean verify"
}
```


Resource:
* https://reidweb.com/2017/02/01/what-ive-learnt-about-jenkins-pipelines/
