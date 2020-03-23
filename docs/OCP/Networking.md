---
description: BC Gov OpenShift networking overview
title: BC Gov OpenShift networking overview
---
# OpenShift Networking - Pathfinder Project Config

Pathfinder OpenShift specific implementation notes:
* SDN uses the ovs-multitenant SDN plug-in for configuring the pod network.
* Pathfinder OpenShift is *not* using the F5 plugin. `Routes`  within OpenShift  (similar to `Ingress`) are using the OpenShift-provided HA Proxy functionality. The frontend, Internet-facing load balancer located outside of OpenShift is an F5 (on IP .209) which is simply configured to forward traffic to the HA Proxy instances. The F5 is not tightly integrated with OpenShift. 
* CIDR Range 142.34.143.128/26; Netmask 255.255.255.192; Wildcard Bits 0.0.0.63; First IP 142.34.143.128; Last IP 142.34.143.191
* OpenShift servers are in `VLAN 138` in Kamloops
* Firewall Object: `OCIO-PF-PROD-DMZ` (used as SOURCE)
* Private Network IP Range: 172.51.0.0/16

* Access (ingress) points:
  * console.pathfinder.gov.bc.ca:8443 - (142.34.208.210) API and web UI
  * .pathfinder.gov.bc.ca:80/443 - (142.34.208.209) internet accessible application routes; there is an Entrust wildcard SSL cert for this.
  * .pathfinder.bcgov:80/443 (142.34.143.180) - internal-only accessible routes; there is currently NO wildcard SSL cert for this

* BCGov IP 142 Subnets (https://whois.arin.net/rest/org/PBC-51-Z/nets): 
142.22.0.0/16 142.23.0.0/16 142.24.0.0/16 142.25.0.0/16 142.26.0.0/16 142.27.0.0/16 142.28.0.0/16 142.29.0.0/16 142.30.0.0/16 142.31.0.0/16 142.32.0.0/16 142.33.0.0/16 142.34.0.0/16 142.35.0.0/16 142.36.0.0/16

