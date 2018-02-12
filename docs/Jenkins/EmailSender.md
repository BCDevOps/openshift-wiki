# Sending email from Jenkins pipeline

***Issue:***

Need to send an email once deployment occurred to group.

***Solution:***

1.) 

Configure email server in JENKINS - Manage Jenkins - Configure System - Email Notification: Set SMTP server to apps.smtp.gov.bc.ca

Note: You can send a test email from this page to verify server setting.

2.)

Add following cmds to your pipeline

`  mail (to: 'someone@myemail.com',
         subject: "FYI: Job '${env.JOB_NAME}' (${env.BUILD_NUMBER}) deployed to test",
         body: "See ${env.BUILD_URL} for details. ");`



See 
https://github.com/BCDevOps/jenkins-pipeline-shared-lib

