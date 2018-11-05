---
description: Annotate Routes for things like timeouts or whitelisting.
---
# Route Annotations - Timeouts, Whitelists, etc

## Increase the IP timeout for a given route (i.e if you get the 504 error):
 
```oc annotate route <route-name> --overwrite haproxy.router.openshift.io/timeout=180s```
 
## Limit access to a given route:
 
```oc annotate route <route-name> --overwrite haproxy.router.openshift.io/ip_whitelist=’142.0.0.0/8’```
 
The above can also be done via the GUI by edting the YAML of the route:
``` 
metadata:
  annotations:
    haproxy.router.openshift.io/ip_whitelist: 142.0.0.0/8
    haproxy.router.openshift.io/timeout: 180s
```
Reference: https://docs.openshift.com/container-platform/3.7/architecture/networking/routes.html#route-specific-annotations
