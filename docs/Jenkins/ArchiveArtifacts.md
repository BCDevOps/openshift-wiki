**Issue:**

Need to archive test results or other files

**Solution:**

Add an archive stage to your pipeline.
Example:

`  // Archive the built artifacts`

`archive (allowEmptyArchive: true, includes: 'report/*.html')`

Even better wrap your archive in a try/catch block:

`try {
  <your stage steps>
} finally {
  archiveArtifacts allowEmptyArchive: true, artifacts: 'build/reports/**/*'
}`


Note: 

Archive will show only after the job is finished. I.e. if the job waits for input the archive does not show.
There is a trick to get around this by copying the files to be archived in a new folder in the workspace.

```
	 dir ('BDDreports') {
	   sh 'ls -l'
	   writeFile file:'ReadMe.txt', text:'BDD Test Results Folder'
	   sh 'cp reports/* BDDreports/'
	   sh 'ls -l'
	 }
```


See
https://github.com/BCDevOps/jenkins-pipeline-shared-lib


