---
description: Quickly build API-centric applications. Leverage the latest microservice and container design patterns. And tie it all together with the Kong microservice API gateway.
title: API Gateway (powered by Kong CE)
image: "https://raw.githubusercontent.com/Kong/docker-official-docs/master/kong/logo.png"
author: ll911 leo.lou@gov.bc.ca
---

# API Management Services.

## Service overview
![](https://raw.githubusercontent.com/bcgov/gwa/master/img/overview.png)
* https://github.com/bcgov/gwa/wiki/Developer-Guide
* https://catalogue.data.gov.bc.ca/dataset/api-gateway-administration

## Current gateway status
* Current Kong version
  * Prod Cluster version=> kong-ce.0.14.1
  * QA Cluster version => kong-ce.1.1.x
* OpenAPI Specs supported version => 3.x(current), 2.x (deprecated)
  * Published on https://github.com/bcgov/api-specs
* APIs already behind GW https://catalogue.data.gov.bc.ca/dataset?tags=API
* BCGOV API registry (API published under OpenAPI Specs) https://catalogue.data.gov.bc.ca/group/bc-government-api-registry
* enabled for wildcard TLS+SNI for `*.api.gov.bc.ca`, `*.data.gov.bc.ca`
* enabled for WAM siteminder agent protection for `*.apps.gov.bc.ca`
* current Gateway backend - Kong (https://github.com/kong/kong) API gateway 
  * Used for common logic like rate-limit, app2app authentication like apiKeys, token, keycloak oidc.etc

### Use API Gateway with OpenID Connect (e.g. BCGOV-SSO AKA Keycloak)
#### TL;DR - see workflow diagram below
![](https://raw.githubusercontent.com/nokia/kong-oidc/master/docs/kong_oidc_flow.png)

## Where to start
* if you are building an API, register your API in https://argg.apps.gov.bc.ca/int/ 

## Use case
* Demo, 
  * httpbin api: https://gwa-demo.pathfinder.gov.bc.ca/
  * source code: https://github.com/bcgov/gwa/blob/master/k8s/gateway-dbless-pod.yaml
* DataBC, https://data.gov.bc.ca/ is entirely driven by API https://dbcfeeds.api.gov.bc.ca/ no db backend
* WorkBC, https://www.workbc.ca/api, WorkBC manage and host their own API but proxy via our gateway for common features like ratelimit, SSL, etc.
* GCPE/GDX, Site Analytics Services running behind Gateway using IP Anonymity for Privacy Act compliance
 
## Hooks with OpenShift cluster in Kamloops
* current Kong cluster is running parallel with OpenShift cluster Kamloops in Zone D plus RRDNS across from Kamloops/Calgary Datacenter
* backend API, you can host your API anywhere, e.g. OCP Kamloops cluster
* Kong Cluster Production is running on a mixed of OpenShift cluster, RHEL VMs, Physical Servers across from Kamloops and Calgary datacenter.
* traffic pattern:
  * A, not using gateway`*.pathfinder.gov.bc.ca` (F5 VIP) => `OpenShift Router` => your running pods
  * B, using gateway`*.api.gov.bc.ca or your own DNS` (API Gateway Cluster) => `OpenShift Router` => your running pods
  * C, using gateway`*.api.gov.bc.ca or your own DNS` (API Gateway Cluster) => your running app/api/svc elsewhere
 
## Roadmap and future development,
* kong 1.1+, database-less gateway support declarative configuration via yaml or json
* Admin UI improvement  
* Support `PROXY_PROTOCOL` in traffic pattern B mentioned above for better performance in TLS end to end deployment.
