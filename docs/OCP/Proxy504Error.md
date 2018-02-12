
# Route Timeouts  504 error for longer running http requests

***Issue:***

Longer running http request return with error 504 due to a session timeout setting of 30s on the Openshift clusetr HA-Proxy.


***Resolution:***

Override the default OpenShift cluster HA-proxy session timeout for your application by adding a setting to the route for the apps.

Example:
```
oc annotate route jenkins --overwrite haproxy.router.openshift.io/timeout=180s
```
This will set the session timeout for jenkins to 3 minutes 

Reference:

https://docs.openshift.com/container-platform/3.6/install_config/configuring_routing.html

