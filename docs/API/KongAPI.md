---
description: Quickly build API-centric applications. Leverage the latest microservice and container design patterns. And tie it all together with the Kong microservice API gateway.
title: API Gateway (powered by Kong CE)
author: ll911 leo.lou@gov.bc.ca
---
## API Gateway (powered by Kong CE)

## Service overview
![](https://raw.githubusercontent.com/bcgov/gwa/master/img/overview.png)
* https://github.com/bcgov/gwa/wiki/Developer-Guide
* https://catalogue.data.gov.bc.ca/dataset/api-gateway-administration

## Current gateway status
* Current Kong version
  * DataBC Cluster version=> kong-ce.0.14.1
  * OpenShift Cluster version => kong-ce.1.4.3
    * DB mode: backend support postgres or cassandra - PostgreSQL recommanded for OpenShift Cluster and PostgreSQL can be managed seperately
    * DB-less mode: using k8s [configmaps](https://docs.openshift.com/container-platform/3.11/dev_guide/configmaps.html) or [secrets](https://docs.openshift.com/container-platform/3.11/dev_guide/secrets.html), oidc bridge not available in this mode.
* OpenAPI Specs supported version => 3.x(current), 2.x (deprecated)
  * Published on https://github.com/bcgov/api-specs
* APIs already behind GW https://catalogue.data.gov.bc.ca/dataset?tags=API
* BCGOV API registry (API published under OpenAPI Specs) https://catalogue.data.gov.bc.ca/group/bc-government-api-registry
* enabled for wildcard TLS+SNI for `*.api.gov.bc.ca`, `*.data.gov.bc.ca`
* enabled for WAM siteminder agent protection for `*.apps.gov.bc.ca`
* current Gateway backend - Kong (https://github.com/kong/kong) API gateway 
  * Used for common logic like rate-limit, app2app authentication like apiKeys, token, keycloak oidc.etc

## Where to start
* if you are building an API, register your API in https://argg.apps.gov.bc.ca/int/ 
  * [API Registration Guide](https://github.com/bcgov/argg-ui/wiki/API-Registration-Guide)

## Use case
* Demo, 
  * httpbin api: https://gwa-demo.pathfinder.gov.bc.ca/ (it may not be always running, use the k8s specification file below to create the object anywhere that has k8s/okd running)
  * code: https://github.com/bcgov/gwa/blob/master/k8s/gateway-dbless-demo.yaml
* DataBC, https://data.gov.bc.ca/ is entirely driven by API https://dbcfeeds.api.gov.bc.ca/ no db backend
* WorkBC, https://www.workbc.ca/api, WorkBC manage and host their own API but proxy via our gateway for common features like ratelimit, SSL, etc.
* GCPE/GDX, Site Analytics Services running behind Gateway using IP Anonymity for Privacy Act compliance
* Use API Gateway with OpenID Connect (e.g. BCGOV-SSO AKA Keycloak integration without write the logic in your code)
  * [Sample - Secure GeoServer WFS without keycloak adaptor or custom oidc plugin](https://geows-d.data.gov.bc.ca/?STYLES=&TILED=&FORMAT=image%2Fpng&BBOX=-13733176.772864%2C6186419.502904%2C-13733017.479292%2C6186496.686387&WIDTH=1067&HEIGHT=517&SRS=EPSG%3A3857&SERVICE=WMS&LAYERS=WHSE_CADASTRE.CBM_INTGD_CADASTRAL_FABRIC_SVW&TRANSPARENT=TRUE&REQUEST=GetMap&VERSION=1.1.1) 
##### TL;DR - see workflow diagram below
![](https://raw.githubusercontent.com/nokia/kong-oidc/master/docs/kong_oidc_flow.png)
 
## Hooks with OpenShift cluster in Kamloops
* current Kong cluster is running parallel with OpenShift cluster Kamloops in Zone D plus RRDNS across from Kamloops/Calgary Datacenter
* backend API, you can host your API anywhere, e.g. OCP Kamloops cluster
* Kong Cluster Production is running on a mixed of OpenShift cluster, RHEL VMs, Physical Servers across from Kamloops and Calgary datacenter.
* traffic pattern:
  * A, self managed database-less/sidecar gateway`*.pathfinder.gov.bc.ca or your own DNS` (F5 VIP) => `OpenShift Router` => Gateway ReplicaSets => your running pods
  * B, using DataBC managed gateway`*.api.gov.bc.ca or your own DNS` (API Gateway Cluster) => `OpenShift Router` => your running pods
  * C, using DataBC managed gateway`*.api.gov.bc.ca or your own DNS` (API Gateway Cluster) => your running app/api/svc elsewhere
 
## Roadmap and future development,
* kong 1.4+, database-less gateway support declarative configuration via yaml or json
* Admin UI improvement  
* Support `PROXY_PROTOCOL` in traffic pattern B mentioned above for better performance in TLS end to end deployment.
