## Issue:

When logging in to JENKINS following error is displayed:
```
{"error":"server_error","error_description":"The authorization server encountered an unexpected condition that prevented it from fulfilling the request.","state":"MTM0MjZlMjctNWI1MS00"}
```

## Solution:

Add missing OAUTH annotation to jenkins service account

See https://access.redhat.com/solutions/3250151  for deatils.

To check if the required annotation for OAUTH is configured:

`oc get sa jenkins -o json`

To Add the required OAUTH annotation:

`oc annotate sa jenkins serviceaccounts.openshift.io/oauth-redirectreference.jenkins='{"kind":"OAuthRedirectReference","apiVersion":"v1","reference":{"kind":"Route","name":"jenkins"}}'`

