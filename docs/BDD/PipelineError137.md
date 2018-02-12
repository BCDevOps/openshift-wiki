****Issue: 

Functional tests fail when running gradlew with error 137

Symptom/Error in JENKINS log:
```
21:45:59.795 [ERROR] [org.gradle.internal.buildevents.BuildExceptionReporter] 

21:45:59.795 [ERROR] [org.gradle.internal.buildevents.BuildExceptionReporter] FAILURE: Build failed with an exception.

21:45:59.795 [ERROR] [org.gradle.internal.buildevents.BuildExceptionReporter] 

21:45:59.795 [ERROR] [org.gradle.internal.buildevents.BuildExceptionReporter] * What went wrong:

21:45:59.796 [ERROR] [org.gradle.internal.buildevents.BuildExceptionReporter] Execution failed for task ':phantomJsTest'.

21:45:59.796 [ERROR] [org.gradle.internal.buildevents.BuildExceptionReporter] > Process 'Gradle Test Executor 2' **finished with non-zero exit value 137**

21:45:59.796 [ERROR] [org.gradle.internal.buildevents.BuildExceptionReporter] 

21:45:59.796 [ERROR] [org.gradle.internal.buildevents.BuildExceptionReporter] * Exception is:

21:45:59.797 [ERROR] [org.gradle.internal.buildevents.BuildExceptionReporter] org.gradle.api.tasks.TaskExecutionException: Execution failed for task ':phantomJsTest'.
```

Solution:

This is a memory issue. The maven node needs more memory to run the gradlew phantomjs tests.
Goto the JENKINS instance, Manage Jenkins, Config System. Under Kubernet node maven (advanced settings) increase max memory to 4Gi.

