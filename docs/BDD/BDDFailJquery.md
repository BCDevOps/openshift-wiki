
Author: Roland Stens 

**Issue:**

BDD validation process fails with "Bootstrap's JavaScript requires jQuery"

The related code is:

```
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>    
<script src=" ...  'gwells/js/bootstrap.min.js' ... "></script>
```

bootstrap.min.js has dependency on jquery.min.js. But there is a racing condition that the load of jquery.min.js is not completed before phantomJs starts to process bootstrap.min.js.

Verification:

```
oc rsh <jenkins-pipeline-pod>
```

run the BDD test locally 
```
`gradlew --stacktrace --debug phantomJsTest`
```
 
Solution:

Download jquery.min.js from the url and store at load. Refer to the local copy.

```
<script src="... 'gwells/js/jquery.min.js' ... "></script>
<script src="... 'gwells/js/bootstrap.min.js' ... "></script>
```

As a general guideline: Keep all your javascript files local.

