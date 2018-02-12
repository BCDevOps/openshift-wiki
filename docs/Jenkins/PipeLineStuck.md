***Issue:***

OpenShift pipeline builds appear "stuck" - they start but stay at the running stage for hours. Viewing the console logs for the jenkins pod shows that there are problems deleting a Jenkins job.

***Solution:***

Login to Jenkins and manually delete the job. If you are presented with an error, rsh to the Jenkins pod and use the rm command to delete the folder in question, and retry the delete from the Jenkins UI.
