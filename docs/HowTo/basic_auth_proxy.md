# Basic Auth for an OpenShift Route

## Table of Contents
1. [Purpose](#purpose)
2. [Overview](#overview)
3. [Assumptions](#assumptions)
4. [Implementation](#implementation)
    1. [ConfigMap](#configmap)
    2. [Deployment](#deployment)
    3. [Service](#service)
    4. [Route](#route)
    5. [Redirect Route](#redirect-route)
5. [Testing](#testing)

## Purpose<a name="purpose"></a>
There is not a simple option for adding basic auth to an OpenShift Route.  In our clusters, applications are generally integrated with a central Single Sign-On system or have no security.  This document describes how to add simple basic auth to a Route.

## Overview<a name="overview"></a>
Caddy is a simple web proxy that can be easily configured and deployed to provide basic auth and HTTP redirects, among other things.  In order to add this layer to an application, we create a ConfigMap, Deployment, and Service for the Caddy proxy, then update the Route in question.

https://caddyserver.com/docs/

## Assumptions<a name="assumptions"></a>
In this document, we assume that the TLS endpoint is the OpenShift router and not Caddy itself.  We will not configure a TLS certificate in Caddy.

You need to have Caddy installed in order to generate hashed passwords.

https://caddyserver.com/docs/install

## Implementation<a name="implementation"></a>

### ConfigMap<a name="configmap"></a>
The ConfigMap contains the "Caddyfile", which is the sum total of the Caddy configuration that we will apply.  Let's look at each of the elements of the configuration...

**Listener**

The listener defines the hostname for which Caddy will accept requests, as well as the port number.  By default, Caddy automatically redirects HTTP requests to HTTPS and also attempts to implement a certificate.  Because we are not configuring TLS in this proxy, we force Caddy to skip the redirect and the certificate implementation by putting the "http" protocol in front of the listener hostname.  In this example, we use an available unprivileged port (2015).
```
http://my-app.apps.silver.devops.gov.bc.ca:2015 {

}
```

**Basic auth**

Within the listener block we create the basic auth configuration.  In this example, we are protecting the entire site (/*), but you could specify any path if you want to protect just a part of your application.  Within the 'basicauth' block we define the username(s) and password(s) to allow.

To generate a hashed password, use the `caddy hash-password` command.  It will prompt for the password and then print the hashed value that you can use in the 'basicauth' block.
```
	basicauth /* {
		my-admin-username $2a$14$mzAE/JD2pTVMBo3CYGYuz.lvYqq2NDMNsPDsTCpdLpura22LviTLa
	}
```

**Reverse proxy**

After the basic auth block, we add the reverse proxy rule.  We use the name of the Service of the application, as well as the front end port of the Service.

`	reverse_proxy http://my-service-name:6789`

**Logging**

Add a logging section.
```
	log {
		output stdout
		level INFO
	}
```

**Redirect**

If you have an old application URl that you would like to automatically redirect to the URL configured above, add another listener block containing the 'redir' directive.
```
http://my-old-app-name.apps.silver.devops.gov.bc.ca:2015 {
	redir https://my-app.apps.silver.devops.gov.bc.ca{uri} permanent
}
```

Putting our full example together into a ConfigMap manifest we have something like this:
```
kind: ConfigMap
apiVersion: v1
metadata:
  name: proxy-config
  namespace: my-namespace-name
  labels:
    app: proxy
immutable: false
data:
  Caddyfile: |
    http://my-app.apps.silver.devops.gov.bc.ca:2015 {
    	basicauth /* {
    		my-admin-username $2a$14$mzAE/JD2pTVMBo3CYGYuz.lvYqq2NDMNsPDsTCpdLpura22LviTLa
    	}
    	reverse_proxy http://my-service-name:6789 # Make sure to set the port to match your service
    	log {
    		output stdout
    		level INFO
    	}
    }
    http://my-old-app-name.apps.silver.devops.gov.bc.ca:2015 {
    	redir https://my-app.apps.silver.devops.gov.bc.ca{uri} permanent
    }
```

### Deployment<a name="deployment"></a>
The proxy Deployment loads the ConfigMap created above.  A few things to note:
- Ensure that the ConfigMap name matches the actual ConfigMap created
- The port number used in the ConfigMap is used in three places in the Deployment, so if you use a different port number, make sure to update the Deployment accordingly.
- The image is pulled from Artifactory, so use an image pull secret.  In this example, the Secret is called 'artifactory-creds'.

```
kind: Deployment
apiVersion: apps/v1
metadata:
  name: proxy
  namespace: my-namespace-name
  labels:
    app: proxy
spec:
  replicas: 1
  selector:
    matchLabels:
      app: proxy
      role: proxy
  template:
    metadata:
      name: proxy
      labels:
        app: proxy
        role: proxy
    spec:
      volumes:
        - name: config-vol
          configMap:
            name: proxy-config
            defaultMode: 420
      containers:
        - resources:
            limits:
              cpu: 60m
              memory: 64Mi
            requests:
              cpu: 20m
              memory: 48Mi
          readinessProbe:
            httpGet:
              path: /ehlo
              port: 2015
              scheme: HTTP
            timeoutSeconds: 10
            periodSeconds: 10
            successThreshold: 1
            failureThreshold: 3
          terminationMessagePath: /dev/termination-log
          name: proxy
          env:
            - name: XDG_DATA_HOME
              value: /tmp
          securityContext:
            capabilities:
              drop:
                - ALL
              add:
                - NET_BIND_SERVICE
            allowPrivilegeEscalation: false
            runAsNonRoot: true
            seccompProfile:
              type: RuntimeDefault
          ports:
            - containerPort: 2015
              protocol: TCP
          imagePullPolicy: IfNotPresent
          startupProbe:
            httpGet:
              path: /ehlo
              port: 2015
              scheme: HTTP
            timeoutSeconds: 1
            periodSeconds: 3
            successThreshold: 1
            failureThreshold: 5
          volumeMounts:
            - name: config-vol
              mountPath: /etc/caddy/Caddyfile
              subPath: Caddyfile
          terminationMessagePolicy: File
          image: 'artifacts.developer.gov.bc.ca/docker-remote/caddy:latest'
      restartPolicy: Always
      terminationGracePeriodSeconds: 30
      dnsPolicy: ClusterFirst
      securityContext: {}
      imagePullSecrets:
        - name: artifactory-creds
      schedulerName: default-scheduler
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: 25%
      maxSurge: 25%
  revisionHistoryLimit: 10
  progressDeadlineSeconds: 600
```

### Service<a name="service"></a>
A Service is required for the proxy.  The main thing here is make sure that the port specified is the same as what is used in the Deployment - in this case, 2015.
```
kind: Service
apiVersion: v1
metadata:
  name: proxy
  namespace: my-namespace-name
spec:
  ipFamilies:
    - IPv4
  ports:
    - name: 2015-tcp
      protocol: TCP
      port: 2015
      targetPort: 2015
  internalTrafficPolicy: Cluster
  type: ClusterIP
  ipFamilyPolicy: SingleStack
  sessionAffinity: None
  selector:
    role: proxy
```

### Route<a name="route"></a>
The Route specifies the hostname, the name of the proxy Service, and the front end port of the proxy Service.

If there is already a Route with this host name, delete it before creating this new Route.
```
kind: Route
apiVersion: route.openshift.io/v1
metadata:
  name: proxy-basicauth
  namespace: my-namespace-name
spec:
  host: my-app.apps.silver.devops.gov.bc.ca
  to:
    kind: Service
    name: proxy
    weight: 100
  port:
    targetPort: 2015-tcp
  tls:
    termination: edge
    insecureEdgeTerminationPolicy: Redirect
  wildcardPolicy: None
```

### Redirect Route<a name="redirect-route"></a>
If you are redirecting an old URL to the one with basic auth, create a Route for that one, too.  It's the same as the first one, except for the `host` field.
```
kind: Route
apiVersion: route.openshift.io/v1
metadata:
  name: proxy-redirect
  namespace: my-namespace-name
spec:
  host: my-old-app-name.apps.silver.devops.gov.bc.ca
  to:
    kind: Service
    name: proxy
    weight: 100
  port:
    targetPort: 2015-tcp
  tls:
    termination: edge
    insecureEdgeTerminationPolicy: Redirect
  wildcardPolicy: None
```

## Testing<a name="testing"></a>
Once all of the resources above have been created, load the URL in your browser.  You should be prompted for a username and password, after which you should be able to access the application normally.

If a redirect route was also created, test that, too, by loading that old URL in your browser.  You should be redirected automatically to the primary URL.


