---
description: Pathfinder Openshift specifics and resources.
---
# OpenShift Networking - Pathfinder Project Config

References:
* https://docs.openshift.com/container-platform/3.7/architecture/networking/sdn.html
* https://docs.openshift.com/container-platform/3.7/architecture/networking/haproxy-router.html
* https://docs.openshift.com/container-platform/3.7/architecture/networking/routes.html#route-specific-annotations

Pathfinder OpenShift specific implementation notes:
* SDN uses the ovs-multitenant SDN plug-in for configuring the pod network.
* Pathfinder OpenShifyt is not using the F5 plugin; routing within OpenShift is using OpenShift-provided HA Proxy. The load balancer is outside OpenShift (.209) and forwards traffic to the HA Proxy instances is an F5, but it is not tightly integrated with OpenShift. 
* CIDR Range 142.34.143.128/26; Netmask 255.255.255.192; Wildcard Bits 0.0.0.63; First IP 142.34.143.128; Last IP 142.34.143.191
* OpenShift servers are in VLAN 138 in Kamloops
* Private Network IP Range: 172.51.0.0/16

* Access (ingress) points:
  * console.pathfinder.gov.bc.ca:8443 - (142.34.208.210) API and web UI
  * .pathfinder.gov.bc.ca:80/443 - (142.34.208.209) internet accessible application routes; there is an Entrust wildcard SSL cert for this.
  * .pathfinder.bcgov:80/443 (142.34.143.180) - internal-only accessible routes; there is currently NO wildcard SSL cert for this

* BCGov IP 142 Subnets (https://whois.arin.net/rest/org/PBC-51-Z/nets): 
142.22.0.0/16 142.23.0.0/16 142.24.0.0/16 142.25.0.0/16 142.26.0.0/16 142.27.0.0/16 142.28.0.0/16 142.29.0.0/16 142.30.0.0/16 142.31.0.0/16 142.32.0.0/16 142.33.0.0/16 142.34.0.0/16 142.35.0.0/16 142.36.0.0/16

