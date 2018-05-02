
Author: Leo Lou (DataBC)

# API Management Services.
 
## Current gateway status
* APIs already behind GW https://catalogue.data.gov.bc.ca/dataset?tags=API
* BCGOV API registry (API published under OpenAPI Specs) https://catalogue.data.gov.bc.ca/group/bc-government-api-registry
* enabled for wildcard TLS+SNI for ```*.api.gov.bc.ca```
* current Gateway backend - Kong (https://github.com/kong/kong) API gateway 
  * Used for common logic like rate-limit, app2app authentication like apiKeys, token, keycloak oidc.etc
  * Current Kong Cluster version=> kong-ce.0.12.3

## Service overview
* https://github.com/bcgov/gwa/wiki/Developer-Guide
* https://catalogue.data.gov.bc.ca/dataset/api-gateway-administration

## OpenAPI specs 
Published https://github.com/bcgov/api-specs
 
## Samples
* DataBC demo, this site https://data.gov.bc.ca/ is entirely driven by API https://dbcfeeds.api.gov.bc.ca/ no db backend
* external client production API https://www.workbc.ca/api, WorkBC manage and host their own API but proxy via our gateway for common features like ratelimit, SSL,
 
## Hooks with OCP
* current Kong cluster is running parallel with OCP Kamloops cluster in Zone D plus RRDNS across from Kamloops/Calgary Datacenter
* backend API, you can host your API anywhere, e.g. OCP Kamloops cluster
* Kong Cluster Production is running on a mixed of RHEL VMs and Physical Servers across from Kamloops and Calgary datacenter.
 
## Roadmap and future development,
* OpenAPI Specs is version 3
*  UI (GWA), you are welcome to connect with us directly if you need specific features assume we don’t have already, also welcome to contribute, the source code is internal at the moment and we are working with IP office to make it OSS if possible.   
* IP Anonymous for API/Pods behind Gateway 
