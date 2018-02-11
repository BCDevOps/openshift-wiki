**Issue:**

Jenkins marks a build as failed after 15 minutes, but the build succeeds in OpenShift	

**Solution:**

By default the limit on a build is 15 minutes. Adjust the OpenShift build timeout in the Jenkins configuration to allow for a longer build.

